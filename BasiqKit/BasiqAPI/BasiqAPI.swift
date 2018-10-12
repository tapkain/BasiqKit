//
//  BasiqAPI.swift
//  BasiqAPI
//
//  Created by Yevhen Velizhenkov on 10/10/18.
//  Copyright © 2018 rexbiteapps. All rights reserved.
//

import Foundation
import Promises

// MARK: - BasiqAPI client
public class BasiqAPI {
  let baseEndpoint: String
  let apiVersion = "2.0"
  
  private let urlSession: URLSession
  private var token: Token?
  public var logRequests = false
  
  init(baseEndpoint: String = "https://au-api.basiq.io",
       urlSession: URLSession = .shared) {
    self.baseEndpoint = baseEndpoint
    self.urlSession = urlSession
  }
  
  @discardableResult
  public func send<T: APIRequest>(
    _ request: T,
    completion: @escaping ResultCallback<T.Response>) -> URLSessionDataTask {
    do {
      request.httpParameters["basiq-version"] = apiVersion
      
      if let token = token {
        request.httpParameters = ["Content-Type": "application/json"]
        request.httpParameters["Authorization"] = "Bearer \(token.accessToken)"
      }
      
      let urlRequest = try makeURLRequest(for: request)
      
      if logRequests {
        print(urlRequest.formattedDescription())
      }
      
      var task: URLSessionDataTask!
      task = urlSession.dataTask(with: urlRequest) { data, response, error in
        do {
          let validData = try ResponseValidator.validateDataTaskResponse(data, response, error)
          let decoder = request.decoder
          print(String(data: validData, encoding: .ascii)!)
          let result = try! decoder.decode(T.Response.self, from: validData)
          completion(.success(result))
        } catch let error as BasiqError {
          task.cancel()
          completion(.failure(error))
          return
        } catch let error {
          task.cancel()
          completion(.failure(BasiqError.requestError(error: error)))
        }
      }
      
      task.resume()
      return task
      
    } catch let error as BasiqError {
      fatalError(error.description)
    } catch {
      fatalError("BasiqAPI internal error.")
    }
  }
}


// MARK: - BasiqAPI promise extension
extension BasiqAPI {
  @discardableResult
  func send<T: APIRequest>(_ request: T) -> Promise<T.Response> {
    return Promise { fulfill, reject in
      self.send(request) {
        switch $0 {
        case .success(let value):
          fulfill(value)
          
        case .failure(let error):
          reject(error)
        }
      }
    }
  }
  
  @discardableResult
  public func connect(apiKey: String) -> Promise<Token> {
    return send(PostTokenRequest(apiKey: apiKey)).then {
      self.token = $0
    }
  }
  
  // TODO: - Add timeout to this function
  @discardableResult
  public func poll(job: Job,
                   update: @escaping ([JobFull.Step]) -> (),
                   interval: TimeInterval = 2) -> Promise<JobFull> {
    let request = GetJobRequest(jobId: job.id)
    return Promise { () -> JobFull? in 
      var jobFull: JobFull!
      
      repeat {
        // Fetch job every X second
        jobFull = try await(self.send(request).delay(interval))
        update(jobFull.steps)
        
        // Check for failure
        if jobFull.steps.reduce(false, { $0 || $1.status == .failed }) {
          throw BasiqError.encoding
        }
        
        // While every job step is not yet successed
      } while !jobFull.steps.reduce(true, { $0 && $1.status == .success })
      
      return jobFull
    }
  }
}

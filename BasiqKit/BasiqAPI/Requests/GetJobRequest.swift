//
//  GetJobRequest.swift
//  BasiqKit
//
//  Created by Yevhen Velizhenkov on 10/12/18.
//  Copyright © 2018 tapkain. All rights reserved.
//

import Foundation

public class GetJobRequest: APIRequest {
  public typealias Response = JobFull
  
  public var resourceName: String
  public var httpMethod: HTTPMethod {
    return .get
  }
  
  public var httpParameters: [String: String] = [:]
  public var queryItems: [String : String]?
  public var httpBody: GetJobRequest.RequestBody?
  
  public var decoder: JSONDecoder {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .formatted(.iso8601Full)
    return decoder
  }
  
  public init(jobId: String) {
    resourceName = "jobs/\(jobId)"
  }
}

//
//  RequestBuilder.swift
//  BasiqAPI
//
//  Created by Yevhen Velizhenkov on 10/10/18.
//  Copyright © 2018 rexbiteapps. All rights reserved.
//

import Foundation

extension BasiqAPI {
  func makeURLRequest<T: APIRequest>(for request: T) throws -> URLRequest {
    guard let url = URL(string: baseEndpoint) else {
      throw BasiqError.requestBuildingError(message: "Failed to build URL from endpoint")
    }
    
    guard var components = URLComponents(url: url.appendingPathComponent(request.resourceName), resolvingAgainstBaseURL: false) else {
      throw BasiqError.requestBuildingError(message: "Failed to build URLComponents from URL")
    }
    
    if let queryItems = request.queryItems {
      components.queryItems = queryItems.map {
        URLQueryItem(name: $0.key, value: $0.value)
      }
    }
    
    guard let builtURL = components.url else {
      throw BasiqError.requestBuildingError(message: "Failed to build URL from URLComponents")
    }
    
    var urlRequest = URLRequest(url: builtURL)
    urlRequest.httpMethod = request.httpMethod.rawValue
    
    request.httpParameters.forEach {
      urlRequest.addValue($0.value, forHTTPHeaderField: $0.key)
    }
    
    if let requestBody = request.httpBody {
      urlRequest.httpBody = try JSONEncoder().encode(requestBody)
    }
    
    return urlRequest
  }
}

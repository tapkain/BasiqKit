//
//  PostTokenRequest.swift
//  BasiqAPI
//
//  Created by Yevhen Velizhenkov on 10/10/18.
//  Copyright © 2018 rexbiteapps. All rights reserved.
//

import Foundation

public class PostTokenRequest: APIRequest {
  public typealias Response = Token
  
  public var resourceName: String {
    return "token"
  }
  
  public var httpMethod: HTTPMethod {
    return .post
  }
  
  public var httpParameters: [String: String]
  public var queryItems: [String : String]?
  public var httpBody: PostTokenRequest.RequestBody?
  
  init(apiKey: String) {
    httpParameters = ["Authorization": "Basic \(apiKey)"]
  }
}

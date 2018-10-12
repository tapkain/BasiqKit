//
//  PostConnectionRequest.swift
//  BasiqAPI
//
//  Created by Yevhen Velizhenkov on 10/11/18.
//  Copyright © 2018 rexbiteapps. All rights reserved.
//

import Foundation

public class PostConnectionRequest: APIRequest {
  public typealias Response = Job
  public typealias RequestBody = PostConnection
  
  public var resourceName: String
  
  public var httpMethod: HTTPMethod {
    return .post
  }
  
  public var httpParameters: [String: String] = [:]
  public var queryItems: [String : String]?
  public var httpBody: PostConnectionRequest.RequestBody?
  
  init(userId: String, connection: PostConnection) {
    resourceName = "users/\(userId)/connections"
    httpBody = connection
  }
}

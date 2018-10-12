//
//  PostUserRequest.swift
//  BasiqAPI
//
//  Created by Yevhen Velizhenkov on 10/11/18.
//  Copyright © 2018 rexbiteapps. All rights reserved.
//

import Foundation

public class PostUserRequest: APIRequest {
  public typealias Response = User
  public typealias RequestBody = PostUser
  
  public var resourceName: String {
    return "users"
  }
  
  public var httpMethod: HTTPMethod {
    return .post
  }
  
  public var httpParameters: [String: String] = [:]
  public var queryItems: [String : String]?
  public var httpBody: PostUserRequest.RequestBody?
  
  init(user: PostUser) {
    httpBody = user
  }
}

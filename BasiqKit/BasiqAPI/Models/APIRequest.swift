//
//  APIRequest.swift
//  BasiqAPI
//
//  Created by Yevhen Velizhenkov on 10/10/18.
//  Copyright © 2018 rexbiteapps. All rights reserved.
//

import Foundation

public enum HTTPMethod: String {
  case post = "POST"
  case get = "GET"
}

public struct EmptyBody: Codable {}

public protocol APIRequest: class, Codable {
  associatedtype Response: Decodable
  associatedtype RequestBody: Encodable = EmptyBody
  
  var httpMethod: HTTPMethod { get }
  var resourceName: String { get }
  var httpParameters: [String: String] { get set }
  var httpBody: RequestBody? { get set }
  var queryItems: [String: String]? { get set }
}

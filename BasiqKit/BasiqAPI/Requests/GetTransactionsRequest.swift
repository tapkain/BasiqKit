//
//  GetTransactionsRequest.swift
//  BasiqAPI
//
//  Created by Yevhen Velizhenkov on 10/11/18.
//  Copyright © 2018 rexbiteapps. All rights reserved.
//

import Foundation

public class GetTransactionsRequest: APIRequest {
  public typealias Response = Transactions
  
  public var resourceName: String
  public var httpMethod: HTTPMethod {
    return .get
  }
  
  public var httpParameters: [String: String] = [:]
  public var queryItems: [String : String]?
  public var httpBody: GetTransactionsRequest.RequestBody?
  
  public var decoder: JSONDecoder {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601
    return decoder
  }
  
  public init(userId: String) {
    resourceName = "users/\(userId)/transactions"
  }
}

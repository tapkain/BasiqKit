//
//  GetInstitutionsRequest.swift
//  BasiqAPI
//
//  Created by Yevhen Velizhenkov on 10/10/18.
//  Copyright © 2018 rexbiteapps. All rights reserved.
//

import Foundation

public class GetInstitutionsRequest: APIRequest {
  public typealias Response = Institutions
  
  public var resourceName: String {
    return "institutions"
  }
  
  public var httpMethod: HTTPMethod {
    return .get
  }
  
  public var httpParameters: [String: String] = [:]
  public var queryItems: [String : String]?
  public var httpBody: GetInstitutionsRequest.RequestBody?
}

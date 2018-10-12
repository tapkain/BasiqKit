//
//  ResponseValidator.swift
//  BasiqAPI
//
//  Created by Yevhen Velizhenkov on 10/10/18.
//  Copyright © 2018 rexbiteapps. All rights reserved.
//

import Foundation

enum ResponseValidator {
  static func validateDataTaskResponse(_ data: Data?, _ response: URLResponse?, _ error: Error?) throws -> Data {
    if let error = error {
      throw BasiqError.requestError(error: error)
    }
    
    guard let data = data else {
      throw BasiqError.noData
    }
    
    guard let response = response as? HTTPURLResponse else {
      fatalError("Response is not HTTPURLResponse")
    }
    
    if !(200...299).contains(response.statusCode) {
      let server = try! JSONDecoder().decode(BasiqErrors.self, from: data)
      throw BasiqError.badResponse(statusCode: response.statusCode, server: server)
    }
    
    return data
  }
}

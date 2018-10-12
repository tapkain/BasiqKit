//
//  BasiqError.swift
//  BasiqAPI
//
//  Created by Yevhen Velizhenkov on 10/10/18.
//  Copyright © 2018 rexbiteapps. All rights reserved.
//

import Foundation

public enum BasiqError: LocalizedError, CustomStringConvertible {
  case parameterTypeNotSupported
  case requestBuildingError(message: String)
  case encoding
  case decoding(error: Error?)
  case noData
  case requestError(error: Error)
  case badResponse(statusCode: Int, server: BasiqErrors)
  
  public var description: String {
    switch self {
    case .parameterTypeNotSupported:
      return "Parameter type not supported."
      
    case .requestBuildingError(let message):
      return "Failed to build request. \(message)"
      
    case .requestError(let error):
      return "Request error. \(error.localizedDescription)"
      
    case .badResponse(let statusCode, let server):
      return "Bad response. Status code (\(statusCode)).\n\(server.description)"
      
    case .decoding(let error):
      return error?.localizedDescription ?? "Decoding error."
      
    default:
      return "CryptoCompareApi internal error."
    }
  }
  
  public var errorDescription: String? {
    return "\nBasiqAPI: \(description)\n"
  }
}

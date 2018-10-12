//
//  BasiqErrors.swift
//  BasiqAPI
//
//  Created by Yevhen Velizhenkov on 10/11/18.
//  Copyright © 2018 rexbiteapps. All rights reserved.
//

import Foundation

public struct BasiqErrors: Codable, CustomStringConvertible {
  public let type: String
  public let correlationId: String
  
  public let data: [Error]
  public struct Error: Codable, CustomStringConvertible {
    public let type: String
    public let code: String
    public let title: String
    public let detail: String
    
    public let source: Source?
    public struct Source: Codable {
      public let pointer: String
      public let parameter: String
    }
    
    public var description: String {
      return "\(code)\n\(title)\n\(detail)"
    }
  }
  
  public var description: String {
    return data.map { $0.description }.joined(separator: "\n")
  }
}

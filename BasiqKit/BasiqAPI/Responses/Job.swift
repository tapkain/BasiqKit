//
//  Job.swift
//  BasiqAPI
//
//  Created by Yevhen Velizhenkov on 10/11/18.
//  Copyright © 2018 rexbiteapps. All rights reserved.
//

import Foundation

public protocol BasicJobProtocol: BasiqResponse {
  var id: String { get }
}

public struct Job: BasicJobProtocol {
  public let type: String
  public var id: String
  public var links: Links
}

public struct JobFull: BasicJobProtocol {
  public let type: String
  public var id: String
  public let created: Date
  public let updated: Date
  
  public let steps: [Step]
  public struct Step: Codable, CustomStringConvertible {
    public let title: String
    
    public let status: Status
    public enum Status: String, Codable {
      case pending
      case inProgress = "in-progress"
      case success
      case failed
    }
    
    public let result: [String: String]?
    
    public var description: String {
      return "\(title) - \(status.rawValue)"
    }
  }
  
  public var links: Links
}

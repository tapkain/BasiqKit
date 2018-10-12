//
//  Account.swift
//  BasiqAPI
//
//  Created by Yevhen Velizhenkov on 10/11/18.
//  Copyright © 2018 rexbiteapps. All rights reserved.
//

import Foundation

public struct Account: BasiqResponse {
  public let type: String
  public let id: String
  public let accountNo: String
  public let name: String
  public let currency: String
  public let balance: String
  public let availableFunds: String
  public let lastUpdated: Date
  
  public let `class`: Class
  public struct Class: Codable {
    public let type: String
    public let product: String
  }
  
  public let status: String
  public var links: Links
}


public struct Accounts: Codable {
  let type: String
  let data: [Account]
}

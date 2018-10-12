//
//  Transaction.swift
//  BasiqAPI
//
//  Created by Yevhen Velizhenkov on 10/11/18.
//  Copyright © 2018 rexbiteapps. All rights reserved.
//

import Foundation

public struct Transaction: BasiqResponse {
  public let type: String
  public let id: String
  public let status: String
  public let description: String
  //public let postDate: Date?
  //public let transactionDate: Date
  public let amount: String
  public let balance: String
  public let bankCategory: String?
  public let account: String
  public let institution: String
  public let connection: String
  public let direction: String
  public let `class`: String
  
  public let subClass: SubClass?
  public struct SubClass: Codable {
    public let code: String
    public let title: String
  }
  
  public let links: Links
}


public struct Transactions: BasiqResponse {
  public let type: String
  public let count: Int
  public let size: Int
  public let data: [Transaction]
  public let links: Links
}

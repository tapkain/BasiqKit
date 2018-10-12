//
//  Connection.swift
//  BasiqAPI
//
//  Created by Yevhen Velizhenkov on 10/11/18.
//  Copyright © 2018 rexbiteapps. All rights reserved.
//

import Foundation

public protocol PostConnectionProtocol: Codable {
  var loginId: String { get set }
  var password: String { get set }
}


public struct PostConnection: PostConnectionProtocol {
  public var loginId: String
  public var password: String
  public var institution: PostInstitution
}


public struct Connection: BasiqResponse, PostConnectionProtocol {
  public let type: String
  public let id: String
  public var loginId: String
  public var password: String
  public var institution: Institution
  public let accounts: Accounts
  public let links: Links
}

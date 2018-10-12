//
//  User.swift
//  BasiqAPI
//
//  Created by Yevhen Velizhenkov on 10/11/18.
//  Copyright © 2018 rexbiteapps. All rights reserved.
//

import Foundation

public struct User: BasiqResponse {
  public let type: String
  public let id: String
  public let email: String
  public let mobile: String
  public let links: Links
}

public struct PostUser: Codable {
  public let email: String
  public let mobile: String
}

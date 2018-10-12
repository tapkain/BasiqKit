//
//  BasiqResponse.swift
//  BasiqAPI
//
//  Created by Yevhen Velizhenkov on 10/10/18.
//  Copyright © 2018 rexbiteapps. All rights reserved.
//

import Foundation


public protocol BasiqResponse: Codable {
  typealias Links = [String: String]
  
  var type: String { get }
  var links: Links { get }
}

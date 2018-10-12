//
//  URLRequest+Description.swift
//  BasiqKit
//
//  Created by Yevhen Velizhenkov on 10/12/18.
//  Copyright © 2018 tapkain. All rights reserved.
//

import Foundation

extension URLRequest {
  func formattedDescription() -> String {
    var d = ""
    d.append("\n\(httpMethod!) \(url!)\n")
    
    if let headers = allHTTPHeaderFields {
      d.append(headers.description)
    }
    
    if let body = httpBody {
      d.append("\n")
      d.append(String(data: body, encoding: .ascii)!)
    }
    
    d.append("\n\n")
    return d
  }
}

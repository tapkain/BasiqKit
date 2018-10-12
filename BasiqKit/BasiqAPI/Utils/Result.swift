//
//  Result.swift
//  BasiqAPI
//
//  Created by Yevhen Velizhenkov on 10/10/18.
//  Copyright © 2018 rexbiteapps. All rights reserved.
//

import Foundation

public enum Result<Value, Error> {
  case success(Value)
  case failure(Error)
}

public typealias ResultCallback<Value> = (Result<Value, BasiqError>) -> Void

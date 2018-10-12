//
//  BasiqAPITests.swift
//  BasiqAPITests
//
//  Created by Yevhen Velizhenkov on 10/10/18.
//  Copyright © 2018 rexbiteapps. All rights reserved.
//

import XCTest
import Promises
@testable import BasiqKit

class BasiqAPITests: XCTestCase {
  private static var api = BasiqAPI()
  private static var user: User!
  private static var institution: Institution!
  
  var apiKey: String {
    if let path = Bundle.main.path(forResource: "Info", ofType: "plist"),
      let data = NSDictionary(contentsOfFile: path) {
      return data["BasiqAPIKey"] as! String
    }
    return ""
  }
  
  override func setUp() {
    super.setUp()
    BasiqAPITests.api.logRequests = true
  }
  
  
  func test1PostTokenRequest() {
    let promise = expectation(description: "Performing request")
    
    BasiqAPITests.api.connect(apiKey: apiKey).then {_ in
      print("Fetched access token")
      promise.fulfill()
    }.catch {
      XCTFail($0.localizedDescription)
    }
    
    waitForExpectations(timeout: 15, handler: nil)
  }
  
  func test2GetInstitutionsRequest() {
    let promise = expectation(description: "Performing request")
    
    BasiqAPITests.api.send(GetInstitutionsRequest()) {
      switch $0 {
      case .success(let institutions):
        print("Fetched \(institutions.totalCount) institutions")
        BasiqAPITests.institution = institutions.data.randomElement()!
        BasiqAPITests.institution.id = "AU00000"
        promise.fulfill()
        
      case .failure(let error):
        XCTFail(error.description)
      }
    }
    
    waitForExpectations(timeout: 15, handler: nil)
  }
  
  func test3PostUserRequest() {
    let promise = expectation(description: "Performing request")
    let postUser = PostUser(email: "test@gmail.com", mobile: "+61410888999")
    
    BasiqAPITests.api.send(PostUserRequest(user: postUser)) {
      switch $0 {
      case .success(let user):
        print("Posted user \(user.email)")
        BasiqAPITests.user = user
        promise.fulfill()
        
      case .failure(let error):
        XCTFail(error.description)
      }
    }
    
    waitForExpectations(timeout: 15, handler: nil)
  }

  func test4PostConnectionRequest() {
    let promise = expectation(description: "Performing request")
    let postInstitution = PostInstitution(BasiqAPITests.institution)
    let connection = PostConnection(loginId: "test@gmail.com", password: "12345", institution: postInstitution)
    let request = PostConnectionRequest(userId: BasiqAPITests.user.id, connection: connection)
    
    BasiqAPITests.api.send(request) {
      switch $0 {
      case .success(_):
        print("Fetched job")
        promise.fulfill()
        
      case .failure(let error):
        XCTFail(error.description)
      }
    }
    
    waitForExpectations(timeout: 15, handler: nil)
  }
  
  func test5GetTransactionsRequest() {
    let promise = expectation(description: "Performing request")
    let request = GetTransactionsRequest(userId: BasiqAPITests.user.id)
    
    BasiqAPITests.api.send(request) {
      switch $0 {
      case .success(let transactions):
        print("Fetched \(transactions.count) transactions")
        promise.fulfill()
        
      case .failure(let error):
        XCTFail(error.description)
      }
    }
    
    waitForExpectations(timeout: 15, handler: nil)
  }
}

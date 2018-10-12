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
  private static var job: Job!
  
  private static let users = [
    "gavinBelson": "hooli2016",
    "jared": "django",
    "richard": "tabsnotspaces"
  ]
  
  // This is always a development API key
  let apiKey = "NzliODQ1N2EtNTAyNi00NDEyLTkxOTMtZGE2N2NmYWM3ZjBiOjMxNGEzNjIzLTAxNWEtNDRhZi1hNDg4LThlZmY1ZDg1YTdjMg=="
  
  override func setUp() {
    super.setUp()
    BasiqAPITests.api.logRequests = true
    DispatchQueue.promises = .global()
  }
  
  
  func test1PostTokenRequest() {
    let promise = expectation(description: "Performing request")
    
    print(apiKey)
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
    let userData = BasiqAPITests.users.randomElement()!
    let connection = PostConnection(loginId: userData.key, password: userData.value, institution: postInstitution)
    let request = PostConnectionRequest(userId: BasiqAPITests.user.id, connection: connection)
    
    BasiqAPITests.api.send(request) {
      switch $0 {
      case .success(let job):
        print("Started job")
        BasiqAPITests.job = job
        promise.fulfill()
        
      case .failure(let error):
        XCTFail(error.description)
      }
    }
    
    waitForExpectations(timeout: 15, handler: nil)
  }
  
  func test5PollJob() {
    let promise = expectation(description: "Performing request")
    var counter = 0
    
    BasiqAPITests.api.poll(job: BasiqAPITests.job, update: {
      counter = counter + 1
      print("\n\nUpdating \(counter) time")
      $0.forEach {
        print("\($0.description)\n")
      }
      print("\n")
    }).then {_ in
      print("Job finished with success!")
      promise.fulfill()
    }.catch {
      XCTFail($0.localizedDescription)
    }
    
    // Big timeout because job can run long time
    waitForExpectations(timeout: 100, handler: nil)
  }
  
  func test6GetTransactionsRequest() {
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
    
    waitForExpectations(timeout: 30, handler: nil)
  }
}

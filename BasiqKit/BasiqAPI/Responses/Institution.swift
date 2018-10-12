//
//  Institution.swift
//  BasiqAPI
//
//  Created by Yevhen Velizhenkov on 10/10/18.
//  Copyright © 2018 rexbiteapps. All rights reserved.
//

import Foundation

public protocol PostInstitutionProtocol: Codable {
  var id: String { get set }
}


public struct PostInstitution: PostInstitutionProtocol {
  public var id: String
  
  init(_ institution: PostInstitutionProtocol) {
    self.id = institution.id
  }
}

public struct Institution: BasiqResponse, PostInstitutionProtocol {
  public let type: String
  public var id: String
  public let name: String
  public let shortName: String
  public let institutionType: String
  public let country: String
  public let serviceName: String
  public let serviceType: String
  public let loginIdCaption: String
  public let passwordCaption: String
  public let tier: String
  public let authorization: String
  
  public let logo: Logo
  public struct Logo: Codable {
    public let type: String
    public let colors: [String: String]?
    public let links: Links
  }
  
  public let links: Links
}


public struct Institutions: BasiqResponse {
  public let type: String
  public let totalCount: Int
  public let data: [Institution]
  public let links: Links
}

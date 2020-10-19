//
//  Models.swift
//  testRxSwift
//
//  Created by PAPADA PREEDAGORN on 19/10/2563 BE.
//  Copyright © 2563 PAPADA PREEDAGORN. All rights reserved.
//

import Foundation

struct Content: Codable {
  var content: [Article]
}

struct Article: Codable {
  var id: Int
  var title: String
  var ingress: String
  var image: String
  var dateTime: String
  var tags: [String]
  var content: [Item]
  var created: Int
  var changed: Int
}

struct Item: Codable{
  var type: String
  var subject: String
  var description: String
}

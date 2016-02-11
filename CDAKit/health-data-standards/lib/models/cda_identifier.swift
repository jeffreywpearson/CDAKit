//
//  cda_identifier.swift
//  CDAKit
//
//  Created by Eric Whitley on 11/30/15.
//  Copyright © 2015 Eric Whitley. All rights reserved.
//

import Foundation
import Mustache

class HDSCDAIdentifier: Equatable, Hashable, HDSJSONInstantiable, CustomStringConvertible {

  var root: String?
  var extension_id: String?
  
  var hashValue: Int {
    return "\(root)\(extension_id)".hashValue
  }
  
  init() {
    
  }
  
  var description: String {
    return "HDSCDAIdentifier => root: \(root), extension_id: \(extension_id)"
  }
  
  required init(event: [String:Any?]) {
    initFromEventList(event)
  }
  
  private func initFromEventList(event: [String:Any?]) {
    for (key, value) in event {
      HDSUtility.setProperty(self, property: key, value: value)
    }
  }

  
  init(root: String?, extension_id: String? = nil) {
    self.root = root
    self.extension_id = extension_id
  }
  
  var as_string: String {
    get {
      var r = ""
      var e = ""
      if let root = root {
        r = root
      }
      if let extension_id = extension_id {
        e = extension_id
      }
      return "\(r)\(r.characters.count > 0 && e.characters.count > 0 ? " " : "")\(e)"
    }
  }
  
}

func == (lhs: HDSCDAIdentifier, rhs: HDSCDAIdentifier) -> Bool {
  return lhs.hashValue == rhs.hashValue
  //self.root == comparison_object.root && self.extension == comparison_object.extension
}


extension HDSCDAIdentifier: MustacheBoxable {
  var mustacheBox: MustacheBox {
      return Box([
        "root": self.root,
        "extension_id": self.root,
        "as_string": self.as_string
      ])
  }
}
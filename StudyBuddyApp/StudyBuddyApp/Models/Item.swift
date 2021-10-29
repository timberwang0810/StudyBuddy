//
//  Item.swift
//  StudyBuddyApp
//
//  Created by Tim Wang on 10/28/21.
//

import Foundation

enum AccessoryItemCategory{
  case Hat
}

enum PlaygroundItemCategory{
  case Wall, Ceiling, Floor
}

protocol Item {
  var name: String {get set}
  var price: Int {get set}
}

struct AccessoryItem : Item{
  var name: String
  var price: Int
  var category : AccessoryItemCategory
  init(name: String, price: Int, category: AccessoryItemCategory){
    self.name = name
    self.price = price
    self.category = category
  }
}

struct PlaygroundItem : Item{
  var name: String
  var price: Int
  var category : PlaygroundItemCategory
  init(name: String, price: Int, category: PlaygroundItemCategory){
    self.name = name
    self.price = price
    self.category = category
  }
}

import Foundation

enum AccessoryItemCategory{
  case Hat
}

enum PlaygroundItemCategory{
  case Wall, Ceiling, Floor
}

protocol Item{
  var name: String {get set}
  var price: Int {get set}
}

//extension Item{
//
//  static func == (lhs: Item, rhs: Item) -> Bool {
//    print(lhs.name)
//    print(rhs.name)
//    return lhs.name == rhs.name
//  }
//
//  func hash(into hasher: inout Hasher) {
//      hasher.combine(name)
//      hasher.combine(price)
//  }
//}

struct AccessoryItem : Item, Equatable, Hashable{
  var name: String
  var price: Int
  var category : AccessoryItemCategory
  init(name: String, price: Int, category: AccessoryItemCategory){
    self.category = category
    self.name = name
    self.price = price
  }
  static func == (lhs: AccessoryItem, rhs: AccessoryItem) -> Bool {
    return lhs.name == rhs.name
  }

  func hash(into hasher: inout Hasher) {
      hasher.combine(name)
      hasher.combine(price)
  }
}

struct PlaygroundItem : Item, Equatable, Hashable{
  var name: String
  var price: Int
  var category : PlaygroundItemCategory
  init(name: String, price: Int, category: PlaygroundItemCategory){
    self.category = category
    self.name = name
    self.price = price
  }
  static func == (lhs: PlaygroundItem, rhs: PlaygroundItem) -> Bool {
    return lhs.name == rhs.name
  }

  func hash(into hasher: inout Hasher) {
      hasher.combine(name)
      hasher.combine(price)
  }
}

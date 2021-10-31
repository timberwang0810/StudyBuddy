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

extension Item{
  var name: String {get {"Name"} set{self.name = newValue}}
  var price: Int {get{100} set{self.price = newValue}}
  
  static func == (lhs: Item, rhs: Item) -> Bool {
      return lhs.name == rhs.name && lhs.price == rhs.price
  }

  func hash(into hasher: inout Hasher) {
      hasher.combine(name)
      hasher.combine(price)
  }
}

struct AccessoryItem : Item, Equatable, Hashable{
  var category : AccessoryItemCategory
  init(name: String, price: Int, category: AccessoryItemCategory){
    self.category = category
    self.name = name
    self.price = price
  }
  
  static func == (lhs: AccessoryItem, rhs: AccessoryItem) -> Bool{
    return lhs.name == rhs.name
  }
}

struct PlaygroundItem : Item, Equatable, Hashable{
  var category : PlaygroundItemCategory
  init(name: String, price: Int, category: PlaygroundItemCategory){
    self.category = category
    self.name = name
    self.price = price
  }
  static func == (lhs: PlaygroundItem, rhs: PlaygroundItem) -> Bool{
    return lhs.name == rhs.name
  }
}

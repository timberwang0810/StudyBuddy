import Foundation

enum AccessoryItemCategory{
  case Hat
}

enum PlaygroundItemCategory{
  case Wall, Ceiling, Floor
}

protocol Item : Hashable{
  var name: String {get set}
  var price: Int {get set}
}

extension Item{
  var name: String {
    return "ItemName"
  }
  var price: Int {
    return 100
  }
  var isPurchased : Bool {
    return false
  }
  static func == (lhs: Self, rhs: Self) -> Bool {
    return lhs.name == rhs.name
  }
  func hash(into hasher: inout Hasher) {
      hasher.combine(name)
      hasher.combine(price)
  }
}

struct AccessoryItem : Item{
  var name: String
  var price: Int
  var category : AccessoryItemCategory
  init(name: String, price: Int, category: AccessoryItemCategory){
    self.category = category
    self.name = name
    self.price = price
  }
  
}

struct PlaygroundItem : Item{
  var name: String
  var price: Int
  var category : PlaygroundItemCategory
  init(name: String, price: Int, category: PlaygroundItemCategory){
    self.category = category
    self.name = name
    self.price = price
  }
}

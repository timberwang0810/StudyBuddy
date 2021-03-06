import Foundation

enum AccessoryItemCategory:String{
  case Hat = "Hat"
}

enum PlaygroundItemCategory:String{
  case Wall = "Wall"
  case Ceiling = "Ceiling"
  case Floor = "Floor"
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
  var image: String {
    return "image_name"
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
  var image: String
  var category : AccessoryItemCategory
  init(name: String, price: Int, image: String, category: AccessoryItemCategory){
    self.category = category
    self.name = name
    self.price = price
    self.image = image
  }
  
}

struct Vector2 : Hashable {
    let x: Float
    let y: Float
    init(x: Float, y: Float) {
        self.x = x
        self.y = y
    }
}

struct PlaygroundItem : Item{
  var name: String
  var price: Int
  var image: String
  var category : PlaygroundItemCategory
    var position: Vector2
    init(name: String, price: Int, image: String, category: PlaygroundItemCategory, position: Vector2){
    self.category = category
    self.name = name
    self.price = price
    self.image = image
    self.position = position
  }
}

import Foundation

class Character{
  private var name: String
  private var wardrobe: [AccessoryItem]
  private var currentClothes: [AccessoryItemCategory: AccessoryItem]
  private var numNewItem: Int
  
  init(name: String){
    self.name = name
    self.wardrobe = []
    self.currentClothes = [:]
    self.numNewItem = 0
  }
  
  public func getAllWardrobeItems() -> [AccessoryItem] {
    return wardrobe
  }
  
  public func getAllCurrentClothes() -> [AccessoryItemCategory: AccessoryItem]{
    return currentClothes
  }
  
  public func getName() -> String {
    return self.name
  }
  
  public func setName(name: String){
    self.name = name
  }
  
  public func onNewItemPurchased(item: AccessoryItem){
    self.wardrobe.append(item)
    self.numNewItem+=1
  }
  
  public func wearItem(item: AccessoryItem){
    if (!self.wardrobe.contains(item)){
      return
    }
    for (index, element) in self.wardrobe.enumerated(){
      if (element == item){
        self.wardrobe.remove(at: index)
        break
      }
    }
    moveIntoWardrobe(itemCategory: item.category)
    self.currentClothes[item.category] = item
  }
  
  public func moveIntoWardrobe(itemCategory: AccessoryItemCategory){
    if let item = self.currentClothes[itemCategory]{
      self.currentClothes.removeValue(forKey: itemCategory)
      self.wardrobe.append(item)
    }
  }
  
  public func getNumNewItem() -> Int{
    return self.numNewItem
  }
  
  public func resetNumNewItem(){
    self.numNewItem = 0
  }
}

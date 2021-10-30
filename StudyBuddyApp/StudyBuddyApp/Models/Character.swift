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
    wardrobe.append(item)
    numNewItem+=1
  }
  
  public func wearItem(item: AccessoryItem){
    for (index, element) in self.wardrobe.enumerated(){
      if (element == item){
        self.wardrobe.remove(at: index)
        break
      }
    }
    currentClothes[item.category] = item
  }
  
  public func moveIntoWardrobe(item: AccessoryItem){
    currentClothes.removeValue(forKey: item.category)
    wardrobe.append(item)
  }
  
  public func getNumNewItem() -> Int{
    return numNewItem
  }
  
  public func resetNumNewItem(){
    numNewItem = 0
  }
}

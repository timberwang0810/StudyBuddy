import Foundation

class Playground{
  private var decorations: [PlaygroundItemCategory: PlaygroundItem]
  private var storage: [PlaygroundItem]
  private var numNewItem: Int
  
  init(){
    self.decorations = [:]
    self.storage = []
    self.numNewItem = 0
  }
  
  public func getAllDecorations() -> [PlaygroundItemCategory: PlaygroundItem]{
    return decorations
  }
  
  public func getAllStorageItems() -> [PlaygroundItem] {
    return storage
  }
  
  public func onNewItemPurchased(item: PlaygroundItem){
    storage.append(item)
    numNewItem+=1
  }
  
  public func moveIntoPlayground(item: PlaygroundItem){
    if (!self.storage.contains(item)){
      return
    }
    for (index, element) in self.storage.enumerated(){
      if (element == item){
        self.storage.remove(at: index)
        break
      }
    }
    moveIntoStorage(itemCategory: item.category)
    self.decorations[item.category] = item
  }
  
  public func moveIntoStorage(itemCategory: PlaygroundItemCategory){
    if let item = self.decorations[itemCategory]{
      self.decorations.removeValue(forKey: itemCategory)
      self.storage.append(item)
    }
  }
  
  public func getNumNewItem() -> Int{
    return numNewItem
  }
  
  public func resetNumNewItem(){
    numNewItem = 0
  }
}

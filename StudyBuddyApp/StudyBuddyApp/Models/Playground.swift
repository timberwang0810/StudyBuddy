import Foundation

class Playground{
  private var decorations: [PlaygroundItemCategory: [PlaygroundItem]]
  private var storage: [PlaygroundItem]
  private var numNewItem: Int
  
  init(){
    self.decorations = [PlaygroundItemCategory.Ceiling: [], PlaygroundItemCategory.Floor: [], PlaygroundItemCategory.Wall: []]
    self.storage = []
    self.numNewItem = 0
  }
  
  public func getAllDecorations() -> [PlaygroundItemCategory: [PlaygroundItem]]{
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
    if var arr = self.decorations[item.category]{
      arr.append(item)
      self.decorations[item.category] = arr
    }
  }
  
  public func moveIntoStorage(item: PlaygroundItem){
    if var arr = self.decorations[item.category]{
      if (!arr.contains(item)){
        return
      }
      for (index, element) in arr.enumerated(){
        if (element == item){
          arr.remove(at: index)
          self.decorations[item.category] = arr
          break
        }
      }
      storage.append(item)
    }
  }
  
  public func getNumNewItem() -> Int{
    return numNewItem
  }
  
  public func resetNumNewItem(){
    numNewItem = 0
  }
}

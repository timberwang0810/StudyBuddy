import Foundation

class Store {
  private var accessoryItems: [AccessoryItem]
  private var playgroundItems: [PlaygroundItem]
  
  init(){
    self.accessoryItems = []
    self.playgroundItems = []
  }
  
  public func getAllAccessoryItems() -> [AccessoryItem]{
    return accessoryItems
  }
  
  public func getAllPlaygroundItems() -> [PlaygroundItem]{
    return playgroundItems
  }
  
  public func getAllItems() -> [Item]{
    return accessoryItems + playgroundItems
  }
  
  public func addAccessoryItem(item: AccessoryItem){
    accessoryItems.append(item)
  }
  
  public func addPlaygroundItem(item: PlaygroundItem){
    playgroundItems.append(item)
  }
  
  public func removeAccessoryItem(item: AccessoryItem){
    for (index, element) in self.accessoryItems.enumerated(){
      if (element == item){
        self.accessoryItems.remove(at: index)
        break
      }
    }
  }
  
  public func removePlaygroundItem(item: PlaygroundItem){
    for (index, element) in self.playgroundItems.enumerated(){
      if (element == item){
        self.playgroundItems.remove(at: index)
        break
      }
    }
  }
  
  public func hasAccessoryItem(item: AccessoryItem) -> Bool {
    return accessoryItems.contains(item)
  }
  
  public func hasPlaygroundItem(item: PlaygroundItem) -> Bool {
    return playgroundItems.contains(item)
  }
}

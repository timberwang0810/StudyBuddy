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
  
  public func purchaseAccessoryItem(item: AccessoryItem, character: Character){
    for (index, element) in self.accessoryItems.enumerated(){
      if (element == item){
        self.accessoryItems.remove(at: index)
        break
      }
    }
    character.onNewItemPurchased(item: item)
  }
  
  public func purchasePlaygroundItem(item: PlaygroundItem, playground: Playground){
    for (index, element) in self.playgroundItems.enumerated(){
      if (element == item){
        self.playgroundItems.remove(at: index)
        break
      }
    }
    playground.onNewItemPurchased(item: item)
  }
}

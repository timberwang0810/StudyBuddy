import Foundation

class Store {
  private var accessoryItems: [AccessoryItem]
  private var playgroundItems: [PlaygroundItem]
  
  private var purchasedAccessoryItems: [AccessoryItem]
  private var purchasedPlaygroundItems: [PlaygroundItem]
  
  init(){
    self.accessoryItems = []
    self.playgroundItems = []
    self.purchasedAccessoryItems = []
    self.purchasedPlaygroundItems = []
  }
  
  public func getAllAccessoryItems() -> [AccessoryItem]{
    return accessoryItems + purchasedAccessoryItems
  }
  
  public func getAccessoryItemsByCategory(category: AccessoryItemCategory) -> [AccessoryItem]{
    return accessoryItems.filter{$0.category == category} + purchasedAccessoryItems.filter{$0.category == category}
  }
  
  public func getAllPlaygroundItems() -> [PlaygroundItem]{
    return playgroundItems + purchasedPlaygroundItems
  }
  
  public func getAllPurchasedPlaygroundItems() -> [PlaygroundItem]{
    return purchasedPlaygroundItems
  }
  
  public func getPlaygroundItemsByCategory(category: PlaygroundItemCategory) -> [PlaygroundItem]{
    return playgroundItems.filter{$0.category == category} + purchasedPlaygroundItems.filter{$0.category == category}
  }
  
  public func addAccessoryItem(item: AccessoryItem){
    accessoryItems.append(item)
  }
  
  public func addPlaygroundItem(item: PlaygroundItem){
    playgroundItems.append(item)
  }
  
  public func markAccessoryItemAsPurhcased(item:AccessoryItem){
    for (index, element) in self.accessoryItems.enumerated(){
      if (element == item){
        self.accessoryItems.remove(at: index)
        self.purchasedAccessoryItems.append(item)
        break
      }
    }
  }
  
  public func markPlaygroundItemAsPurchased(item: PlaygroundItem){
    for (index, element) in self.playgroundItems.enumerated(){
      if (element == item){
        self.playgroundItems.remove(at: index)
        self.purchasedPlaygroundItems.append(item)
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

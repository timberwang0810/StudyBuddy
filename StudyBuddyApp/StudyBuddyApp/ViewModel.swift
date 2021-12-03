//
//  ViewModel.swift
//  StudyBuddyApp
//
//  Created by austin on 10/27/21.
//

import SwiftUI
import CoreData

// Contains model logic we want to access from views through published variables.
// Write functions in here to be called that change models (e.g. when a button is clicked)
class ViewModel: ObservableObject {
  let appDelegate: AppDelegate = AppDelegate()
  
  //  State we want to update view with when it changes
  @Published var currentTask: Task?
  @Published var store: Store = Store()
  @Published var playground: Playground = Playground()
  @Published var character: Character = Character(name: "Bob")
  @Published var user: User = User()
  @Published var showTaskErrorMessage: Bool = false
  
  private var storeNeedUpdate: Bool = true
  private var playgroundNeedUpdate: Bool = true
  private var characterNeedUpdate: Bool = true
  
  func createTask(name: String, duration: TimeInterval, category: TaskCategory, isStarted: Bool, completion: @escaping () -> Void) {
    if (name == "") {
      showTaskErrorMessage = true
      return
    }
    showTaskErrorMessage = false
    
    currentTask = Task(name: name, duration: duration, category: category)
    if (isStarted) {
      currentTask?.start()
    }
    
    print("Created Task:")
    print("Name: \(currentTask!.name)")
    print("Duration: \(currentTask!.duration)")
    print("Category: \(currentTask!.category)")
    
    completion()
  }
  
  func stopTask(timeRemaining: TimeInterval){
    currentTask!.complete(timeRemaining: timeRemaining)
  }
  
  func getTaskName() -> String{
    return currentTask!.name
  }
  
  func getTaskReward() -> Int{
    return currentTask!.finalReward
  }
  
  func getBaseReward() -> Int{
    return currentTask!.baseReward
  }
  
  func getTimedReward() -> Int {
    return currentTask!.timedReward
  }
  
  func getBonusReward() -> Int{
    return currentTask!.bonusReward
  }
  
  func earnMoney(inc: Int) {
    user.earnMoney(inc: inc)
    saveUserData()
  }
  
  func getCurrentMoney() -> Int{
    return user.getMoney()
  }

  func getStoreItems() -> [PlaygroundItem]{
    return store.getAllPlaygroundItems().sorted(by: {$0.price < $1.price})
  }
  
  func getAllPlaygroundItems() -> [PlaygroundItem] {
    return playground.getAllDecorations().values + playground.getAllStorageItems()
  }
  
  func isItemPurchased(item: PlaygroundItem) -> Bool {
    return store.getAllPurchasedPlaygroundItems().contains(item)
  }
  
  func isItemInUse(item: PlaygroundItem) -> Bool {
    return item == playground.getAllDecorations()[item.category]
  }
  
  
  func togglePlaygroundItem(item: PlaygroundItem){
    if (isItemInUse(item: item)) {
      playground.moveIntoStorage(itemCategory: item.category)
      saveItemData(itemName: item.name, isPurchased: true, isEquipped: false)
    } else {
      if let equippedItem = playground.getAllDecorations()[item.category]{
        saveItemData(itemName: equippedItem.name, isPurchased: true, isEquipped: false)
      }
      playground.moveIntoPlayground(item: item)
      saveItemData(itemName: item.name, isPurchased: true, isEquipped: true)
    }
  }
  
  func buyStorePlaygroundItem(item: PlaygroundItem) -> Bool{
    return user.purchasePlaygroundItem(item: item, playground: playground, store: store)
  }
  
  func saveItemData(itemName: String, isPurchased: Bool, isEquipped: Bool){
    let context = appDelegate.persistentContainer.viewContext
    if NSEntityDescription.entity(forEntityName: "ItemEntity", in: context) != nil{
      let itemList = fetchRecordsForEntity("ItemEntity", inManagedObjectContext: context)
      for item in itemList{
        if ((item.value(forKey:"name") as? String ?? "" ) == itemName){
          item.setValue(isPurchased, forKey: "isPurchased")
          item.setValue(isEquipped, forKey: "isEquipped")
          break;
        }
      }
      storeNeedUpdate = true
      playgroundNeedUpdate = true
      characterNeedUpdate = true
      do {
        try context.save()
      } catch {
        NSLog("[Contacts] ERROR: Failed to save User data")
      }
    }
  }
  
  func fetchItemData(modelName: String){
    let context = appDelegate.persistentContainer.viewContext
    
    if let entity = NSEntityDescription.entity(forEntityName: "ItemEntity", in: context){
      let result = fetchRecordsForEntity("ItemEntity", inManagedObjectContext: context)
      switch (modelName){
      case "store":
        if (storeNeedUpdate){
          if result.count == 0{
            // init for first time only
            var initialItems : [PlaygroundItem] = []
            for index in 1...5 {
                let painting = PlaygroundItem(name: "Painting \(index)", price: index * 20 + index, image: "hill_painting", category: PlaygroundItemCategory.Wall, position: Vector2(x: 0.25, y: 0.7))
                let carpet = PlaygroundItem(name: "Lamp \(index)", price: index  * 25 + index, image: "yellow_lamp", category: PlaygroundItemCategory.Floor, position: Vector2(x: 0.75, y: 0.4))

              store.addPlaygroundItem(item: painting)
              store.addPlaygroundItem(item: carpet)
              initialItems.append(painting)
              initialItems.append(carpet)
            }
            for item in initialItems{
              let newItem = NSManagedObject(entity: entity, insertInto: context)
              newItem.setValue(item.name, forKey: "name")
              newItem.setValue(item.price, forKey: "price")
              newItem.setValue(item.position.x, forKey: "pos_x")
              newItem.setValue(item.position.y, forKey: "pos_y")
              newItem.setValue(item.category.rawValue, forKey: "category")
              newItem.setValue(item.image, forKey: "image")
              newItem.setValue(false, forKey: "isEquipped")
              newItem.setValue(false, forKey: "isPurchased")
              newItem.setValue(true, forKey: "isPlayground") // UPDATE THIS LOGIC IF WE HAVE ACCESSORY ITEM
            }
            do {
              try context.save()
            } catch {
              NSLog("[Contacts] ERROR: Failed to save Item data")
            }
          }
          else{
            for data in result{
              let name = data.value(forKey: "name") as? String ?? ""
              let price = data.value(forKey: "price") as? Int ?? 0
              let image = data.value(forKey: "image") as? String ?? ""
              let category = data.value(forKey: "category") as? String ?? ""
              let pos_x = data.value(forKey: "pos_x") as? Float ?? 0
              let pos_y = data.value(forKey: "pos_y") as? Float ?? 0
              let isPlayground = data.value(forKey: "isPlayground") as? Bool ?? false
              let isPurchased = data.value(forKey: "isPurchased") as? Bool ?? false
              if (isPlayground){
                let item = PlaygroundItem(name:name, price: price, image: image, category: PlaygroundItemCategory(rawValue: category)!, position: Vector2(x: pos_x, y: pos_y))
                store.addPlaygroundItem(item: item)
                if (isPurchased){
                  store.markPlaygroundItemAsPurchased(item: item)
                }
              }
              else{
                let item = AccessoryItem(name:name, price: price, image: image, category: AccessoryItemCategory(rawValue: category)!)
                store.addAccessoryItem(item: item)
                if (isPurchased){
                  store.markAccessoryItemAsPurchased(item: item)
                }
              }
            }
          }
          storeNeedUpdate = false
        }
        break
      case "playground":
        if (playgroundNeedUpdate){
          for data in result{
            let name = data.value(forKey: "name") as? String ?? ""
            let price = data.value(forKey: "price") as? Int ?? 0
            let image = data.value(forKey: "image") as? String ?? ""
            let category = data.value(forKey: "category") as? String ?? ""
            let pos_x = data.value(forKey: "pos_x") as? Float ?? 0
            let pos_y = data.value(forKey: "pos_y") as? Float ?? 0
            let isPlayground = data.value(forKey: "isPlayground") as? Bool ?? false
            let isPurchased = data.value(forKey: "isPurchased") as? Bool ?? false
            let isEquipped = data.value(forKey: "isEquipped") as? Bool ?? false
            if (isPlayground && isPurchased){
                let item = PlaygroundItem(name:name, price: price, image: image, category: PlaygroundItemCategory(rawValue: category)!, position: Vector2(x: pos_x, y: pos_y))
              playground.onNewItemPurchased(item: item)
              if (isEquipped){
                playground.moveIntoPlayground(item: item)
              }
            }
          }
          playgroundNeedUpdate = false
        }
        break
      case "character":
        if (characterNeedUpdate){
          for data in result{
            let name = data.value(forKey: "name") as? String ?? ""
            let price = data.value(forKey: "price") as? Int ?? 0
            let image = data.value(forKey: "image") as? String ?? ""
            let category = data.value(forKey: "category") as? String ?? ""
            let isPlayground = data.value(forKey: "isPlayground") as? Bool ?? false
            let isPurchased = data.value(forKey: "isPurchased") as? Bool ?? false
            let isEquipped = data.value(forKey: "isEquipped") as? Bool ?? false
            if (!isPlayground && isPurchased){
              let item = AccessoryItem(name:name, price: price, image: image, category: AccessoryItemCategory(rawValue: category)!)
              character.onNewItemPurchased(item: item)
              if (isEquipped){
                character.wearItem(item: item)
              }
            }
          }
          characterNeedUpdate = false
        }
        break
      default:
        break
      }
    }
  }
  
  func updateItemData(viewToUpdate: String){
    switch (viewToUpdate.lowercased()){
    case "store":
      if (storeNeedUpdate){
        store = Store()
      }
      break
    case "character":
      if (characterNeedUpdate){
        let name = character.getName()
        character = Character(name: name)
      }
      break
    case "playground":
      if (playgroundNeedUpdate){
        playground = Playground()
      }
      break
    default:
      break
    }
    fetchItemData(modelName: viewToUpdate)
  }
  
  func saveUserData(){
    let context = appDelegate.persistentContainer.viewContext
    if let entity = NSEntityDescription.entity(forEntityName: "UserEntity", in: context){
      let userList = fetchRecordsForEntity("UserEntity", inManagedObjectContext: context)
      if let userObj = userList.first{
        userObj.setValue(user.getMoney(), forKey: "money")
      }
      else{
        let newUser = NSManagedObject(entity: entity, insertInto: context)
        newUser.setValue(user.getMoney(), forKey: "money")
      }
      do {
        try context.save()
      } catch {
        NSLog("[Contacts] ERROR: Failed to save User data")
      }
    }
  }
  
  func fetchUserData(){
    let context = appDelegate.persistentContainer.viewContext
    let result = fetchRecordsForEntity("UserEntity", inManagedObjectContext: context)
    if let userObj = result.first{
      user.earnMoney(inc: (userObj.value(forKey: "money") as? Int ?? 0))
      NSLog("User data loaded from CoreData")
    }
  }
  
  func updateUserData(){
    user = User()
    fetchUserData()
  }
  
  private func fetchRecordsForEntity(_ entity: String, inManagedObjectContext managedObjectContext: NSManagedObjectContext) -> [NSManagedObject] {
    // Create Fetch Request
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
    
    // Helpers
    var result = [NSManagedObject]()
    
    do {
      // Execute Fetch Request
      let records = try managedObjectContext.fetch(fetchRequest)
      
      if let records = records as? [NSManagedObject] {
        result = records
      }
      
    } catch {
      print("Unable to fetch managed objects for entity \(entity).")
    }
    
    return result
  }
  
  func deleteEntityData(entityName: String){
    let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entityName)
    let myPersistentStoreCoordinator = appDelegate.persistentContainer.persistentStoreCoordinator

    let context = appDelegate.persistentContainer.viewContext

    let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

    do {
        try myPersistentStoreCoordinator.execute(deleteRequest, with: context)
    } catch let error as NSError {
      print(error.code)
    }
  }
  
}


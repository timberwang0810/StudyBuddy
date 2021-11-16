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
  
  func getTaskReward() -> Int{
    return currentTask!.finalReward
  }
  
  func earnMoney(inc: Int) {
    user.earnMoney(inc: inc)
    saveUserData()
  }
  
  func getCurrentMoney() -> Int{
    return user.getMoney()
  }
  
  func getAllPlaygroundItems() -> [PlaygroundItem] {
    if (playground.getNumNewItem() == 0) {
      // Hardcode items for now
      for index in 1...5 {
        let painting = PlaygroundItem(name: "Painting \(index)", price: 400, image: "hill_painting", category: PlaygroundItemCategory.Wall)
        let carpet = PlaygroundItem(name: "Lamp \(index)", price: 500, image: "yellow_lamp", category: PlaygroundItemCategory.Floor)
        
        playground.onNewItemPurchased(item: painting)
        playground.onNewItemPurchased(item: carpet)
      }
    }
    
    return playground.getAllDecorations().values + playground.getAllStorageItems()
  }
  
  func isItemInUse(item: PlaygroundItem) -> Bool {
    return item == playground.getAllDecorations()[item.category]
  }
  
  func togglePlaygroundItem(item: PlaygroundItem) {
    if (isItemInUse(item: item)) {
      playground.moveIntoStorage(itemCategory: item.category)
    } else {
      playground.moveIntoPlayground(item: item)
    }
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
}


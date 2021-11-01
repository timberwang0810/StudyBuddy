//
//  UserTest.swift
//  StudyBuddyAppTests
//
//  Created by Tim Wang on 10/30/21.
//

import XCTest
@testable import StudyBuddyApp

class UserTest: XCTestCase {

  let store: Store = Store()
  let character: Character = Character(name: "Bob")
  let playground: Playground = Playground()
  var sut : User!
    
  override func setUpWithError() throws {
    try super.setUpWithError()
    sut = User(store: store, character: character, playground: playground)
  }

  override func tearDownWithError() throws {
    
  }

  func testInitialization() throws {
    XCTAssertEqual(sut.getMoney(), 0)
    XCTAssertEqual(sut.getTasks().count,0)
    XCTAssertEqual(sut.getCurrentAppState(), CurrentTaskState.Idle)
  }
  
  func testGetAllTasks() throws {
    let task1: Task = Task(name: "Study 443", duration: 20000, category: TaskCategory.STUDY)
    let task2: Task = Task(name: "Work my butt off", duration: 40000, category: TaskCategory.WORK)
    let task3: Task = Task(name: "Do Laundry", duration: 30000, category: TaskCategory.CHORES)
    let task4: Task = Task(name: "Bench", duration: 10000, category: TaskCategory.EXERCISE)
    let task5: Task = Task(name: "Take a fat nap", duration: 50000, category: TaskCategory.OTHER)
    sut.addTask(newTask: task1)
    sut.addTask(newTask: task2)
    sut.addTask(newTask: task3)
    sut.addTask(newTask: task4)
    sut.addTask(newTask: task5)
    let tasks = sut.getTasks()
    XCTAssertEqual(tasks.count,5)
    XCTAssertTrue(tasks.contains(task1))
    XCTAssertTrue(tasks.contains(task2))
    XCTAssertTrue(tasks.contains(task3))
    XCTAssertTrue(tasks.contains(task4))
    XCTAssertTrue(tasks.contains(task5))
  }

  func testAddTasks() throws {
    let task1: Task = Task(name: "Study 443", duration: 20000, category: TaskCategory.STUDY)
    XCTAssertEqual(sut.getTasks().count,0)
    sut.addTask(newTask: task1)
    XCTAssertEqual(sut.getTasks().count,1)
    let task2: Task = Task(name: "Work my butt off", duration: 40000, category: TaskCategory.WORK)
    let task3: Task = Task(name: "Do Laundry", duration: 30000, category: TaskCategory.CHORES)
    let task4: Task = Task(name: "Bench", duration: 10000, category: TaskCategory.EXERCISE)
    let task5: Task = Task(name: "Take a fat nap", duration: 50000, category: TaskCategory.OTHER)
    sut.addTask(newTask: task2)
    sut.addTask(newTask: task3)
    sut.addTask(newTask: task4)
    sut.addTask(newTask: task5)
    XCTAssertEqual(sut.getTasks().count,5)
  }
  
  func testRemoveTasks() throws {
    let task1: Task = Task(name: "Study 443", duration: 20000, category: TaskCategory.STUDY)
    let task2: Task = Task(name: "Work my butt off", duration: 40000, category: TaskCategory.WORK)
    let task3: Task = Task(name: "Do Laundry", duration: 30000, category: TaskCategory.CHORES)
    let task4: Task = Task(name: "Bench", duration: 10000, category: TaskCategory.EXERCISE)
    let task5: Task = Task(name: "Take a fat nap", duration: 50000, category: TaskCategory.OTHER)
    sut.addTask(newTask: task1)
    sut.addTask(newTask: task2)
    sut.addTask(newTask: task3)
    sut.addTask(newTask: task4)
    sut.addTask(newTask: task5)
    var tasks = sut.getTasks()
    XCTAssertEqual(tasks.count,5)
    sut.removeTask(task: task4)
    tasks = sut.getTasks()
    XCTAssertEqual(tasks.count,4)
    XCTAssertFalse(tasks.contains(task4))
    XCTAssertTrue(tasks.contains(task1))
    XCTAssertTrue(tasks.contains(task2))
    XCTAssertTrue(tasks.contains(task3))
    XCTAssertTrue(tasks.contains(task5))
    sut.removeTask(task: task3)
    sut.removeTask(task: task1)
    tasks = sut.getTasks()
    XCTAssertEqual(tasks.count, 2)
    XCTAssertFalse(tasks.contains(task4))
    XCTAssertFalse(tasks.contains(task3))
    XCTAssertFalse(tasks.contains(task1))
    XCTAssertTrue(tasks.contains(task2))
    XCTAssertTrue(tasks.contains(task5))
    sut.removeTask(task: task5)
    sut.removeTask(task: task2)
    tasks = sut.getTasks()
    XCTAssertEqual(tasks.count, 0)
    XCTAssertFalse(tasks.contains(task4))
    XCTAssertFalse(tasks.contains(task3))
    XCTAssertFalse(tasks.contains(task1))
    XCTAssertFalse(tasks.contains(task2))
    XCTAssertFalse(tasks.contains(task5))
  }
  
  func testEarnMoney() throws {
    XCTAssertEqual(sut.getMoney(), 0)
    sut.earnMoney(inc: 100)
    XCTAssertEqual(sut.getMoney(), 100)
    sut.earnMoney(inc: 10)
    sut.earnMoney(inc: 250)
    XCTAssertEqual(sut.getMoney(), 360)
  }
  
  func testSpendMoney() throws {
    sut.earnMoney(inc: 400)
    XCTAssertEqual(sut.getMoney(), 400)
    sut.spendMoney(dec: 100)
    XCTAssertEqual(sut.getMoney(), 300)
    sut.spendMoney(dec: 10)
    sut.spendMoney(dec: 250)
    XCTAssertEqual(sut.getMoney(), 40)
  }
  
  func testGetandSetCurrentAppState() throws {
    XCTAssertEqual(sut.getCurrentAppState(), CurrentTaskState.Idle)
    sut.updateCurrentAppState(newState: CurrentTaskState.Completed)
    XCTAssertEqual(sut.getCurrentAppState(), CurrentTaskState.Completed)
    sut.updateCurrentAppState(newState: CurrentTaskState.Idle)
    sut.updateCurrentAppState(newState: CurrentTaskState.Started)
    XCTAssertEqual(sut.getCurrentAppState(), CurrentTaskState.Started)
  }
  
  func testPurchaseAccessoryItem() throws {
    let beanie = AccessoryItem(name: "Beanie", price: 300, category: AccessoryItemCategory.Hat)
    let cowboy = AccessoryItem(name: "Cowboy Hat", price: 200, category: AccessoryItemCategory.Hat)
    let baseball = AccessoryItem(name: "Baseball Hat", price: 150, category: AccessoryItemCategory.Hat)
    store.addAccessoryItem(item: beanie)
    store.addAccessoryItem(item: cowboy)
    store.addAccessoryItem(item: baseball)
    sut.earnMoney(inc: 600)
    XCTAssertEqual(sut.getMoney(), 600)
    XCTAssertEqual(store.getAllAccessoryItems().count, 3)
    XCTAssertTrue(store.hasAccessoryItem(item: beanie))
    XCTAssertTrue(store.hasAccessoryItem(item: cowboy))
    XCTAssertTrue(store.hasAccessoryItem(item: baseball))
    XCTAssertFalse(character.getAllWardrobeItems().contains(beanie))
    XCTAssertFalse(character.getAllWardrobeItems().contains(cowboy))
    XCTAssertFalse(character.getAllWardrobeItems().contains(baseball))
    
    XCTAssertTrue(sut.purchaseAccessoryItem(item: beanie))
    
    XCTAssertEqual(store.getAllAccessoryItems().count, 2)
    XCTAssertFalse(store.hasAccessoryItem(item: beanie))
    XCTAssertEqual(sut.getMoney(), 300)
    XCTAssertTrue(character.getAllWardrobeItems().contains(beanie))
    XCTAssertFalse(character.getAllWardrobeItems().contains(cowboy))
    XCTAssertFalse(character.getAllWardrobeItems().contains(baseball))
    
    // can only buy items in store
    XCTAssertFalse(sut.purchaseAccessoryItem(item: beanie))
    
    XCTAssertEqual(store.getAllAccessoryItems().count, 2)
    XCTAssertFalse(store.hasAccessoryItem(item: beanie))
    XCTAssertEqual(sut.getMoney(), 300)
    XCTAssertTrue(character.getAllWardrobeItems().contains(beanie))
    XCTAssertFalse(character.getAllWardrobeItems().contains(cowboy))
    XCTAssertFalse(character.getAllWardrobeItems().contains(baseball))
    
    XCTAssertTrue(sut.purchaseAccessoryItem(item: baseball))
    
    XCTAssertEqual(store.getAllAccessoryItems().count, 1)
    XCTAssertFalse(store.hasAccessoryItem(item: baseball))
    XCTAssertEqual(sut.getMoney(), 150)
    XCTAssertTrue(character.getAllWardrobeItems().contains(beanie))
    XCTAssertFalse(character.getAllWardrobeItems().contains(cowboy))
    XCTAssertTrue(character.getAllWardrobeItems().contains(baseball))
    
    XCTAssertFalse(sut.purchaseAccessoryItem(item: cowboy))

    XCTAssertEqual(store.getAllAccessoryItems().count, 1)
    XCTAssertTrue(store.hasAccessoryItem(item: cowboy))
    XCTAssertEqual(sut.getMoney(), 150)
    XCTAssertTrue(character.getAllWardrobeItems().contains(beanie))
    XCTAssertFalse(character.getAllWardrobeItems().contains(cowboy))
    XCTAssertTrue(character.getAllWardrobeItems().contains(baseball))
  }
  
  func testPurchasePlaygroundItem() throws {
    let lamp = PlaygroundItem(name: "Lamp", price: 400, category: PlaygroundItemCategory.Floor)
    let fan = PlaygroundItem(name: "Fan", price: 500, category: PlaygroundItemCategory.Ceiling)
    let painting = PlaygroundItem(name: "Painting", price: 5000, category: PlaygroundItemCategory.Wall)
    store.addPlaygroundItem(item: lamp)
    store.addPlaygroundItem(item: fan)
    store.addPlaygroundItem(item: painting)
    sut.earnMoney(inc: 1000)
    XCTAssertEqual(sut.getMoney(), 1000)
    XCTAssertEqual(store.getAllPlaygroundItems().count, 3)
    XCTAssertTrue(store.hasPlaygroundItem(item: lamp))
    XCTAssertTrue(store.hasPlaygroundItem(item: fan))
    XCTAssertTrue(store.hasPlaygroundItem(item: painting))
    XCTAssertFalse(playground.getAllStorageItems().contains(lamp))
    XCTAssertFalse(playground.getAllStorageItems().contains(fan))
    XCTAssertFalse(playground.getAllStorageItems().contains(painting))

    XCTAssertTrue(sut.purchasePlaygroundItem(item: fan))
    
    XCTAssertEqual(store.getAllPlaygroundItems().count, 2)
    XCTAssertFalse(store.hasPlaygroundItem(item: fan))
    XCTAssertEqual(sut.getMoney(), 500)
    XCTAssertFalse(playground.getAllStorageItems().contains(lamp))
    XCTAssertTrue(playground.getAllStorageItems().contains(fan))
    XCTAssertFalse(playground.getAllStorageItems().contains(painting))
    
    // can only buy items in store
    XCTAssertFalse(sut.purchasePlaygroundItem(item: fan))
    
    XCTAssertEqual(store.getAllPlaygroundItems().count, 2)
    XCTAssertFalse(store.hasPlaygroundItem(item: fan))
    XCTAssertEqual(sut.getMoney(), 500)
    XCTAssertFalse(playground.getAllStorageItems().contains(lamp))
    XCTAssertTrue(playground.getAllStorageItems().contains(fan))
    XCTAssertFalse(playground.getAllStorageItems().contains(painting))
    
    XCTAssertTrue(sut.purchasePlaygroundItem(item: lamp))
    
    XCTAssertEqual(store.getAllPlaygroundItems().count, 1)
    XCTAssertFalse(store.hasPlaygroundItem(item: fan))
    XCTAssertEqual(sut.getMoney(), 100)
    XCTAssertTrue(playground.getAllStorageItems().contains(lamp))
    XCTAssertTrue(playground.getAllStorageItems().contains(fan))
    XCTAssertFalse(playground.getAllStorageItems().contains(painting))
    
    XCTAssertFalse(sut.purchasePlaygroundItem(item: painting))

    XCTAssertEqual(store.getAllPlaygroundItems().count, 1)
    XCTAssertTrue(store.hasPlaygroundItem(item: painting))
    XCTAssertEqual(sut.getMoney(), 100)
    XCTAssertTrue(playground.getAllStorageItems().contains(lamp))
    XCTAssertTrue(playground.getAllStorageItems().contains(fan))
    XCTAssertFalse(playground.getAllStorageItems().contains(painting))
  }
}

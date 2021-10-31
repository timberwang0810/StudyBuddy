//
//  UserTest.swift
//  StudyBuddyAppTests
//
//  Created by Tim Wang on 10/30/21.
//

import XCTest
@testable import StudyBuddyApp

class UserTest: XCTestCase {

  var sut : User!
    
  override func setUpWithError() throws {
    try super.setUpWithError()
    sut = User()
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
  
}

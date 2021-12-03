//
//  TaskTest.swift
//  StudyBuddyAppTests
//
//  Created by Tim Wang on 10/31/21.
//

import XCTest
@testable import StudyBuddyApp

class TaskTest: XCTestCase {

  var sut : Task!
  override func setUpWithError() throws {
    try super.setUpWithError()
    sut = Task(name: "Study 443", duration: 20000, category: TaskCategory.STUDY)
  }

  override func tearDownWithError() throws {
      // Put teardown code here. This method is called after the invocation of each test method in the class.
  }

  func testInitialization() throws {
    XCTAssertEqual(sut.name, "Study 443")
    XCTAssertEqual(sut.duration, 20000)
    XCTAssertEqual(sut.category, TaskCategory.STUDY)
    XCTAssertEqual(sut.baseReward, 400)
    XCTAssertEqual(sut.finalReward, 0)
  }
    
  func testIsTaskStarted() throws{
    XCTAssertFalse(sut.isTaskStarted())
    sut.start()
    XCTAssertTrue(sut.isTaskStarted())
    sut.complete(timeRemaining: 0)
    XCTAssertTrue(sut.isTaskStarted())
  }
  
  func testIsTaskEnded() throws {
    XCTAssertFalse(sut.isTaskEnded())
    sut.start()
    XCTAssertFalse(sut.isTaskEnded())
    sut.complete(timeRemaining: 0)
    XCTAssertTrue(sut.isTaskEnded())
  }
  
  func testStartTask() throws {
    XCTAssertFalse(sut.isTaskStarted())
    sut.start()
    XCTAssertTrue(sut.isTaskStarted())
    // Can't start again
    sut.start()
    XCTAssertTrue(sut.isTaskStarted())
  }
  
  func testStopTask() throws {
    // Can't stop if task is not started
    sut.complete(timeRemaining: 0)
    XCTAssertEqual(sut.finalReward, 0)
    XCTAssertFalse(sut.isTaskStarted())
    XCTAssertFalse(sut.isTaskEnded())
    sut.start()
    XCTAssertFalse(sut.isTaskEnded())
    XCTAssertTrue(sut.isTaskStarted())
    sut.complete(timeRemaining: 0)
    XCTAssertTrue(sut.isTaskStarted())
    XCTAssertTrue(sut.isTaskEnded())
    XCTAssertEqual(sut.finalReward, 483)
  }
  
  func testTaskEqual() throws{
    let task2 = Task(name: "Study 443", duration: 20000, category: TaskCategory.STUDY)
    XCTAssertNotEqual(sut, task2)
    let task = sut
    XCTAssertEqual(sut, task)
  }
  
  func testUpdateTimedReward() throws{
    XCTAssertEqual(sut.timedReward, 0)
    sut.updateTimedReward(timeRemaining: 600)
    XCTAssertNotEqual(sut.timedReward, 0)
    XCTAssertEqual(sut.timedReward, Task.calculateBaseRewards(duration: sut.duration - 600))
  }
}

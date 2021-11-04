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
    XCTAssertNil(sut.getStartTime())
    XCTAssertFalse(sut.isTaskStarted())
    XCTAssertEqual(sut.elapsedTime, 0)
  }
    
  func testIsTaskStarted() throws{
    XCTAssertFalse(sut.isTaskStarted())
    sut.start()
    XCTAssertTrue(sut.isTaskStarted())
    _ = sut.stopAndCollectReward()
    XCTAssertTrue(sut.isTaskStarted())
  }
  
  func testStartTask() throws {
    XCTAssertNil(sut.getStartTime())
    XCTAssertFalse(sut.isTaskStarted())
    sut.start()
    XCTAssertTrue(sut.isTaskStarted())
    XCTAssertNotNil(sut.getStartTime())
    XCTAssertGreaterThan(sut.elapsedTime, 0)
    XCTAssertLessThan(sut.elapsedTime, sut.duration)
    sleep(5)
    XCTAssertGreaterThan(sut.elapsedTime, 5)
    let startTime = sut.getStartTime()
    // Can't start again
    sut.start()
    XCTAssertTrue(sut.isTaskStarted())
    XCTAssertNotNil(sut.getStartTime())
    XCTAssertGreaterThan(sut.elapsedTime, 0)
    XCTAssertLessThan(sut.elapsedTime, sut.duration)
    XCTAssertEqual(sut.getStartTime(), startTime) // should be the same time as before
  }
  
  func testStopTask() throws {
    // Can't stop if task is not started
    XCTAssertEqual(sut.stopAndCollectReward(), 0)
    XCTAssertNil(sut.getStartTime())
    XCTAssertFalse(sut.isTaskStarted())
    sut.start()
    XCTAssertTrue(sut.isTaskStarted())
    sleep(5)
    XCTAssertGreaterThanOrEqual(sut.stopAndCollectReward(), sut.baseReward)
    XCTAssertNotNil(sut.getStartTime())
    XCTAssertTrue(sut.isTaskStarted())
  }
  
  func testTaskEqual() throws{
    let task2 = Task(name: "Study 443", duration: 20000, category: TaskCategory.STUDY)
    XCTAssertNotEqual(sut, task2)
    let task = sut
    XCTAssertEqual(sut, task)
  }
}

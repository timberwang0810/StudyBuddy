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
  
  func testIsTaskEnded() throws {
    XCTAssertFalse(sut.isTaskEnded())
    sut.start()
    XCTAssertFalse(sut.isTaskEnded())
    _ = sut.stopAndCollectReward()
    XCTAssertTrue(sut.isTaskEnded())
  }
  
  func testGetStartDate() throws {
    XCTAssertNil(sut.getStartTime())
    sut.start()
    let startTime = sut.getStartTime()
    XCTAssertNotNil(startTime)
    sleep(5)
    XCTAssertEqual(sut.getStartTime(), startTime)
    _ = sut.stopAndCollectReward()
    XCTAssertNotNil(sut.getStartTime())
  }
  
  func testGetEndDate() throws {
    XCTAssertNil(sut.getStartTime())
    sut.start()
    XCTAssertNil(sut.getEndTime())
    sleep(5)
    _ = sut.stopAndCollectReward()
    XCTAssertNotNil(sut.getEndTime())
    if let startTime = sut.getStartTime(), let endTime = sut.getEndTime(){
      XCTAssertGreaterThan(endTime.timeIntervalSince1970, startTime.timeIntervalSince1970)
    }
  }
  
  func testElapsedTime() throws {
    XCTAssertNil(sut.getStartTime())
    XCTAssertEqual(sut.elapsedTime, 0)
    sut.start()
    sleep(5)
    XCTAssertGreaterThanOrEqual(sut.elapsedTime, 4)
    _ = sut.stopAndCollectReward()
    let elapsed = sut.elapsedTime
    sleep(5)
    XCTAssertEqual(sut.elapsedTime, elapsed)
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

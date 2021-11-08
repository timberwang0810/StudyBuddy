//
//  ItemTest.swift
//  StudyBuddyAppTests
//
//  Created by Tim Wang on 10/31/21.
//

import XCTest
@testable import StudyBuddyApp

class ItemTest: XCTestCase {

  var sut_a : AccessoryItem!
  var sut_p : PlaygroundItem!
  
  override func setUpWithError() throws {
    try super.setUpWithError()
    sut_a = AccessoryItem(name: "Beanie", price: 200, category: AccessoryItemCategory.Hat)
    sut_p = PlaygroundItem(name: "Lamp", price: 500, category: PlaygroundItemCategory.Floor)
  }

  override func tearDownWithError() throws {
      // Put teardown code here. This method is called after the invocation of each test method in the class.
  }

  func testInitialization() throws {
    XCTAssertEqual(sut_a.name, "Beanie")
    XCTAssertEqual(sut_a.price, 200)
    XCTAssertEqual(sut_a.category, AccessoryItemCategory.Hat)
    
    XCTAssertEqual(sut_p.name, "Lamp")
    XCTAssertEqual(sut_p.price, 500)
    XCTAssertEqual(sut_p.category, PlaygroundItemCategory.Floor)
  }
  
  func testEquals() throws {
    let beanie = AccessoryItem(name: "Beanie", price: 300, category: AccessoryItemCategory.Hat)
    let cowboy = AccessoryItem(name: "Cowboy Hat", price: 200, category: AccessoryItemCategory.Hat)
    XCTAssertEqual(sut_a, beanie)
    XCTAssertNotEqual(sut_a, cowboy)
    
    let lamp = PlaygroundItem(name: "Lamp", price: 400, category: PlaygroundItemCategory.Floor)
    let carpet = PlaygroundItem(name: "carpet", price: 500, category: PlaygroundItemCategory.Floor)
    XCTAssertEqual(sut_p, lamp)
    XCTAssertNotEqual(sut_p, carpet)
  }
}

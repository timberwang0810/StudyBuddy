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
    sut_a = AccessoryItem(name: "Beanie", price: 200, image: "beanie_img", category: AccessoryItemCategory.Hat)
    sut_p = PlaygroundItem(name: "Lamp", price: 500, image: "lamp_img", category: PlaygroundItemCategory.Floor, position: Vector2(x: 0,y: 0))
  }

  override func tearDownWithError() throws {
      // Put teardown code here. This method is called after the invocation of each test method in the class.
  }

  func testInitialization() throws {
    XCTAssertEqual(sut_a.name, "Beanie")
    XCTAssertEqual(sut_a.price, 200)
    XCTAssertEqual(sut_a.image, "beanie_img")
    XCTAssertEqual(sut_a.category, AccessoryItemCategory.Hat)
    
    XCTAssertEqual(sut_p.name, "Lamp")
    XCTAssertEqual(sut_p.price, 500)
    XCTAssertEqual(sut_p.image, "lamp_img")
    XCTAssertEqual(sut_p.category, PlaygroundItemCategory.Floor)
  }
  
  func testEquals() throws {
    let beanie = AccessoryItem(name: "Beanie", price: 300, image: "beanie_img", category: AccessoryItemCategory.Hat)
    let cowboy = AccessoryItem(name: "Cowboy Hat", price: 200, image: "cowboy_hat_img", category: AccessoryItemCategory.Hat)
    XCTAssertEqual(sut_a, beanie)
    XCTAssertNotEqual(sut_a, cowboy)
    
    let lamp = PlaygroundItem(name: "Lamp", price: 400, image: "lamp_img", category: PlaygroundItemCategory.Floor, position: Vector2(x: 0,y: 0))
    let carpet = PlaygroundItem(name: "carpet", price: 500, image: "carpet_img", category: PlaygroundItemCategory.Floor, position: Vector2(x: 0,y: 0))
    XCTAssertEqual(sut_p, lamp)
    XCTAssertNotEqual(sut_p, carpet)
  }
}

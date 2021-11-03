//
//  StoreTest.swift
//  StudyBuddyAppTests
//
//  Created by Tim Wang on 10/31/21.
//

import XCTest
@testable import StudyBuddyApp

class StoreTest: XCTestCase {
  var sut : Store!
  override func setUpWithError() throws {
    try super.setUpWithError()
    sut = Store()
  }

  override func tearDownWithError() throws {
      // Put teardown code here. This method is called after the invocation of each test method in the class.
  }

  func testInitialization() throws {
    XCTAssertEqual(sut.getAllAccessoryItems(), [])
    XCTAssertEqual(sut.getAllPlaygroundItems(), [])
  }
  
  func testGetAccessoryItemsByCategory() throws {
    let beanie = AccessoryItem(name: "Beanie", price: 300, category: AccessoryItemCategory.Hat)
    let cowboy = AccessoryItem(name: "Cowboy Hat", price: 200, category: AccessoryItemCategory.Hat)
    let baseball = AccessoryItem(name: "Baseball Hat", price: 150, category: AccessoryItemCategory.Hat)
    sut.addAccessoryItem(item: beanie)
    sut.addAccessoryItem(item: cowboy)
    sut.addAccessoryItem(item: baseball)
    XCTAssertEqual(sut.getAccessoryItemsByCategory(category: AccessoryItemCategory.Hat).count, 3)
    XCTAssertTrue(sut.getAccessoryItemsByCategory(category: AccessoryItemCategory.Hat).contains(beanie))
    XCTAssertTrue(sut.getAccessoryItemsByCategory(category: AccessoryItemCategory.Hat).contains(cowboy))
    XCTAssertTrue(sut.getAccessoryItemsByCategory(category: AccessoryItemCategory.Hat).contains(baseball))
  }
  
  func testGetPlaygroundItemsByCategory() throws {
    let lamp = PlaygroundItem(name: "Lamp", price: 400, category: PlaygroundItemCategory.Floor)
    let fan = PlaygroundItem(name: "Fan", price: 500, category: PlaygroundItemCategory.Ceiling)
    let carpet = PlaygroundItem(name: "carpet", price: 500, category: PlaygroundItemCategory.Floor)
    XCTAssertEqual(sut.getPlaygroundItemsByCategory(category: PlaygroundItemCategory.Floor).count, 0)
    XCTAssertEqual(sut.getPlaygroundItemsByCategory(category: PlaygroundItemCategory.Ceiling).count, 0)
    XCTAssertEqual(sut.getPlaygroundItemsByCategory(category: PlaygroundItemCategory.Wall).count, 0)
    sut.addPlaygroundItem(item: lamp)
    sut.addPlaygroundItem(item: fan)
    sut.addPlaygroundItem(item: carpet)
    XCTAssertEqual(sut.getPlaygroundItemsByCategory(category: PlaygroundItemCategory.Floor).count, 2)
    XCTAssertTrue(sut.getPlaygroundItemsByCategory(category: PlaygroundItemCategory.Floor).contains(lamp))
    XCTAssertTrue(sut.getPlaygroundItemsByCategory(category: PlaygroundItemCategory.Floor).contains(carpet))
    XCTAssertEqual(sut.getPlaygroundItemsByCategory(category: PlaygroundItemCategory.Ceiling).count, 1)
    XCTAssertTrue(sut.getPlaygroundItemsByCategory(category: PlaygroundItemCategory.Ceiling).contains(fan))
    XCTAssertEqual(sut.getPlaygroundItemsByCategory(category: PlaygroundItemCategory.Wall).count, 0)
  }
  
  func testAddAccessoryItem() throws {
    XCTAssertEqual(sut.getAllAccessoryItems(), [])
    let beanie = AccessoryItem(name: "Beanie", price: 300, category: AccessoryItemCategory.Hat)
    let cowboy = AccessoryItem(name: "Cowboy Hat", price: 200, category: AccessoryItemCategory.Hat)
    let baseball = AccessoryItem(name: "Baseball Hat", price: 150, category: AccessoryItemCategory.Hat)
    sut.addAccessoryItem(item: beanie)
    XCTAssertEqual(sut.getAllAccessoryItems().count, 1)
    XCTAssertTrue(sut.getAllAccessoryItems().contains(beanie))
    XCTAssertFalse(sut.getAllAccessoryItems().contains(cowboy))
    XCTAssertFalse(sut.getAllAccessoryItems().contains(baseball))

    sut.addAccessoryItem(item: cowboy)
    sut.addAccessoryItem(item: baseball)
    XCTAssertEqual(sut.getAllAccessoryItems().count, 3)
    XCTAssertTrue(sut.getAllAccessoryItems().contains(beanie))
    XCTAssertTrue(sut.getAllAccessoryItems().contains(cowboy))
    XCTAssertTrue(sut.getAllAccessoryItems().contains(baseball))
    
    XCTAssertEqual(sut.getAllPlaygroundItems(), [])
  }
  
  func testRemoveAccessoryItem() throws {
    let beanie = AccessoryItem(name: "Beanie", price: 300, category: AccessoryItemCategory.Hat)
    let cowboy = AccessoryItem(name: "Cowboy Hat", price: 200, category: AccessoryItemCategory.Hat)
    let baseball = AccessoryItem(name: "Baseball Hat", price: 150, category: AccessoryItemCategory.Hat)
    let helmet = AccessoryItem(name: "Helmet", price: 100, category: AccessoryItemCategory.Hat)
    sut.addAccessoryItem(item: beanie)
    sut.addAccessoryItem(item: cowboy)
    sut.addAccessoryItem(item: baseball)
    XCTAssertEqual(sut.getAllAccessoryItems().count, 3)
    XCTAssertTrue(sut.getAllAccessoryItems().contains(beanie))
    XCTAssertTrue(sut.getAllAccessoryItems().contains(cowboy))
    XCTAssertTrue(sut.getAllAccessoryItems().contains(baseball))
    
    sut.removeAccessoryItem(item: cowboy)
    XCTAssertEqual(sut.getAllAccessoryItems().count, 2)
    XCTAssertTrue(sut.getAllAccessoryItems().contains(beanie))
    XCTAssertFalse(sut.getAllAccessoryItems().contains(cowboy))
    XCTAssertTrue(sut.getAllAccessoryItems().contains(baseball))
    
    XCTAssertFalse(sut.getAllAccessoryItems().contains(helmet))
    sut.removeAccessoryItem(item: helmet)
    XCTAssertEqual(sut.getAllAccessoryItems().count, 2)
    
    sut.removeAccessoryItem(item: beanie)
    sut.removeAccessoryItem(item: baseball)
    XCTAssertEqual(sut.getAllAccessoryItems().count, 0)
  }
  
  func testAddPlaygroundItem() throws {
    XCTAssertEqual(sut.getAllPlaygroundItems(), [])
    let lamp = PlaygroundItem(name: "Lamp", price: 400, category: PlaygroundItemCategory.Floor)
    let fan = PlaygroundItem(name: "Fan", price: 500, category: PlaygroundItemCategory.Ceiling)
    let carpet = PlaygroundItem(name: "carpet", price: 500, category: PlaygroundItemCategory.Floor)
    sut.addPlaygroundItem(item: lamp)
    XCTAssertEqual(sut.getAllPlaygroundItems().count, 1)
    XCTAssertTrue(sut.getAllPlaygroundItems().contains(lamp))
    XCTAssertFalse(sut.getAllPlaygroundItems().contains(fan))
    XCTAssertFalse(sut.getAllPlaygroundItems().contains(carpet))

    sut.addPlaygroundItem(item: fan)
    sut.addPlaygroundItem(item: carpet)
    XCTAssertEqual(sut.getAllPlaygroundItems().count, 3)
    XCTAssertTrue(sut.getAllPlaygroundItems().contains(lamp))
    XCTAssertTrue(sut.getAllPlaygroundItems().contains(fan))
    XCTAssertTrue(sut.getAllPlaygroundItems().contains(carpet))
    
    XCTAssertEqual(sut.getAllAccessoryItems(), [])
  }
  
  func testRemovePlaygroundItem() throws {
    let lamp = PlaygroundItem(name: "Lamp", price: 400, category: PlaygroundItemCategory.Floor)
    let fan = PlaygroundItem(name: "Fan", price: 500, category: PlaygroundItemCategory.Ceiling)
    let carpet = PlaygroundItem(name: "carpet", price: 500, category: PlaygroundItemCategory.Floor)
    let painting = PlaygroundItem(name: "Painting", price: 5000, category: PlaygroundItemCategory.Wall)
    sut.addPlaygroundItem(item: lamp)
    sut.addPlaygroundItem(item: fan)
    sut.addPlaygroundItem(item: carpet)
    XCTAssertEqual(sut.getAllPlaygroundItems().count, 3)
    XCTAssertTrue(sut.getAllPlaygroundItems().contains(lamp))
    XCTAssertTrue(sut.getAllPlaygroundItems().contains(fan))
    XCTAssertTrue(sut.getAllPlaygroundItems().contains(carpet))
    
    sut.removePlaygroundItem(item: fan)
    XCTAssertEqual(sut.getAllPlaygroundItems().count, 2)
    XCTAssertTrue(sut.getAllPlaygroundItems().contains(lamp))
    XCTAssertFalse(sut.getAllPlaygroundItems().contains(fan))
    XCTAssertTrue(sut.getAllPlaygroundItems().contains(carpet))
    
    XCTAssertFalse(sut.getAllPlaygroundItems().contains(painting))
    sut.removePlaygroundItem(item: painting)
    XCTAssertEqual(sut.getAllPlaygroundItems().count, 2)
    
    sut.removePlaygroundItem(item: carpet)
    sut.removePlaygroundItem(item: lamp)
    XCTAssertEqual(sut.getAllPlaygroundItems().count, 0)
  }
  
  func testHasAccessoryItem() throws {
    XCTAssertEqual(sut.getAllAccessoryItems(), [])
    let beanie = AccessoryItem(name: "Beanie", price: 300, category: AccessoryItemCategory.Hat)
    let cowboy = AccessoryItem(name: "Cowboy Hat", price: 200, category: AccessoryItemCategory.Hat)
    let baseball = AccessoryItem(name: "Baseball Hat", price: 150, category: AccessoryItemCategory.Hat)
    sut.addAccessoryItem(item: beanie)
    XCTAssertTrue(sut.hasAccessoryItem(item: beanie))
    XCTAssertFalse(sut.hasAccessoryItem(item: cowboy))
    XCTAssertFalse(sut.hasAccessoryItem(item: baseball))

    sut.addAccessoryItem(item: cowboy)
    sut.addAccessoryItem(item: baseball)
    XCTAssertTrue(sut.hasAccessoryItem(item: beanie))
    XCTAssertTrue(sut.hasAccessoryItem(item: cowboy))
    XCTAssertTrue(sut.hasAccessoryItem(item: baseball))
  }
  func testHasPlaygroundItem() throws {
    XCTAssertEqual(sut.getAllPlaygroundItems(), [])
    let lamp = PlaygroundItem(name: "Lamp", price: 400, category: PlaygroundItemCategory.Floor)
    let fan = PlaygroundItem(name: "Fan", price: 500, category: PlaygroundItemCategory.Ceiling)
    let carpet = PlaygroundItem(name: "carpet", price: 500, category: PlaygroundItemCategory.Floor)
    XCTAssertFalse(sut.hasPlaygroundItem(item: lamp))
    XCTAssertFalse(sut.hasPlaygroundItem(item: fan))
    XCTAssertFalse(sut.hasPlaygroundItem(item: carpet))
    sut.addPlaygroundItem(item: lamp)
    XCTAssertTrue(sut.hasPlaygroundItem(item: lamp))
    XCTAssertFalse(sut.hasPlaygroundItem(item: fan))
    XCTAssertFalse(sut.hasPlaygroundItem(item: carpet))
    sut.addPlaygroundItem(item: fan)
    sut.addPlaygroundItem(item: carpet)
    sut.addPlaygroundItem(item: lamp)
    XCTAssertTrue(sut.hasPlaygroundItem(item: lamp))
    XCTAssertTrue(sut.hasPlaygroundItem(item: fan))
    XCTAssertTrue(sut.hasPlaygroundItem(item: carpet))
  }
}
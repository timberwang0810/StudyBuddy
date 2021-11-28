//
//  StoreTest.swift
//  StudyBuddyAppTests
//
//  Created by Tim Wang on 10/31/21.
//

import XCTest
@testable import StudyBuddyApp

class StoreTest: XCTestCase {
  var beanie: AccessoryItem!
  var cowboy: AccessoryItem!
  var baseball: AccessoryItem!
  var lamp: PlaygroundItem!
  var fan: PlaygroundItem!
  var carpet: PlaygroundItem!
  var helmet: AccessoryItem!
  var painting: PlaygroundItem!
  
  var sut : Store!
  override func setUpWithError() throws {
    try super.setUpWithError()
    sut = Store()
    
    beanie = AccessoryItem(name: "Beanie", price: 300, image: "beanie_img", category: AccessoryItemCategory.Hat)
    cowboy = AccessoryItem(name: "Cowboy Hat", price: 200, image: "cowboy_hat_img", category: AccessoryItemCategory.Hat)
    baseball = AccessoryItem(name: "Baseball Hat", price: 150, image: "baseball_img", category: AccessoryItemCategory.Hat)
    lamp = PlaygroundItem(name: "Lamp", price: 400, image: "lamp_img", category: PlaygroundItemCategory.Floor)
    fan = PlaygroundItem(name: "Fan", price: 500, image: "fan_img", category: PlaygroundItemCategory.Ceiling)
    carpet = PlaygroundItem(name: "carpet", price: 500, image: "carpet_img", category: PlaygroundItemCategory.Floor)
    helmet = AccessoryItem(name: "Helmet", price: 100, image: "helmet_img", category: AccessoryItemCategory.Hat)
    painting = PlaygroundItem(name: "Painting", price: 5000, image: "painting_img", category: PlaygroundItemCategory.Wall)
  }

  override func tearDownWithError() throws {
      // Put teardown code here. This method is called after the invocation of each test method in the class.
  }

  func testInitialization() throws {
    XCTAssertEqual(sut.getAllAccessoryItems(), [])
    XCTAssertEqual(sut.getAllPlaygroundItems(), [])
  }
  
  func testGetAccessoryItemsByCategory() throws {
    sut.addAccessoryItem(item: beanie)
    sut.addAccessoryItem(item: cowboy)
    sut.addAccessoryItem(item: baseball)
    XCTAssertEqual(sut.getAccessoryItemsByCategory(category: AccessoryItemCategory.Hat).count, 3)
    XCTAssertTrue(sut.getAccessoryItemsByCategory(category: AccessoryItemCategory.Hat).contains(beanie))
    XCTAssertTrue(sut.getAccessoryItemsByCategory(category: AccessoryItemCategory.Hat).contains(cowboy))
    XCTAssertTrue(sut.getAccessoryItemsByCategory(category: AccessoryItemCategory.Hat).contains(baseball))
  }
  
  func testGetPlaygroundItemsByCategory() throws {
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
    sut.addAccessoryItem(item: beanie)
    sut.addAccessoryItem(item: cowboy)
    sut.addAccessoryItem(item: baseball)
    XCTAssertEqual(sut.getAllAccessoryItems().count, 3)
    XCTAssertTrue(sut.getAllAccessoryItems().contains(beanie))
    XCTAssertTrue(sut.getAllAccessoryItems().contains(cowboy))
    XCTAssertTrue(sut.getAllAccessoryItems().contains(baseball))
    XCTAssertTrue(sut.hasAccessoryItem(item: beanie))
    XCTAssertTrue(sut.hasAccessoryItem(item: cowboy))
    XCTAssertTrue(sut.hasAccessoryItem(item: baseball))
    XCTAssertFalse(sut.hasAccessoryItem(item: helmet))


    sut.markAccessoryItemAsPurchased(item: cowboy)
    XCTAssertEqual(sut.getAllAccessoryItems().count, 3)
    XCTAssertTrue(sut.getAllAccessoryItems().contains(beanie))
    XCTAssertTrue(sut.getAllAccessoryItems().contains(cowboy))
    XCTAssertTrue(sut.getAllAccessoryItems().contains(baseball))
    XCTAssertFalse(sut.hasAccessoryItem(item: cowboy))
    
    XCTAssertFalse(sut.getAllAccessoryItems().contains(helmet))
    sut.markAccessoryItemAsPurchased(item: helmet)
    XCTAssertEqual(sut.getAllAccessoryItems().count, 3)
    XCTAssertFalse(sut.hasAccessoryItem(item: helmet))
    
    sut.markAccessoryItemAsPurchased(item: beanie)
    sut.markAccessoryItemAsPurchased(item: baseball)
    XCTAssertEqual(sut.getAllAccessoryItems().count, 3)
    XCTAssertFalse(sut.hasAccessoryItem(item: beanie))
    XCTAssertFalse(sut.hasAccessoryItem(item: baseball))
  }
  
  func testAddPlaygroundItem() throws {
    XCTAssertEqual(sut.getAllPlaygroundItems(), [])
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
    sut.addPlaygroundItem(item: lamp)
    sut.addPlaygroundItem(item: fan)
    sut.addPlaygroundItem(item: carpet)
    XCTAssertEqual(sut.getAllPlaygroundItems().count, 3)
    XCTAssertTrue(sut.getAllPlaygroundItems().contains(lamp))
    XCTAssertTrue(sut.getAllPlaygroundItems().contains(fan))
    XCTAssertTrue(sut.getAllPlaygroundItems().contains(carpet))
    XCTAssertTrue(sut.hasPlaygroundItem(item: lamp))
    XCTAssertTrue(sut.hasPlaygroundItem(item: fan))
    XCTAssertTrue(sut.hasPlaygroundItem(item: carpet))
    XCTAssertFalse(sut.hasPlaygroundItem(item: painting))
    
    sut.markPlaygroundItemAsPurchased(item: fan)
    XCTAssertFalse(sut.hasPlaygroundItem(item: fan))
    XCTAssertEqual(sut.getAllPlaygroundItems().count, 3)
    XCTAssertTrue(sut.getAllPlaygroundItems().contains(lamp))
    XCTAssertTrue(sut.getAllPlaygroundItems().contains(fan))
    XCTAssertTrue(sut.getAllPlaygroundItems().contains(carpet))
    XCTAssertFalse(sut.hasPlaygroundItem(item: fan))
    
    XCTAssertFalse(sut.getAllPlaygroundItems().contains(painting))
    sut.markPlaygroundItemAsPurchased(item: painting)
    XCTAssertEqual(sut.getAllPlaygroundItems().count, 3)
    XCTAssertFalse(sut.hasPlaygroundItem(item: painting))
    
    sut.markPlaygroundItemAsPurchased(item: carpet)
    sut.markPlaygroundItemAsPurchased(item: lamp)
    XCTAssertFalse(sut.hasPlaygroundItem(item: lamp))
    XCTAssertFalse(sut.hasPlaygroundItem(item: carpet))
    XCTAssertEqual(sut.getAllPlaygroundItems().count, 3)
    XCTAssertTrue(sut.getAllPlaygroundItems().contains(lamp))
    XCTAssertTrue(sut.getAllPlaygroundItems().contains(carpet))
  }
  
  func testHasAccessoryItem() throws {
    XCTAssertEqual(sut.getAllAccessoryItems(), [])
    sut.addAccessoryItem(item: beanie)
    XCTAssertTrue(sut.hasAccessoryItem(item: beanie))
    XCTAssertFalse(sut.hasAccessoryItem(item: cowboy))
    XCTAssertFalse(sut.hasAccessoryItem(item: baseball))

    sut.addAccessoryItem(item: cowboy)
    sut.addAccessoryItem(item: baseball)
    XCTAssertTrue(sut.hasAccessoryItem(item: beanie))
    XCTAssertTrue(sut.hasAccessoryItem(item: cowboy))
    XCTAssertTrue(sut.hasAccessoryItem(item: baseball))
    
    sut.markAccessoryItemAsPurchased(item: (cowboy))
    XCTAssertTrue(sut.hasAccessoryItem(item: beanie))
    XCTAssertFalse(sut.hasAccessoryItem(item: cowboy))
    XCTAssertTrue(sut.hasAccessoryItem(item: baseball))
  }
  func testHasPlaygroundItem() throws {
    XCTAssertEqual(sut.getAllPlaygroundItems(), [])
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
    
    sut.markPlaygroundItemAsPurchased(item: fan)
    XCTAssertTrue(sut.hasPlaygroundItem(item: lamp))
    XCTAssertFalse(sut.hasPlaygroundItem(item: fan))
    XCTAssertTrue(sut.hasPlaygroundItem(item: carpet))
  }
}

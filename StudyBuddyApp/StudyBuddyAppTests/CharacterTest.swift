//
//  CharacterTest.swift
//  StudyBuddyAppTests
//
//  Created by Tim Wang on 10/31/21.
//

import XCTest
@testable import StudyBuddyApp

class CharacterTest: XCTestCase {

  var sut : Character!
  override func setUpWithError() throws {
    try super.setUpWithError()
    sut = Character(name: "Bob")
  }

  override func tearDownWithError() throws {
      // Put teardown code here. This method is called after the invocation of each test method in the class.
  }

  func testInitialization() throws {
    XCTAssertEqual(sut.getName(), "Bob")
    XCTAssertEqual(sut.getNumNewItem(), 0)
    XCTAssertEqual(sut.getAllWardrobeItems(), [])
    XCTAssertEqual(sut.getAllCurrentClothes(), [:])
  }
  
  func testSetName() throws {
    XCTAssertEqual(sut.getName(), "Bob")
    sut.setName(name: "Tim")
    XCTAssertEqual(sut.getName(), "Tim")
  }
  
  func testOnNewItemPurchased() throws {
    XCTAssertEqual(sut.getNumNewItem(), 0)
    XCTAssertEqual(sut.getAllWardrobeItems(), [])
    XCTAssertEqual(sut.getAllCurrentClothes(), [:])

    let beanie = AccessoryItem(name: "Beanie", price: 300, image: "beanie_img", category: AccessoryItemCategory.Hat)
    let cowboy = AccessoryItem(name: "Cowboy Hat", price: 200, image: "cowboy_hat_img", category: AccessoryItemCategory.Hat)
    sut.onNewItemPurchased(item: beanie)
    XCTAssertEqual(sut.getNumNewItem(), 1)
    var wardrobe = sut.getAllWardrobeItems()
    XCTAssertEqual(wardrobe.count, 1)
    XCTAssertTrue(wardrobe.contains(beanie))
    XCTAssertFalse(wardrobe.contains(cowboy))
    sut.onNewItemPurchased(item: cowboy)
    XCTAssertEqual(sut.getNumNewItem(), 2)
    wardrobe = sut.getAllWardrobeItems()
    XCTAssertEqual(wardrobe.count, 2)
    XCTAssertTrue(wardrobe.contains(beanie))
    XCTAssertTrue(wardrobe.contains(cowboy))
    XCTAssertEqual(sut.getAllCurrentClothes(), [:])
  }
  
  func testWearItem() throws {
    let beanie = AccessoryItem(name: "Beanie", price: 300, image: "beanie_img", category: AccessoryItemCategory.Hat)
    let cowboy = AccessoryItem(name: "Cowboy Hat", price: 200, image: "cowboy_hat_img", category: AccessoryItemCategory.Hat)
    let baseball = AccessoryItem(name: "Baseball Hat", price: 150, image: "baseball_hat_img", category: AccessoryItemCategory.Hat)
    sut.onNewItemPurchased(item: beanie)
    sut.onNewItemPurchased(item: cowboy)
    var wardrobe = sut.getAllWardrobeItems()
    XCTAssertEqual(wardrobe.count, 2)
    XCTAssertTrue(wardrobe.contains(beanie))
    XCTAssertTrue(wardrobe.contains(cowboy))
    XCTAssertFalse(wardrobe.contains(baseball))
    XCTAssertEqual(sut.getAllCurrentClothes(), [:])
    
    sut.wearItem(item: beanie)
    XCTAssertNotEqual(sut.getAllCurrentClothes(), [:])
    XCTAssertEqual(sut.getAllCurrentClothes()[AccessoryItemCategory.Hat], beanie)
    wardrobe = sut.getAllWardrobeItems()
    XCTAssertEqual(wardrobe.count, 1)
    XCTAssertTrue(!wardrobe.contains(beanie))
    XCTAssertTrue(wardrobe.contains(cowboy))

    sut.wearItem(item: cowboy)
    XCTAssertNotEqual(sut.getAllCurrentClothes(), [:])
    XCTAssertNotEqual(sut.getAllCurrentClothes()[AccessoryItemCategory.Hat], beanie)
    XCTAssertEqual(sut.getAllCurrentClothes()[AccessoryItemCategory.Hat], cowboy)
    wardrobe = sut.getAllWardrobeItems()
    XCTAssertEqual(wardrobe.count, 1)
    XCTAssertTrue(wardrobe.contains(beanie))
    XCTAssertTrue(!wardrobe.contains(cowboy))
    
    sut.wearItem(item: baseball)
    XCTAssertNotEqual(sut.getAllCurrentClothes()[AccessoryItemCategory.Hat], baseball)
    XCTAssertEqual(sut.getAllCurrentClothes()[AccessoryItemCategory.Hat], cowboy)
    wardrobe = sut.getAllWardrobeItems()
    XCTAssertFalse(wardrobe.contains(baseball))
  }
  
  func testMoveIntoWardrob() throws {
    let beanie = AccessoryItem(name: "Beanie", price: 300, image: "beanie_img", category: AccessoryItemCategory.Hat)
    let cowboy = AccessoryItem(name: "Cowboy Hat", price: 200, image: "cowboy_hat_img", category: AccessoryItemCategory.Hat)
    sut.onNewItemPurchased(item: beanie)
    sut.onNewItemPurchased(item: cowboy)
    
    sut.wearItem(item: beanie)
    XCTAssertEqual(sut.getAllCurrentClothes()[AccessoryItemCategory.Hat], beanie)
    var wardrobe = sut.getAllWardrobeItems()
    XCTAssertEqual(wardrobe.count, 1)
    XCTAssertTrue(!wardrobe.contains(beanie))
    XCTAssertTrue(wardrobe.contains(cowboy))
    
    sut.moveIntoWardrobe(itemCategory: AccessoryItemCategory.Hat)
    XCTAssertEqual(sut.getAllCurrentClothes(), [:])
    wardrobe = sut.getAllWardrobeItems()
    XCTAssertEqual(wardrobe.count, 2)
    XCTAssertTrue(wardrobe.contains(beanie))
    XCTAssertTrue(wardrobe.contains(cowboy))
    
    // move with no item equipped there does nothing
    sut.moveIntoWardrobe(itemCategory: AccessoryItemCategory.Hat)
    XCTAssertEqual(sut.getAllCurrentClothes(), [:])
    wardrobe = sut.getAllWardrobeItems()
    XCTAssertEqual(wardrobe.count, 2)
    XCTAssertTrue(wardrobe.contains(beanie))
    XCTAssertTrue(wardrobe.contains(cowboy))
  }
  
  func testResetNumNewItem() throws {
    let beanie = AccessoryItem(name: "Beanie", price: 300, image: "beanie_img", category: AccessoryItemCategory.Hat)
    let cowboy = AccessoryItem(name: "Cowboy Hat", price: 200, image: "cowboy_hat_img",category: AccessoryItemCategory.Hat)
    sut.onNewItemPurchased(item: beanie)
    sut.onNewItemPurchased(item: cowboy)
    XCTAssertEqual(sut.getNumNewItem(), 2)
    var wardrobe = sut.getAllWardrobeItems()
    XCTAssertEqual(wardrobe.count, 2)
    
    sut.resetNumNewItem()
    XCTAssertEqual(sut.getNumNewItem(), 0)
    wardrobe = sut.getAllWardrobeItems()
    XCTAssertEqual(wardrobe.count, 2)
  }
}

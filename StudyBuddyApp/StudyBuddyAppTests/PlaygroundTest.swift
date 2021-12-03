//
//  PlaygroundTest.swift
//  StudyBuddyAppTests
//
//  Created by Tim Wang on 10/31/21.
//

import XCTest
@testable import StudyBuddyApp

class PlaygroundTest: XCTestCase {
  var lamp: PlaygroundItem!
  var fan: PlaygroundItem!
  var carpet: PlaygroundItem!
  var painting: PlaygroundItem!

  var sut : Playground!
  override func setUpWithError() throws {
    try super.setUpWithError()
    sut = Playground()
    
    lamp = PlaygroundItem(name: "Lamp", price: 400, image: "lamp_img", category: PlaygroundItemCategory.Floor, position: Vector2(x: 0,y: 0))
    fan = PlaygroundItem(name: "Fan", price: 500, image: "fan_img", category: PlaygroundItemCategory.Ceiling, position: Vector2(x: 0,y: 0))
    carpet = PlaygroundItem(name: "carpet", price: 500, image: "carpet_img", category: PlaygroundItemCategory.Floor, position: Vector2(x: 0,y: 0))
    painting = PlaygroundItem(name: "Painting", price: 5000, image: "painting_img", category: PlaygroundItemCategory.Wall, position: Vector2(x: 0,y: 0))
  }

  override func tearDownWithError() throws {
      // Put teardown code here. This method is called after the invocation of each test method in the class.
  }

  func testInitialization() throws {
    XCTAssertEqual(sut.getAllDecorations(), [:])
    XCTAssertEqual(sut.getAllStorageItems(), [])
    XCTAssertEqual(sut.getNumNewItem(), 0)
  }
  
  func testOnNewItemPurchased() throws {
    XCTAssertEqual(sut.getNumNewItem(), 0)
    XCTAssertEqual(sut.getAllDecorations(), [:])
    XCTAssertEqual(sut.getAllStorageItems(), [])

    sut.onNewItemPurchased(item: lamp)
    XCTAssertEqual(sut.getNumNewItem(), 1)
    var storage = sut.getAllStorageItems()
    XCTAssertEqual(storage.count, 1)
    XCTAssertTrue(storage.contains(lamp))
    XCTAssertFalse(storage.contains(carpet))
    sut.onNewItemPurchased(item: carpet)
    XCTAssertEqual(sut.getNumNewItem(), 2)
    storage = sut.getAllStorageItems()
    XCTAssertEqual(storage.count, 2)
    XCTAssertTrue(storage.contains(lamp))
    XCTAssertTrue(storage.contains(carpet))
    XCTAssertEqual(sut.getAllDecorations(), [:])
  }
  
  func testMoveIntoPlayground() throws {
    sut.onNewItemPurchased(item: lamp)
    sut.onNewItemPurchased(item: carpet)
    sut.onNewItemPurchased(item: fan)
    var storage = sut.getAllStorageItems()
    XCTAssertEqual(storage.count, 3)
    XCTAssertTrue(storage.contains(lamp))
    XCTAssertTrue(storage.contains(fan))
    XCTAssertTrue(storage.contains(carpet))
    XCTAssertFalse(storage.contains(painting))
    XCTAssertEqual(sut.getAllDecorations(), [:])
    
    sut.moveIntoPlayground(item: lamp)
    XCTAssertNotEqual(sut.getAllDecorations(), [:])
    XCTAssertEqual(sut.getAllDecorations()[PlaygroundItemCategory.Floor], lamp)
    storage = sut.getAllStorageItems()
    XCTAssertEqual(storage.count, 2)
    XCTAssertFalse(storage.contains(lamp))
    XCTAssertTrue(storage.contains(fan))
    XCTAssertTrue(storage.contains(carpet))

    sut.moveIntoPlayground(item: carpet)
    XCTAssertNotEqual(sut.getAllDecorations()[PlaygroundItemCategory.Floor], lamp)
    XCTAssertEqual(sut.getAllDecorations()[PlaygroundItemCategory.Floor], carpet)
    storage = sut.getAllStorageItems()
    XCTAssertEqual(storage.count, 2)
    XCTAssertTrue(storage.contains(lamp))
    XCTAssertTrue(storage.contains(fan))
    XCTAssertFalse(storage.contains(carpet))
    
    // moving items already in playground doesn't do anything
    sut.moveIntoPlayground(item: carpet)
    XCTAssertEqual(sut.getAllDecorations()[PlaygroundItemCategory.Floor], carpet)
    storage = sut.getAllStorageItems()
    XCTAssertEqual(storage.count, 2)
    XCTAssertTrue(storage.contains(lamp))
    XCTAssertTrue(storage.contains(fan))
    XCTAssertFalse(storage.contains(carpet))
    
    sut.moveIntoPlayground(item: fan)
    XCTAssertEqual(sut.getAllDecorations()[PlaygroundItemCategory.Floor], carpet)
    XCTAssertEqual(sut.getAllDecorations()[PlaygroundItemCategory.Ceiling], fan)
    storage = sut.getAllStorageItems()
    XCTAssertEqual(storage.count, 1)
    XCTAssertTrue(storage.contains(lamp))
    XCTAssertFalse(storage.contains(fan))
    XCTAssertFalse(storage.contains(carpet))
    
    sut.moveIntoPlayground(item: painting)
    XCTAssertNotEqual(sut.getAllDecorations()[PlaygroundItemCategory.Wall], painting)
    storage = sut.getAllStorageItems()
    XCTAssertFalse(storage.contains(painting))
  }
  
  func testMoveIntoStorage() throws {
    sut.onNewItemPurchased(item: lamp)
    sut.onNewItemPurchased(item: carpet)
    sut.onNewItemPurchased(item: fan)
    
    sut.moveIntoPlayground(item: lamp)
    sut.moveIntoPlayground(item: fan)
    
    XCTAssertEqual(sut.getAllDecorations()[PlaygroundItemCategory.Floor], lamp)
    XCTAssertEqual(sut.getAllDecorations()[PlaygroundItemCategory.Ceiling], fan)
    var storage = sut.getAllStorageItems()
    XCTAssertEqual(storage.count, 1)
    XCTAssertFalse(storage.contains(lamp))
    XCTAssertFalse(storage.contains(fan))
    XCTAssertTrue(storage.contains(carpet))
    
    sut.moveIntoStorage(itemCategory: PlaygroundItemCategory.Ceiling)
    storage = sut.getAllStorageItems()
    XCTAssertEqual(sut.getAllDecorations()[PlaygroundItemCategory.Floor], lamp)
    XCTAssertNotEqual(sut.getAllDecorations()[PlaygroundItemCategory.Ceiling], fan)
    XCTAssertEqual(storage.count, 2)
    XCTAssertFalse(storage.contains(lamp))
    XCTAssertTrue(storage.contains(fan))
    XCTAssertTrue(storage.contains(carpet))
    
    // moving an item already in storage does nothing
    sut.moveIntoStorage(itemCategory: PlaygroundItemCategory.Ceiling)
    storage = sut.getAllStorageItems()
    XCTAssertEqual(sut.getAllDecorations()[PlaygroundItemCategory.Floor], lamp)
    XCTAssertNotEqual(sut.getAllDecorations()[PlaygroundItemCategory.Ceiling], fan)
    XCTAssertEqual(storage.count, 2)
    XCTAssertFalse(storage.contains(lamp))
    XCTAssertTrue(storage.contains(fan))
    XCTAssertTrue(storage.contains(carpet))
    
    sut.moveIntoStorage(itemCategory: PlaygroundItemCategory.Floor)
    storage = sut.getAllStorageItems()
    XCTAssertNotEqual(sut.getAllDecorations()[PlaygroundItemCategory.Floor], lamp)
    XCTAssertNotEqual(sut.getAllDecorations()[PlaygroundItemCategory.Ceiling], fan)
    XCTAssertEqual(storage.count, 3)
    XCTAssertTrue(storage.contains(lamp))
    XCTAssertTrue(storage.contains(fan))
    XCTAssertTrue(storage.contains(carpet))
  }
  
  func testResetNumNewItem() throws {
    sut.onNewItemPurchased(item: lamp)
    sut.onNewItemPurchased(item: carpet)
    XCTAssertEqual(sut.getNumNewItem(), 2)
    var storage = sut.getAllStorageItems()
    XCTAssertEqual(storage.count, 2)
    
    sut.resetNumNewItem()
    XCTAssertEqual(sut.getNumNewItem(), 0)
    storage = sut.getAllStorageItems()
    XCTAssertEqual(storage.count, 2)
  }
}

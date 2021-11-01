//
//  PlaygroundTest.swift
//  StudyBuddyAppTests
//
//  Created by Tim Wang on 10/31/21.
//

import XCTest
@testable import StudyBuddyApp

class PlaygroundTest: XCTestCase {

  var sut : Playground!
  override func setUpWithError() throws {
    try super.setUpWithError()
    sut = Playground()
  }

  override func tearDownWithError() throws {
      // Put teardown code here. This method is called after the invocation of each test method in the class.
  }

  func testInitialization() throws {
    XCTAssertEqual(sut.getAllDecorations()[PlaygroundItemCategory.Floor], [])
    XCTAssertEqual(sut.getAllDecorations()[PlaygroundItemCategory.Ceiling], [])
    XCTAssertEqual(sut.getAllDecorations()[PlaygroundItemCategory.Wall], [])
    XCTAssertEqual(sut.getAllStorageItems(), [])
    XCTAssertEqual(sut.getNumNewItem(), 0)
  }
  
  func testOnNewItemPurchased() throws {
    XCTAssertEqual(sut.getNumNewItem(), 0)
    XCTAssertEqual(sut.getAllDecorations()[PlaygroundItemCategory.Floor], [])
    XCTAssertEqual(sut.getAllDecorations()[PlaygroundItemCategory.Ceiling], [])
    XCTAssertEqual(sut.getAllDecorations()[PlaygroundItemCategory.Wall], [])
    XCTAssertEqual(sut.getAllStorageItems(), [])

    let lamp = PlaygroundItem(name: "Lamp", price: 400, category: PlaygroundItemCategory.Floor)
    let carpet = PlaygroundItem(name: "carpet", price: 500, category: PlaygroundItemCategory.Floor)
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
    XCTAssertEqual(sut.getAllDecorations()[PlaygroundItemCategory.Floor], [])
    XCTAssertEqual(sut.getAllDecorations()[PlaygroundItemCategory.Ceiling], [])
    XCTAssertEqual(sut.getAllDecorations()[PlaygroundItemCategory.Wall], [])
  }
  
  func testMoveIntoPlayground() throws {
    let lamp = PlaygroundItem(name: "Lamp", price: 400, category: PlaygroundItemCategory.Floor)
    let fan = PlaygroundItem(name: "Fan", price: 500, category: PlaygroundItemCategory.Ceiling)
    let carpet = PlaygroundItem(name: "carpet", price: 500, category: PlaygroundItemCategory.Floor)
    let painting = PlaygroundItem(name: "Painting", price: 5000, category: PlaygroundItemCategory.Wall)
    sut.onNewItemPurchased(item: lamp)
    sut.onNewItemPurchased(item: carpet)
    sut.onNewItemPurchased(item: fan)
    var storage = sut.getAllStorageItems()
    XCTAssertEqual(storage.count, 3)
    XCTAssertTrue(storage.contains(lamp))
    XCTAssertTrue(storage.contains(fan))
    XCTAssertTrue(storage.contains(carpet))
    XCTAssertFalse(storage.contains(painting))
    XCTAssertEqual(sut.getAllDecorations()[PlaygroundItemCategory.Floor], [])
    XCTAssertEqual(sut.getAllDecorations()[PlaygroundItemCategory.Ceiling], [])
    XCTAssertEqual(sut.getAllDecorations()[PlaygroundItemCategory.Wall], [])
    
    sut.moveIntoPlayground(item: lamp)
    XCTAssertNotEqual(sut.getAllDecorations(), [:])
    XCTAssertTrue(sut.getAllDecorations()[PlaygroundItemCategory.Floor]!.contains(lamp))
    storage = sut.getAllStorageItems()
    XCTAssertEqual(storage.count, 2)
    XCTAssertFalse(storage.contains(lamp))
    XCTAssertTrue(storage.contains(fan))
    XCTAssertTrue(storage.contains(carpet))

    sut.moveIntoPlayground(item: carpet)
    XCTAssertEqual(sut.getAllDecorations()[PlaygroundItemCategory.Floor]!.count, 2)
    XCTAssertTrue(sut.getAllDecorations()[PlaygroundItemCategory.Floor]!.contains(lamp))
    XCTAssertTrue(sut.getAllDecorations()[PlaygroundItemCategory.Floor]!.contains(carpet))
    storage = sut.getAllStorageItems()
    XCTAssertEqual(storage.count, 1)
    XCTAssertFalse(storage.contains(lamp))
    XCTAssertTrue(storage.contains(fan))
    XCTAssertFalse(storage.contains(carpet))
    
    // moving items already in playground doesn't do anything
    sut.moveIntoPlayground(item: carpet)
    XCTAssertEqual(sut.getAllDecorations()[PlaygroundItemCategory.Floor]!.count, 2)
    XCTAssertTrue(sut.getAllDecorations()[PlaygroundItemCategory.Floor]!.contains(lamp))
    XCTAssertTrue(sut.getAllDecorations()[PlaygroundItemCategory.Floor]!.contains(carpet))
    storage = sut.getAllStorageItems()
    XCTAssertEqual(storage.count, 1)
    XCTAssertFalse(storage.contains(lamp))
    XCTAssertTrue(storage.contains(fan))
    XCTAssertFalse(storage.contains(carpet))
    
    sut.moveIntoPlayground(item: fan)
    XCTAssertEqual(sut.getAllDecorations()[PlaygroundItemCategory.Floor]!.count, 2)
    XCTAssertTrue(sut.getAllDecorations()[PlaygroundItemCategory.Floor]!.contains(lamp))
    XCTAssertTrue(sut.getAllDecorations()[PlaygroundItemCategory.Floor]!.contains(carpet))
    XCTAssertEqual(sut.getAllDecorations()[PlaygroundItemCategory.Ceiling]!.count, 1)
    XCTAssertTrue(sut.getAllDecorations()[PlaygroundItemCategory.Ceiling]!.contains(fan))
    storage = sut.getAllStorageItems()
    XCTAssertEqual(storage.count, 0)
    XCTAssertFalse(storage.contains(lamp))
    XCTAssertFalse(storage.contains(fan))
    XCTAssertFalse(storage.contains(carpet))
    
    sut.moveIntoPlayground(item: painting)
    XCTAssertEqual(sut.getAllDecorations()[PlaygroundItemCategory.Wall]!.count, 0)
    storage = sut.getAllStorageItems()
    XCTAssertFalse(storage.contains(painting))
  }
  
  func testMoveIntoStorage() throws {
    let lamp = PlaygroundItem(name: "Lamp", price: 400, category: PlaygroundItemCategory.Floor)
    let fan = PlaygroundItem(name: "Fan", price: 500, category: PlaygroundItemCategory.Ceiling)
    let carpet = PlaygroundItem(name: "carpet", price: 500, category: PlaygroundItemCategory.Floor)
    let painting = PlaygroundItem(name: "Painting", price: 5000, category: PlaygroundItemCategory.Wall)
    sut.onNewItemPurchased(item: lamp)
    sut.onNewItemPurchased(item: carpet)
    sut.onNewItemPurchased(item: fan)
    
    sut.moveIntoPlayground(item: lamp)
    sut.moveIntoPlayground(item: carpet)
    sut.moveIntoPlayground(item: fan)
    
    XCTAssertEqual(sut.getAllDecorations()[PlaygroundItemCategory.Floor]!.count, 2)
    XCTAssertTrue(sut.getAllDecorations()[PlaygroundItemCategory.Floor]!.contains(lamp))
    XCTAssertTrue(sut.getAllDecorations()[PlaygroundItemCategory.Floor]!.contains(carpet))
    XCTAssertEqual(sut.getAllDecorations()[PlaygroundItemCategory.Ceiling]!.count, 1)
    XCTAssertTrue(sut.getAllDecorations()[PlaygroundItemCategory.Ceiling]!.contains(fan))
    var storage = sut.getAllStorageItems()
    XCTAssertEqual(storage.count, 0)
    XCTAssertFalse(storage.contains(lamp))
    XCTAssertFalse(storage.contains(fan))
    XCTAssertFalse(storage.contains(carpet))
    
    sut.moveIntoStorage(item: fan)
    storage = sut.getAllStorageItems()
    XCTAssertEqual(sut.getAllDecorations()[PlaygroundItemCategory.Floor]!.count, 2)
    XCTAssertTrue(sut.getAllDecorations()[PlaygroundItemCategory.Floor]!.contains(lamp))
    XCTAssertTrue(sut.getAllDecorations()[PlaygroundItemCategory.Floor]!.contains(carpet))
    XCTAssertEqual(sut.getAllDecorations()[PlaygroundItemCategory.Ceiling]!.count, 0)
    XCTAssertEqual(storage.count, 1)
    XCTAssertFalse(storage.contains(lamp))
    XCTAssertTrue(storage.contains(fan))
    XCTAssertFalse(storage.contains(carpet))
    
    sut.moveIntoStorage(item: lamp)
    storage = sut.getAllStorageItems()
    XCTAssertEqual(sut.getAllDecorations()[PlaygroundItemCategory.Floor]!.count, 1)
    XCTAssertFalse(sut.getAllDecorations()[PlaygroundItemCategory.Floor]!.contains(lamp))
    XCTAssertTrue(sut.getAllDecorations()[PlaygroundItemCategory.Floor]!.contains(carpet))
    XCTAssertEqual(sut.getAllDecorations()[PlaygroundItemCategory.Ceiling]!.count, 0)
    XCTAssertEqual(storage.count, 2)
    XCTAssertTrue(storage.contains(lamp))
    XCTAssertTrue(storage.contains(fan))
    XCTAssertFalse(storage.contains(carpet))
    
    // moving an item already in storage does nothing
    sut.moveIntoStorage(item: lamp)
    storage = sut.getAllStorageItems()
    XCTAssertEqual(sut.getAllDecorations()[PlaygroundItemCategory.Floor]!.count, 1)
    XCTAssertFalse(sut.getAllDecorations()[PlaygroundItemCategory.Floor]!.contains(lamp))
    XCTAssertTrue(sut.getAllDecorations()[PlaygroundItemCategory.Floor]!.contains(carpet))
    XCTAssertEqual(sut.getAllDecorations()[PlaygroundItemCategory.Ceiling]!.count, 0)
    XCTAssertEqual(storage.count, 2)
    XCTAssertTrue(storage.contains(lamp))
    XCTAssertTrue(storage.contains(fan))
    XCTAssertFalse(storage.contains(carpet))
    
    sut.moveIntoStorage(item: carpet)
    storage = sut.getAllStorageItems()
    XCTAssertEqual(sut.getAllDecorations()[PlaygroundItemCategory.Floor]!.count, 0)
    XCTAssertEqual(sut.getAllDecorations()[PlaygroundItemCategory.Ceiling]!.count, 0)
    XCTAssertEqual(storage.count, 3)
    XCTAssertTrue(storage.contains(lamp))
    XCTAssertTrue(storage.contains(fan))
    XCTAssertTrue(storage.contains(carpet))
    
    // moving an item not owned also does nothing
    sut.moveIntoStorage(item: painting)
    storage = sut.getAllStorageItems()
    XCTAssertEqual(sut.getAllDecorations()[PlaygroundItemCategory.Floor]!.count, 0)
    XCTAssertEqual(sut.getAllDecorations()[PlaygroundItemCategory.Ceiling]!.count, 0)
    XCTAssertEqual(storage.count, 3)
    XCTAssertTrue(storage.contains(lamp))
    XCTAssertTrue(storage.contains(fan))
    XCTAssertTrue(storage.contains(carpet))
    XCTAssertFalse(storage.contains(painting))
  }
  
  func testResetNumNewItem() throws {
    let lamp = PlaygroundItem(name: "Lamp", price: 400, category: PlaygroundItemCategory.Floor)
    let carpet = PlaygroundItem(name: "carpet", price: 500, category: PlaygroundItemCategory.Floor)
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

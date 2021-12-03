//
//  PlaygroundScene.swift
//  StudyBuddyApp
//
//  Created by Jonathan Fischer on 10/31/21.
//

import SwiftUI
import SpriteKit


class PlaygroundScene: SKScene {
    
    @ObservedObject var viewModel: ViewModel
    var selectedItems: [PlaygroundItem: Bool]
    var itemSprites: [PlaygroundItem: SKSpriteNode]

    
    init(size: CGSize, viewModel: ViewModel) {
        self.viewModel = viewModel
        self.selectedItems = [:]
        
        self.itemSprites = [:]
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.white
        
        self.selectedItems = Dictionary(uniqueKeysWithValues: viewModel.getAllPlaygroundItems().map{($0, viewModel.isItemInUse(item: $0))})
        
        let bob = BobPlayground(midX: frame.midX)
        bob.position = CGPoint(x: 0.5 * frame.midX, y: frame.midY)
        addChild(bob)
        bob.runMainLoop()
        
        var spriteNode: SKSpriteNode
        for (item, _) in selectedItems {
            spriteNode = SKSpriteNode(texture: SKTexture(imageNamed: item.image))
            spriteNode.position = CGPoint(x: frame.maxX * CGFloat(item.position.x), y: frame.maxY * CGFloat(item.position.y))
            
            itemSprites[item] = spriteNode
            addChild(spriteNode)
        }
        
        updatePlaygroundItems()
        
    }
    
    func updatePlaygroundItems() {
        self.selectedItems = Dictionary(uniqueKeysWithValues: viewModel.getAllPlaygroundItems().map{($0, viewModel.isItemInUse(item: $0))})
        
        for (item, sprite) in self.itemSprites {
            sprite.isHidden = !(selectedItems[item] ?? false)
        }
    }
    

    
    
}

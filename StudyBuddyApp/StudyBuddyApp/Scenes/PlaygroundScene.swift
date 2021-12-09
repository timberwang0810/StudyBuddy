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
    var bob: BobPlayground = BobPlayground(midX: 0)

    
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
        
        self.bob = BobPlayground(midX: frame.midX)
        self.bob.position = CGPoint(x: 0.5 * frame.midX, y: 1.1 * frame.midY)
        addChild(self.bob)
        self.bob.runMainLoop()
        
        var spriteNode: SKSpriteNode
        for (item, _) in selectedItems {
            spriteNode = SKSpriteNode(texture: SKTexture(imageNamed: item.image))
            spriteNode.position = CGPoint(x: frame.maxX * CGFloat(item.position.x), y: frame.maxY * CGFloat(item.position.y))
            
            itemSprites[item] = spriteNode
            addChild(spriteNode)
        }
        
        let dialogue = DialogueBubble(message: "Hello there!", time: 1.5)
        dialogue.position = CGPoint(x: self.bob.position.x + 150, y: self.bob.position.y + 150)
        addChild(dialogue)
        
        let spawnDialogue = SKAction.repeatForever(SKAction.sequence([
            SKAction.wait(forDuration: 30, withRange: 10),
            SKAction.run {
                let bubble = DialogueBubble(message: "__random_playground", time: nil)
                bubble.position = CGPoint(x: self.bob.position.x + 150, y: self.bob.position.y + 150)
                self.addChild(bubble)
            }
        ]))
        
        self.run(spawnDialogue)
        
        updatePlaygroundItems()
        
    }
    
    func updatePlaygroundItems() {
        self.selectedItems = Dictionary(uniqueKeysWithValues: viewModel.getAllPlaygroundItems().map{($0, viewModel.isItemInUse(item: $0))})
        
        for (item, sprite) in self.itemSprites {
            sprite.isHidden = !(selectedItems[item] ?? false)
        }
    }
    
    func toggleBobVisibility() {
        self.bob.isHidden = !self.bob.isHidden
    }
    

    
    
}

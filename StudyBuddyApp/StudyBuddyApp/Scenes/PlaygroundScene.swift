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
        self.selectedItems = Dictionary(uniqueKeysWithValues: viewModel.getAllPlaygroundItems().map{($0, false)})
        
        print(selectedItems)
        
        self.itemSprites = [:]
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.white
        
        //let bob = AnimatedSprite(timePerFrame: 1.0, atlasName: "bob_writing")
        //bob.position = CGPoint(x: frame.midX, y: frame.midY)
        //addChild(bob)
        //bob.startAnimation()
        
        var spriteNode: SKSpriteNode
        print("selectedItems: ", selectedItems)
        for (item, _) in selectedItems {
            spriteNode = SKSpriteNode(texture: SKTexture(imageNamed: item.image))
            spriteNode.position = CGPoint(x: frame.midX, y: frame.midY)
            
            itemSprites[item] = spriteNode
            addChild(spriteNode)
            print("Added " + item.name)
        }
        
    }
    
    func updatePlaygroundItems() {
        self.selectedItems = Dictionary(uniqueKeysWithValues: viewModel.getAllPlaygroundItems().map{($0, false)})
        
        for (item, sprite) in self.itemSprites {
            sprite.isHidden = selectedItems[item] ?? false
            print(item.name + " is " + (sprite.isHidden ? "shown" : "hidden"))
        }
    }
    
    func hideAllPlaygroundItems() {
        for (_, sprite) in itemSprites {
            sprite.isHidden = true
        }
    }
    
    
}

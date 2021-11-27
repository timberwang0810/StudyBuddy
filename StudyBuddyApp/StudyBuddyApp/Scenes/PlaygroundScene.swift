//
//  PlaygroundScene.swift
//  StudyBuddyApp
//
//  Created by Jonathan Fischer on 10/31/21.
//

import UIKit
import SpriteKit


class PlaygroundScene: SKScene {
    
    var selectedItems: [PlaygroundItem: Bool]
    var itemSprites: [PlaygroundItem: SKSpriteNode]

    
    init(size: CGSize, selectedItems: [PlaygroundItem : Bool]) {
        self.selectedItems = selectedItems
        
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
        
        var spriteNode: PlaygroundFurniture
        for (item, _) in selectedItems {
            spriteNode = PlaygroundFurniture(sprite: SKTexture(imageNamed: item.image))
            
            itemSprites[item] = spriteNode
            addChild(spriteNode)
        }
        
    }
    
    func updatePlaygroundItems() {
        for (item, sprite) in itemSprites {
            sprite.isHidden = selectedItems[item] ?? false
        }
    }
    
    func hideAllPlaygroundItems() {
        for (_, sprite) in itemSprites {
            sprite.isHidden = true
        }
    }
    
    
}

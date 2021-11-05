//
//  PlaygroundScene.swift
//  StudyBuddyApp
//
//  Created by Jonathan Fischer on 10/31/21.
//

import UIKit
import SpriteKit

class PlaygroundScene: SKScene {
        
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.gray
        
        let bob = AnimatedSprite(timePerFrame: 1.0, atlasName: "bob_writing")
        bob.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(bob)
        
        bob.startAnimation()
    }
    
    
}

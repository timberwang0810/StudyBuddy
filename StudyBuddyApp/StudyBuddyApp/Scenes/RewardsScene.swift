//
//  RewardsScene.swift
//  StudyBuddyApp
//
//  Created by Jonathan Fischer on 11/8/21.
//

import UIKit
import SpriteKit

class RewardsScene: SKScene {
        
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.white
        
        let bob = AnimatedSprite(timePerFrame: 0.5, atlasName: "bob_cheering")
        bob.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(bob)
        
        bob.startAnimation()
    }
    
    
}

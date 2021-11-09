//
//  DoingTaskScene.swift
//  StudyBuddyApp
//
//  Created by Jonathan Fischer on 11/8/21.
//

import UIKit
import SpriteKit

class DoingTaskScene: SKScene {
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.white
        
        let bob = AnimatedSprite(timePerFrame: 1.0, atlasName: "bob_writing")
        bob.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(bob)
        
        bob.startAnimation()
    }

}

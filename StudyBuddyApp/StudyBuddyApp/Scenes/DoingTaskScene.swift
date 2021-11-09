//
//  DoingTaskScene.swift
//  StudyBuddyApp
//
//  Created by Jonathan Fischer on 11/8/21.
//

import UIKit
import SpriteKit

class DoingTaskScene: SKScene {
    
    var atlasName: String
    
    init(atlasName: String) {
        self.atlasName = atlasName
        
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.white
        
        let bob = AnimatedSprite(timePerFrame: 1.0, atlasName: self.atlasName)
        bob.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(bob)
        
        bob.startAnimation()
    }

}

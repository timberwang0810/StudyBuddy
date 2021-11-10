//
//  DoingTaskScene.swift
//  StudyBuddyApp
//
//  Created by Jonathan Fischer on 11/8/21.
//

import UIKit
import SpriteKit

class DoingTaskScene: SKScene {
    
    public var timer: Timer
    
    init(size: CGSize, duration: Double) {
        self.timer = Timer(timeRemaining: duration)
        
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.white
        
        let bob = AnimatedSprite(timePerFrame: 1.0, atlasName: "bob_writing")
        bob.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(bob)
        
        self.timer.position = CGPoint(x: 1.5 * frame.midX, y: 0.5 * frame.midY)
        addChild(self.timer)
        
        bob.startAnimation()
    }

}

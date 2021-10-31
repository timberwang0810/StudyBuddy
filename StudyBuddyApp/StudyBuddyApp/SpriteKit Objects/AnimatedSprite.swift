//
//  AnimatedSprite.swift
//  StudyBuddyApp
//
//  Created by Jonathan Fischer on 10/31/21.
//

import UIKit
import SpriteKit

class AnimatedSprite: SKSpriteNode {
    
    var timePerFrame: Double
    let frames: [SKTexture]
    let animation: SKAction
    
    init(timePerFrame: Double, frames: [SKTexture]) {
        self.timePerFrame = timePerFrame
        self.frames = frames
        self.animation = SKAction.animate(with: self.frames, timePerFrame: self.timePerFrame)
        
        super.init(texture: frames[0], color: SKColor.clear, size: frames[0].size())
        
        self.startAnimation()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startAnimation() {
        self.run(self.animation)
    }
}

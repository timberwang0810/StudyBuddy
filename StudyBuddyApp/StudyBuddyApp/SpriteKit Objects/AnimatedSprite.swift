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
    var frames: [SKTexture]
    let textureAtlas: SKTextureAtlas
    let animation: SKAction
    
    init(timePerFrame: Double, atlasName: String) {
        self.timePerFrame = timePerFrame
        self.textureAtlas = SKTextureAtlas(named: atlasName)
        
        self.frames = []
        for i in 1...textureAtlas.textureNames.count {
            let frameName = "\(atlasName)_f\(i)"
            frames.append(textureAtlas.textureNamed(frameName))
        }
        
        self.animation = SKAction.repeatForever(SKAction.animate(with: self.frames, timePerFrame: self.timePerFrame, resize: false, restore: true))
        
        
        super.init(texture: frames[0], color: SKColor.clear, size: frames[0].size())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startAnimation() {
        self.run(self.animation)
    }
}

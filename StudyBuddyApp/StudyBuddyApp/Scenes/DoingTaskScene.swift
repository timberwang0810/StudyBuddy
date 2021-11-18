//
//  DoingTaskScene.swift
//  StudyBuddyApp
//
//  Created by Jonathan Fischer on 11/8/21.
//

import UIKit
import SpriteKit

class DoingTaskScene: SKScene {
    
    public var timer: SpriteTimer
    var atlasName: String
    
    let atlases:[TaskCategory:String] = [
        TaskCategory.STUDY: "bob_writing",
        TaskCategory.CHORES: "bob_sweeping",
        TaskCategory.WORK: "bob_writing",
        TaskCategory.EXERCISE: "bob_sweeping",
        TaskCategory.OTHER: "bob_sweeping"
    ]
    
    init(size: CGSize, duration: Double, taskCategory: TaskCategory) {
        self.timer = SpriteTimer(timeRemaining: duration)
        self.atlasName = atlases[taskCategory]!
        
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.white
        
        print(self.atlasName)
        
        let bob = AnimatedSprite(timePerFrame: 1.0, atlasName: self.atlasName)
        bob.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(bob)
        
        self.timer.position = CGPoint(x: 1.5 * frame.midX, y: 0.5 * frame.midY)
        addChild(self.timer)
        
        bob.startAnimation()
    }

}

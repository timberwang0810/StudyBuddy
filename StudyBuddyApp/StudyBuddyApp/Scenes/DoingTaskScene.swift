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
        TaskCategory.WORK: "bob_writing",
        TaskCategory.CHORES: "bob_mopping",
        TaskCategory.EXERCISE: "bob_mopping",
        TaskCategory.OTHER: "bob_mopping"
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
        
        self.timer.position = CGPoint(x: 1.95 * frame.midX, y: 0.4 * frame.midY)
        addChild(self.timer)
        
        let dialogue = DialogueBubble(message: "Let's go!")
        dialogue.xScale = 0.35
        dialogue.yScale = 0.35
        dialogue.position = CGPoint(x: frame.midX * 1.5, y: frame.midY * 1.5)
        addChild(dialogue)
        
        bob.startAnimation()
    }

}

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
        
        let dialogue = DialogueBubble(message: "Let's go!", time: 2.0)
        dialogue.position = CGPoint(x: frame.midX * 1.3, y: frame.midY * 1.6)
        addChild(dialogue)
        
        let spawnDialogue = SKAction.repeatForever(SKAction.sequence([
            SKAction.wait(forDuration: 45, withRange: 15),
            SKAction.run {
                let bubble = DialogueBubble(message: "__random_doingTask", time: nil)
                bubble.position = CGPoint(x: self.frame.midX * 1.5, y: self.frame.midY * 1.5)
                self.addChild(bubble)
            }
        ]))
        
        bob.startAnimation()
        self.run(spawnDialogue)
    }

}

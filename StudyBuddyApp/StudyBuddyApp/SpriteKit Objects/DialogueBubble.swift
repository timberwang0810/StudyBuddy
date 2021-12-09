//
//  DialogueBubble.swift
//  StudyBuddyApp
//
//  Created by Jonathan Fischer on 12/8/21.
//

import UIKit
import SpriteKit

class DialogueBubble: SKSpriteNode {
    
    var textNode: SKLabelNode
    var selfDeleteAction: SKAction
    
    let doingTaskStrings:[String] = [
        "You can do this!",
        "Hang in there!",
        "You've got this!",
        "Let's get to work!"
    ]
    let playgroundStrings:[String] = [
        "How's your day?",
        "Let's go study!",
        "This room is cozy.",
        "I feel great today!"
    ]
    
    init(message: String, time: Double?) {
        var text: String
        if message == "__random_doingTask" {
            text = doingTaskStrings[Int.random(in: 0...(doingTaskStrings.count-1))]
        } else if message == "__random_playground" {
            text = playgroundStrings[Int.random(in: 0...(playgroundStrings.count-1))]
        } else {
            text = message
        }
        
        self.textNode = SKLabelNode(text: text)
        self.textNode.fontSize = 64
        self.textNode.fontName = "Chalkboard SE"
        self.textNode.fontColor = .black
        self.textNode.position = CGPoint(x: 0, y: -25)
        
        let bubble = SKTexture(imageNamed: "dialogue_bubble")
        
        selfDeleteAction = SKAction.sequence([
            SKAction.wait(forDuration: 0.35),
            SKAction.fadeIn(withDuration: 0.05),
            SKAction.wait(forDuration: time ?? 5.0),
            SKAction.fadeOut(withDuration: 0.05)
        ])
        
        super.init(texture: bubble, color: SKColor.clear, size: bubble.size())
        self.xScale = 0.45
        self.yScale = 0.45
        self.zPosition = 10
        
        self.addChild(self.textNode)
        self.alpha = 0.0
        self.run(selfDeleteAction)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}

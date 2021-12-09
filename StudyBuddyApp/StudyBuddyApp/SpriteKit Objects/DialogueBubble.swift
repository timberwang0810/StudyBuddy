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
    
    let strings:[String] = [
        "You can do this!",
        "Hang in there!",
        "You've got this!",
        "Let's get to work!"
    ]
    
    init(message: String?) {
        var text: String
        if message == nil {
            text = strings[Int.random(in: 0...(strings.count-1))]
        } else {
            text = message!
        }
        
        self.textNode = SKLabelNode(text: text)
        self.textNode.fontSize = 72
        self.textNode.fontName = "Chalkboard SE"
        self.textNode.fontColor = .black
        self.textNode.position = CGPoint(x: 0, y: -25)
        
        let bubble = SKTexture(imageNamed: "dialogue_bubble")
        
        selfDeleteAction = SKAction.sequence([
            SKAction.wait(forDuration: 0.35),
            SKAction.fadeIn(withDuration: 0.05),
            SKAction.wait(forDuration: 5.0),
            SKAction.fadeOut(withDuration: 0.05)
        ])
        
        super.init(texture: bubble, color: SKColor.clear, size: bubble.size())
        self.xScale = 0.35
        self.yScale = 0.35
        
        self.addChild(self.textNode)
        self.alpha = 0.0
        self.run(selfDeleteAction)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}

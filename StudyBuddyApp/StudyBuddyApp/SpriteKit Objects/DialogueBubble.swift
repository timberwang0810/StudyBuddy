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
        self.textNode.fontSize = 80
        self.textNode.fontName = "Chalkboard SE"
        self.textNode.fontColor = .black
        self.textNode.position = CGPoint(x: 0, y: -25)
        
        let bubble = SKTexture(imageNamed: "dialogue_bubble")
        
        super.init(texture: bubble, color: SKColor.clear, size: bubble.size())
        
        self.addChild(self.textNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}

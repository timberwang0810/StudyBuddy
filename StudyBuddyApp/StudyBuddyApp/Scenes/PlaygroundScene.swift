//
//  PlaygroundScene.swift
//  StudyBuddyApp
//
//  Created by Jonathan Fischer on 10/31/21.
//

import UIKit
import SpriteKit

class PlaygroundScene: SKScene {
        
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.gray
        
        let text = SKLabelNode(fontNamed: "Chalkduster")
        text.text = "Text!"
        text.fontSize = 65
        text.fontColor = SKColor.black
        text.position = CGPoint(x: size.width / 2, y: size.height / 2)
           
        addChild(text)
    }
    
    
}

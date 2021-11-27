//
//  PlaygroundFurniture.swift
//  StudyBuddyApp
//
//  Created by Jonathan Fischer on 11/21/21.
//

import UIKit
import SpriteKit

class PlaygroundFurniture: SKSpriteNode {
    
    let sprite: SKTexture
    
    init(sprite: SKTexture) {
        self.sprite = sprite
        
        super.init(color: SKColor.clear, size: sprite.size())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func changeDisplay(display: Bool) {
        self.isHidden = !display
    }


}

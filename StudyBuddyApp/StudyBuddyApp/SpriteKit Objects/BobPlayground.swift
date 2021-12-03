//
//  BobPlayground.swift
//  StudyBuddyApp
//
//  Created by Jonathan Fischer on 12/3/21.
//

import UIKit
import SpriteKit

enum BobState {
    case STANDING
    case WALKING_RIGHT
    case WALKING_LEFT
    case WAVING
}

class BobPlayground: SKSpriteNode {
    
    var state: BobState
    let midX: CGFloat
    
    var actions:[BobState: SKAction] = [:]
    var mainLoop: SKAction = SKAction()
    var currentAnimation: SKAction = SKAction()

    let atlases:[BobState: AnimatedSprite] = [
        BobState.STANDING: AnimatedSprite(timePerFrame: 1, atlasName: "bob_standing"),
        BobState.WALKING_RIGHT: AnimatedSprite(timePerFrame: 0.25, atlasName: "bob_walking_right"),
        BobState.WALKING_LEFT: AnimatedSprite(timePerFrame: 0.25, atlasName: "bob_walking_left"),
        BobState.WAVING: AnimatedSprite(timePerFrame: 0.5, atlasName: "bob_waving")
    ]
    
    init(midX: CGFloat) {
        self.state = BobState.WAVING
        self.midX = midX
                
        super.init(texture: atlases[self.state]!.frames[0], color: SKColor.clear, size: atlases[self.state]!.frames[0].size())
        
        self.zPosition = 1
        
        self.actions = [
            BobState.STANDING: SKAction.sequence([
                SKAction.run { print("Running state: Standing") },
                SKAction.wait(forDuration: Double.random(in: 0.4...1.2)),
                SKAction.run {
                    if self.position.x < self.midX {
                        self.changeState(state: BobState.WALKING_RIGHT)
                    }
                    else {
                        self.changeState(state: BobState.WALKING_LEFT)
                    }
                },
            ]),
            BobState.WALKING_RIGHT: SKAction.sequence([
                SKAction.run { print("Running state: Walking Right") },
                SKAction.wait(forDuration: 1.5),
                SKAction.run {
                    self.changeState(state: BobState.STANDING)
                },
            ]),
            BobState.WALKING_LEFT: SKAction.sequence([
                SKAction.run { print("Running state: Walking Left") },
                SKAction.wait(forDuration: 1.5),
                SKAction.run {
                    self.changeState(state: BobState.STANDING)
                },
            ]),
            BobState.WAVING: SKAction.sequence([
                SKAction.run { print("Running state: Waving") },
                SKAction.wait(forDuration: 2.0),
                SKAction.run {
                    self.changeState(state: BobState.STANDING)
                },
            ]),
        ]
        
        self.mainLoop = SKAction.repeatForever(SKAction.sequence([
            SKAction.run {
                self.texture = self.getCurrentAnimation().frames[0]
                self.currentAnimation = self.getCurrentAnimation().animation
                self.run(self.currentAnimation)
            },
            self.getActionForCurrentState()
        ]))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getCurrentAnimation() -> AnimatedSprite {
        return self.atlases[self.state]!
    }
    
    func getActionForCurrentState() -> SKAction {
        return self.actions[self.state]!
    }
    
    func runMainLoop() {
        self.run(self.mainLoop)
    }
    
    func changeState(state: BobState) {
        self.state = state
    }
    
    
}

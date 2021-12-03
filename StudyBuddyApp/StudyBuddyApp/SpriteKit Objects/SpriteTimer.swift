//
//  Timer.swift
//  StudyBuddyApp
//
//  Created by Jonathan Fischer on 11/10/21.
//

import SwiftUI
import UIKit
import SpriteKit

class SpriteTimer: SKLabelNode {

    // isPaused is a SpriteKit variable name
    var isTimerPaused: Bool
    var timeRemaining: Double
    
    var timerAction: SKAction
    
    
    init(timeRemaining: Double) {
        self.isTimerPaused = false
        self.timeRemaining = timeRemaining
        
        // Dummy initialization
        self.timerAction = SKAction()
        
        super.init()
        
        self.timerAction = SKAction.repeatForever(SKAction.sequence([
            SKAction.run {
                if !self.isTimerPaused {
                    self.timeRemaining -= 0.1
                }
                self.updateText()
            },
            SKAction.wait(forDuration: 0.1)
        ]))
        
        self.fontSize = 35
        self.fontName = "Chalkboard SE"
        self.fontColor = .black
        self.horizontalAlignmentMode = .right
        
        updateText()
        self.run(self.timerAction, withKey: "timer")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func countDownString() -> String {
        let remainingTimePositive = abs(self.timeRemaining)
        
        let hours = (Int(remainingTimePositive) / 3600)
        let minutes = Int(remainingTimePositive / 60) - Int(hours * 60)
        let seconds = Int(remainingTimePositive) - (Int(remainingTimePositive / 60) * 60) + (self.timeRemaining < 0 ? 1 : 0)
      
      return String(format: "%0.2d:%0.2d:%0.2d",hours,minutes,seconds)
    }
    
    func updateText() {
        self.text = (self.timeRemaining < 0 ? "Overtime! " : "") + self.countDownString()
        self.fontColor = self.timeRemaining < 0 ? .gray : .black
    }
    
    func setRemainingTime(timeRemaining: Double) {
        self.timeRemaining = timeRemaining
    }
    
    func startTimer() {
        self.isTimerPaused = false
        self.timerAction.speed = 1
    }
    func stopTimer() {
        self.isTimerPaused = true
        self.timerAction.speed = 0
    }
}

//
//  Timer.swift
//  StudyBuddyApp
//
//  Created by Jonathan Fischer on 11/10/21.
//

import SwiftUI
import UIKit
import SpriteKit

class Timer: SKLabelNode {

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
        
        updateText()
        self.run(self.timerAction, withKey: "timer")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func countDownString() -> String {
        let hours = (Int(self.timeRemaining) / 3600)
        let minutes = Int(self.timeRemaining / 60) - Int(hours * 60)
        let seconds = Int(self.timeRemaining) - (Int(timeRemaining / 60) * 60)
      
      return String(format: "%0.2d:%0.2d:%0.2d",hours,minutes,seconds)
    }
    
    func updateText() {
        self.text = self.countDownString()
    }
    
    func setRemainingTime(timeRemaining: Double) {
        self.timeRemaining = timeRemaining
    }
    
    func startTimer() {
        self.isTimerPaused = false
        self.timerAction.speed = 1
        print("Timer started!")
    }
    func stopTimer() {
        self.isTimerPaused = true
        self.timerAction.speed = 0
        print("Timer stopped.")
    }
}

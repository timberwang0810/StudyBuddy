//
//  Task.swift
//  StudyBuddyApp
//
//  Created by Tim Wang on 10/27/21.
//

import Foundation

enum TaskCategory{
  case STUDY, WORK, CHORES, EXERCISE, OTHERS
}

class Task{
  let name : String
  var baseReward: Int
  let duration: TimeInterval
  var category: TaskCategory
  
  private var hasTaskStarted: Bool
  private var startTime: NSDate?
  
  var elapsedTime: TimeInterval {
    if let startTime = self.startTime {
      return -1 * startTime.timeIntervalSinceNow // could also just say -startTime.timeIntervalSinceNow
    } else {
      return 0
    }
  }
  
  init(name: String, duration: TimeInterval, category: TaskCategory){
    self.name = name
    self.duration = duration
    self.category = category
    self.baseReward = Task.calculateBaseRewards(duration: duration)
    self.hasTaskStarted = false
  }
  
  func start() {
    self.hasTaskStarted = true
    startTime = NSDate()
  }
  
  func stopAndCollectReward(timeElapsed: Int) -> Bool{
    if (!self.hasTaskStarted) {
      // shouldn't happen
      return false;
    }
    return true;
  }
  
  private static func calculateBaseRewards(duration: TimeInterval) -> Int{
    // TODO: Reward calculation function
    return 100
  }
  
}

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
    if (self.hasTaskStarted) {
      // shouldn't happen
      return
    }
    self.hasTaskStarted = true
    startTime = NSDate()
  }
  
  func stopAndCollectReward() -> Int{
    if (!self.hasTaskStarted) {
      // shouldn't happen
      return 0;
    }
    return Task.calculateFinalRewards(baseReward: self.baseReward, timeEstimated: self.duration, timeActual: self.elapsedTime)
  }
  
  private static func calculateBaseRewards(duration: TimeInterval) -> Int{
    // TODO: Reward calculation function
    return 100
  }
  
  private static func calculateFinalRewards(baseReward: Int, timeEstimated: TimeInterval, timeActual: TimeInterval) -> Int{
    // TODO: Reward calculation function
    return baseReward
  }
}

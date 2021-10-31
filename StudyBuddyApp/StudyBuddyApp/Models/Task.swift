import Foundation

enum TaskCategory: String, CaseIterable {
    case STUDY = "Study"
    case WORK = "Work"
    case CHORES = "Chores"
    case EXERCISE = "Exercise"
    case OTHER = "Other"
}

class Task : Equatable{
  let name : String
  private var baseReward: Int
  let duration: TimeInterval
  let category: TaskCategory
  
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
  
  public func getBaseReward() -> Int{
    return self.baseReward;
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
  
  static func == (lhs: Task, rhs: Task) -> Bool{
    return lhs === rhs
  }
  
  static func calculateBaseRewards(duration: TimeInterval) -> Int{
    // TODO: Reward calculation function
    return Int(duration) / 50
  }
  
  private static func calculateFinalRewards(baseReward: Int, timeEstimated: TimeInterval, timeActual: TimeInterval) -> Int{
    // TODO: Reward calculation function
    return baseReward
  }
}

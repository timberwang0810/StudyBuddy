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
  let baseReward: Int
  let duration: TimeInterval
  let category: TaskCategory
  
  private var hasTaskStarted: Bool
  private var hasTaskEnded: Bool
  private var startTime: NSDate?
  private var endTime: NSDate?
  
  var elapsedTime: TimeInterval {
    if let startTime = self.startTime {
      if let endTime = self.endTime {
        return endTime.timeIntervalSince(startTime as Date)
      }
      return -startTime.timeIntervalSinceNow
    }
    return 0
  }
  
  init(name: String, duration: TimeInterval, category: TaskCategory){
    self.name = name
    self.duration = duration
    self.category = category
    self.baseReward = Task.calculateBaseRewards(duration: duration)
    self.hasTaskStarted = false
    self.hasTaskEnded = false
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
    self.hasTaskEnded = true
    self.endTime = NSDate()
    return Task.calculateFinalRewards(baseReward: self.baseReward, timeEstimated: self.duration, timeActual: self.elapsedTime)
  }
  
  public func isTaskStarted() -> Bool{
    return self.hasTaskStarted
  }
  
  public func isTaskEnded() -> Bool {
    return self.hasTaskEnded
  }
  
  public func getStartTime() -> NSDate?{
    if (self.startTime != nil) {
      return self.startTime
    }
    return nil
  }
  
  public func getEndTime() -> NSDate?{
    if (self.endTime != nil) {
      return self.endTime
    }
    return nil
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

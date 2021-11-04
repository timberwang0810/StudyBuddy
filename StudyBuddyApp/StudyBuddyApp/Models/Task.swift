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
  var finalReward: Int
  
  private var hasTaskStarted: Bool
  private var hasTaskEnded: Bool
  
  init(name: String, duration: TimeInterval, category: TaskCategory){
    self.name = name
    self.duration = duration
    self.category = category
    self.baseReward = Task.calculateBaseRewards(duration: duration)
    self.hasTaskStarted = false
    self.hasTaskEnded = false
    self.finalReward = 0
  }
  
  func start() {
    if (self.hasTaskStarted) {
      // shouldn't happen
      return
    }
    self.hasTaskStarted = true
  }
  
  func complete(timeRemaining: TimeInterval){
    if (!self.hasTaskStarted) {
      // shouldn't happen
      return;
    }
    self.hasTaskEnded = true
    self.finalReward = Task.calculateFinalRewards(baseReward: self.baseReward, timeEstimated: self.duration, timeActual: abs(self.duration-timeRemaining))
  }
  
  public func isTaskStarted() -> Bool{
    return self.hasTaskStarted
  }
  
  public func isTaskEnded() -> Bool {
    return self.hasTaskEnded
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
    return (baseReward * 5 / 4) + 3
  }
}

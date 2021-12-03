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
  var timedReward: Int
  var finalReward: Int
  var bonusReward: Int
  
  private var hasTaskStarted: Bool
  private var hasTaskEnded: Bool
  
  init(name: String, duration: TimeInterval, category: TaskCategory){
    self.name = name
    self.duration = duration
    self.category = category
    self.baseReward = Task.calculateBaseRewards(duration: duration)
    self.hasTaskStarted = false
    self.hasTaskEnded = false
    self.timedReward = 0
    self.finalReward = 0
    self.bonusReward = 0
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
    self.timedReward = Task.calculateBaseRewards(duration: self.duration-timeRemaining)
    self.finalReward = Task.calculateFinalRewards(baseReward: self.timedReward, timeEstimated: self.duration, timeActual: self.duration-timeRemaining)
    self.bonusReward = Task.calculateBonusRewards(baseReward: self.timedReward)
  }
  
  public func isTaskStarted() -> Bool{
    return self.hasTaskStarted
  }
  
  public func isTaskEnded() -> Bool {
    return self.hasTaskEnded
  }
  
  public func updateTimedReward(timeRemaining: TimeInterval){
    self.timedReward = Task.calculateBaseRewards(duration: self.duration-timeRemaining)
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
    return baseReward + calculateBonusRewards(baseReward: baseReward)
  }
  private static func calculateBonusRewards(baseReward: Int) -> Int{
    // TODO: Reward calculation function
    if (baseReward <= 5) {
      return 0
    }
    if (baseReward <= 10) {
      return 2
    }
    return (baseReward / 5) + 3
  }
}

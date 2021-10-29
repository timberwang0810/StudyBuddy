//
//  User.swift
//  StudyBuddyApp
//
//  Created by Tim Wang on 10/28/21.
//

import Foundation

enum CurrentTaskState{
  case Started, Paused, Completed, Idle
}
class User{
  
  private var money: Int
  private var tasks: [Task]
  private var taskState: CurrentTaskState
  
  init(){
    self.money = 0
    self.tasks = []
    self.taskState = CurrentTaskState.Idle
  }
  
  public func getTasks() -> [Task] {
    return self.tasks
  }
  
  public func addTask(newTask: Task) {
    self.tasks.append(newTask)
  }
  
  public func removeTask(task: Task){
    for (index, element) in self.tasks.enumerated(){
      if (element === task){
        self.tasks.remove(at: index)
        break
      }
    }
  }
  
  public func getMoney() -> Int {
    return self.money
  }
  
  public func earnMoney(inc : Int){
    self.money += inc
  }
  
  public func spendMoney(dec : Int){
    self.money -= dec
  }
  
  public func getCurrentAppState() -> CurrentTaskState{
    return taskState
  }
  
  public func updateCurrentAppState(newState: CurrentTaskState) {
    taskState = newState
  }
}

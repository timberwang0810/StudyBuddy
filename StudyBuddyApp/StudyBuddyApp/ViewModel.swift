//
//  ViewModel.swift
//  StudyBuddyApp
//
//  Created by austin on 10/27/21.
//

import SwiftUI

// Contains model logic we want to access from views through published variables.
// Write functions in here to be called that change models (e.g. when a button is clicked)
class ViewModel: ObservableObject {
//  State we want to update view with when it changes
    @Published var currentTask: Task?
  @Published var store: Store = Store()
  @Published var playground: Playground = Playground()
  @Published var character: Character = Character(name: "Bob")
  @Published var user: User = User()
    @Published var showTaskErrorMessage: Bool = false
  
    func createTask(name: String, duration: TimeInterval, category: TaskCategory, isStarted: Bool, completion: @escaping () -> Void) {
        if (name == "") {
            showTaskErrorMessage = true
            return
        }
        showTaskErrorMessage = false
        
        currentTask = Task(name: name, duration: duration, category: category)
        if (isStarted) {
            currentTask?.start()
        }
        
        print("Created Task:")
        print("Name: \(currentTask!.name)")
        print("Duration: \(currentTask!.duration)")
        print("Category: \(currentTask!.category)")
        
        completion()
    }
  
  func stopTask(timeRemaining: TimeInterval){
    currentTask!.complete(timeRemaining: timeRemaining)
  }
  
  func getTaskReward() -> Int{
    return currentTask!.finalReward
  }
  
  func earnMoney(inc: Int) {
    user.earnMoney(inc: inc)
  }
  
  func getCurrentMoney() -> Int{
    return user.getMoney()
  }
}


//
//  DoingTaskView.swift
//  StudyBuddyApp
//
//  Created by austin on 10/30/21.
//

import SwiftUI
import SpriteKit
import UserNotifications

struct DoingTaskView: View {
  @ObservedObject var viewModel: ViewModel
  @EnvironmentObject var viewRouter: ViewRouter
  
  @State var hours: Int = 0
  @State var minutes: Int = 0
  @State var seconds: Int = 0
  @State var timerIsPaused: Bool = false
  @State var timeRemaining: Double = 0.0
  @State private var showingConfirmationAlert = false
  
  @ObservedObject var sceneStore: SceneStore
  
  let SMALL_BUTTON_SIZE: CGFloat = 20.0
  let BUTTON_SIZE: CGFloat = 64.0
  
  init( viewModel: ViewModel) {
    self.viewModel = viewModel
    _timeRemaining = State(initialValue: viewModel.currentTask!.duration)
    
    self.sceneStore = SceneStore(
      scene: DoingTaskScene(size: CGSize(width: 400, height: 700), duration: viewModel.currentTask!.duration, taskCategory: viewModel.currentTask!.category)
    )
  }
  
  var body: some View {
//    Text("Hey! I'm doing my task and so should you! I'm not gonna do it unless you come back and do it with me!")
//        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
//          self.pauseTimer()
//        }
//    Text("Welcome Back!")
//        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
//          self.startTimer()
//        }
    ZStack{
      SpriteView(scene: sceneStore.scene)
        .frame(width: 400, height: 700)
        .edgesIgnoringSafeArea(.all)
      
      VStack{
        HStack{
          VStack(alignment: .leading, spacing: 0) {
            Text(viewModel.getTaskName()).font(Font.custom("Chalkboard SE", size: 24))
            Text(calculateTime()).font(Font.custom("Chalkboard SE", size: 12))
          }.padding(.horizontal, 20)
          
          Spacer()
          
          Button(action:{
            self.showingConfirmationAlert = true
          }){
            Image(systemName: "x.circle")
              .resizable()
              .scaledToFill()
              .frame(width: SMALL_BUTTON_SIZE, height: SMALL_BUTTON_SIZE)
              .padding(.trailing, 20)
          }
          .contentShape(Circle())
          .offset(y: -5)
          .alert(isPresented: $showingConfirmationAlert) {
            Alert(
              title: Text("Are you sure you want to stop your task?"),
              message: Text("You will lose current progress towards your rewards."),
              primaryButton: .destructive(Text("Stop Task"), action: {
                self.viewRouter.currentPage = .tabbedPage
              }),
              secondaryButton: .default(Text("Cancel"), action: {
                self.showingConfirmationAlert = false
              })
            )
          }
        }
        
        Spacer()
        VStack(alignment: .trailing){
          HStack{
            if self.timerIsPaused {
              
              Button(action:{
                self.startTimer()
              }){
                Image(systemName: "play.circle")
                  .resizable()
                  .scaledToFill()
                  .frame(width: BUTTON_SIZE, height: BUTTON_SIZE)
                  .padding()
              }.contentShape(Circle())
              
            } else {
              Button(action:{
                self.pauseTimer()
              }){
                Image(systemName: "pause.circle")
                  .resizable()
                  .scaledToFill()
                  .frame(width: BUTTON_SIZE, height: BUTTON_SIZE)
                  .padding()
              }.contentShape(Circle())
              
            }
            
            Button(action:{
              finishTask()
            }){
              Image(systemName: "checkmark.circle")
                .resizable()
                .scaledToFill()
                .frame(width: BUTTON_SIZE, height: BUTTON_SIZE)
                .padding()
            }.contentShape(Circle())
          }
        }
      }
    }.onReceive(NotificationCenter.default.publisher(for: UIApplication.didEnterBackgroundNotification)) { _ in
      print("Moving to the background!")
      self.pauseTimer()
      let content = UNMutableNotificationContent()
      content.title = "Come back!🥺"
      content.body = "Please come back and do task with me ~"
      content.sound = UNNotificationSound.default

      // show this notification five seconds from now
      let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

      // choose a random identifier
      let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

      // add our notification request
      UNUserNotificationCenter.current().add(request)
    }.onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
      self.startTimer()
    }.onReceive(NotificationCenter.default.publisher(for: UIApplication.willTerminateNotification)) { _ in
      print("will terminate")
      UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
    
  }
  
  func calculateTime() -> String{
    let date : Date = Date()
    let dateFormatter = DateFormatter()
    
    dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
    
    let todaysDate = dateFormatter.string(from: date)
    return todaysDate
  }
  
  func startTimer(){
    timerIsPaused = false
    self.sceneStore.scene.isPaused = false
  }
  
  func pauseTimer(){
    timerIsPaused = true
    self.sceneStore.scene.isPaused = true
  }
  
  func finishTask() {
    let scene = self.sceneStore.scene as! DoingTaskScene
    self.viewModel.stopTask(timeRemaining: scene.timer.timeRemaining)
    self.viewRouter.currentPage = .rewardsPage
  }
  
}


struct DoingTaskView_Previews: PreviewProvider {
  static var previews: some View {
    DoingTaskView(viewModel: ViewModel()).environmentObject(ViewRouter())
  }
  
}

//
//  DoingTaskView.swift
//  StudyBuddyApp
//
//  Created by austin on 10/30/21.
//

import SwiftUI
import SpriteKit
import UserNotifications
import SwiftySound

struct DoingTaskView: View {
  @ObservedObject var viewModel: ViewModel
  @EnvironmentObject var viewRouter: ViewRouter
  
  @State var hours: Int = 0
  @State var minutes: Int = 0
  @State var seconds: Int = 0
  @State var timerIsPaused: Bool = false
  @State var timeRemaining: Double = 0.0
  @State private var showingStopAlert = false
  @State private var showingCompleteAlert = false
  
  @ObservedObject var sceneStore: SceneStore
  
  let SMALL_BUTTON_SIZE: CGFloat = 20.0
  let BUTTON_SIZE: CGFloat = 64.0
  
  private var currBGM : Sound?
  private var bgm_1_url : URL?
  
  init( viewModel: ViewModel) {
    self.viewModel = viewModel
    _timeRemaining = State(initialValue: viewModel.currentTask!.duration)
    
    self.sceneStore = SceneStore(
      scene: DoingTaskScene(size: CGSize(width: 400, height: 700), duration: viewModel.currentTask!.duration, taskCategory: viewModel.currentTask!.category)
    )
    
    if let bgm1Url = Bundle.main.url(forResource: "bgm_1", withExtension: "mp3") {
      bgm_1_url = bgm1Url
      currBGM = Sound(url: bgm1Url)
      currBGM?.volume = 0.8
      currBGM?.prepare()
    }
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
        .frame(width: 360, height: 630)
        .edgesIgnoringSafeArea(.all)
      
      VStack{
        HStack{
          VStack(alignment: .leading, spacing: 0) {
            Text(viewModel.getTaskName()).font(Font.custom("Chalkboard SE", size: 24))
            Text(calculateTime()).font(Font.custom("Chalkboard SE", size: 12))
          }.padding(.horizontal, 20)
          
          Spacer()
          
          Button(action:{
            self.showingStopAlert = true
          }){
            Image(systemName: "x.circle")
              .resizable()
              .scaledToFill()
              .frame(width: SMALL_BUTTON_SIZE, height: SMALL_BUTTON_SIZE)
              .padding(.trailing, 20)
          }
          .contentShape(Circle())
          .offset(y: -5)
          .alert(isPresented: $showingStopAlert) {
            Alert(
              title: Text("Are you sure you want to stop your task?"),
              message: Text("You will lose current progress towards your rewards."),
              primaryButton: .destructive(Text("Stop Task"), action: {
                self.viewRouter.currentPage = .tabbedPage
              }),
              secondaryButton: .default(Text("Cancel"), action: {
                self.showingStopAlert = false
              })
            )
          }
        }.padding(.top, 10)
        
        Spacer()
        VStack(alignment: .trailing){
          HStack{
            if self.timerIsPaused {
              
              Button(action:{
                self.startTimer()
                self.enableBGM()
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
                self.disableBGM()
              }){
                Image(systemName: "pause.circle")
                  .resizable()
                  .scaledToFill()
                  .frame(width: BUTTON_SIZE, height: BUTTON_SIZE)
                  .padding()
              }.contentShape(Circle())
              
            }
            
            Button(action:{
              self.showingCompleteAlert = true
            }){
              Image(systemName: "checkmark.circle")
                .resizable()
                .scaledToFill()
                .frame(width: BUTTON_SIZE, height: BUTTON_SIZE)
                .padding()
            }.contentShape(Circle())
            .alert(isPresented: $showingCompleteAlert) {
              Alert(
                title: Text("Done with your task?"),
                message: Text("Your reward may vary based on how much time you've spent working."),
                primaryButton: .default(Text("I'm done!"), action: {
                  finishTask()
                }),
                secondaryButton: .default(Text("Cancel"), action: {
                  self.showingCompleteAlert = false
                })
              )
            }
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
    }.onDisappear{
      self.disableBGM()
    }.onAppear{
      self.enableBGM()
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
  
  private func enableBGM(){
    guard let bgmSound = self.currBGM else {return}
    if (!bgmSound.resume()){
      bgmSound.play(numberOfLoops: -1)
    }
  }
  
  private func disableBGM(){
    self.currBGM?.pause()
  }

}


struct DoingTaskView_Previews: PreviewProvider {
  static var previews: some View {
    DoingTaskView(viewModel: ViewModel()).environmentObject(ViewRouter())
  }

}

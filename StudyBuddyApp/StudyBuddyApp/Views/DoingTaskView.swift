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
  @State private var currBGM : Int = Int.random(in: 0...4)
  
  @ObservedObject var sceneStore: SceneStore
  
  let SMALL_BUTTON_SIZE: CGFloat = 20.0
  let BUTTON_SIZE: CGFloat = 64.0
  
  /**
   SOUND ATTRIBUTION (bgm_#):
   1. "Equinox" by Purrple Cat https://www.chosic.com/download-audio/28547/
   2. "bedtime after a coffee" by Barradeen  https://www.chosic.com/download-audio/26756/
   3. "[Lofi Study Music] Morning Routine by Ghostrifter Official https://www.chosic.com/download-audio/29425/
   4. "Coral" by LiQWYD https://www.chosic.com/download-audio/28067/
   5. "Field of Fireflies" by Purrple Cat https://www.chosic.com/download-audio/28546/
  **/
  private var bgms : [Sound?]
  
  init( viewModel: ViewModel) {
    self.viewModel = viewModel
    
    _timeRemaining = State(initialValue: viewModel.currentTask!.duration)
    
    self.sceneStore = SceneStore(
      scene: DoingTaskScene(size: CGSize(width: 400, height: 700), duration: viewModel.currentTask!.duration, taskCategory: viewModel.currentTask!.category)
    )
    self.bgms = [Sound?]()
    for i in 1...5{
      if let bgmUrl = Bundle.main.url(forResource: "bgm_\(i)", withExtension: "mp3") {
        let bgm = Sound(url: bgmUrl)
        print("reached \(i)")
        self.bgms.append(bgm)
      }
    }
  }
  
  var body: some View {
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
            Sound.play(file: "click", fileExtension: "wav", numberOfLoops: 0)
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
                Sound.play(file: "click", fileExtension: "wav", numberOfLoops: 0)
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
                Sound.play(file: "click", fileExtension: "wav", numberOfLoops: 0)
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
              Sound.play(file: "click", fileExtension: "wav", numberOfLoops: 0)
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
      self.disableBGM()
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
      self.enableBGM()
      self.startTimer()
    }.onReceive(NotificationCenter.default.publisher(for: UIApplication.willTerminateNotification)) { _ in
      print("will terminate")
      UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }.onDisappear{
      for (_, element) in bgms.enumerated(){
        element?.stop()
      }
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
    let bgmSoundIndex = self.currBGM
    guard let bgmSound = self.bgms[bgmSoundIndex] else {return}
    if (!bgmSound.resume()){
      bgmSound.play(numberOfLoops: 0, completion: onBGMFinished)
    }
  }
  
  private func disableBGM(){
    self.bgms[currBGM]?.pause()
  }
  
  private func onBGMFinished(completed: Bool){
    print("called")
    let oldBGM = self.currBGM
    while (self.currBGM == oldBGM){
      self.currBGM = Int.random(in: 0..<bgms.count)
    }
    self.enableBGM()
  }
}


struct DoingTaskView_Previews: PreviewProvider {
  static var previews: some View {
    DoingTaskView(viewModel: ViewModel()).environmentObject(ViewRouter())
  }

}

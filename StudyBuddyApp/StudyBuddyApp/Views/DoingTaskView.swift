//
//  DoingTaskView.swift
//  StudyBuddyApp
//
//  Created by austin on 10/30/21.
//

import SwiftUI
import SpriteKit

struct DoingTaskView: View {
  @ObservedObject var viewModel: ViewModel
  @EnvironmentObject var viewRouter: ViewRouter
  
  @State var hours: Int = 0
  @State var minutes: Int = 0
  @State var seconds: Int = 0
  @State var timerIsPaused: Bool = false
  @State var timeRemaining: Double = 0.0
    
    @ObservedObject var sceneStore: SceneStore
  
  init( viewModel: ViewModel) {
    self.viewModel = viewModel
        _timeRemaining = State(initialValue: viewModel.currentTask!.duration)
    
    self.sceneStore = SceneStore(
        scene: DoingTaskScene(size: CGSize(width: 400, height: 700), duration: viewModel.currentTask!.duration)
    )
  }
  
  var body: some View {
    ZStack{
      
        SpriteView(scene: sceneStore.scene)
                    .frame(width: 400, height: 700)
                    .edgesIgnoringSafeArea(.all)
      VStack{
        HStack{
          Text(calculateTime()).font(Font.custom("Chalkboard SE", size: 24))
            .padding(10)
          Spacer()
      }
        
      Spacer()
      VStack(alignment: .trailing){
        
        HStack{
            if self.timerIsPaused {
            
            Button(action:{
              self.startTimer()
            }){
              Image(systemName: "play.fill")
                .padding()
            }
            
          } else {
            Button(action:{
              self.pauseTimer()
            }){
              Image(systemName: "pause.fill")
                .padding()
            }
            
          }
          
          Button(action:{
            self.viewRouter.currentPage = .tabbedPage
          }){
            Image(systemName: "stop.fill")
              .padding()
          }
          //            .padding()
        }
      }
    }
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
  
}


struct DoingTaskView_Previews: PreviewProvider {
  static var previews: some View {
    DoingTaskView(viewModel: ViewModel()).environmentObject(ViewRouter())
  }
  
}

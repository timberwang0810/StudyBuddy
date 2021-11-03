//
//  DoingTaskView.swift
//  StudyBuddyApp
//
//  Created by austin on 10/30/21.
//

import SwiftUI

struct DoingTaskView: View {
    @ObservedObject var viewModel: ViewModel
    @EnvironmentObject var viewRouter: ViewRouter
  
  
    
    @State var hours: Int = 0
    @State var minutes: Int = 0
    @State var seconds: Int = 0
    @State var timerIsPaused: Bool = false
    @State var timeRemaining: Double = 0.0
  
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
  
    
    init( viewModel: ViewModel) {
              self.viewModel = viewModel
             _timeRemaining = State(initialValue: viewModel.currentTask!.duration)
    }

    var body: some View {
      HStack{
      //"\(self.timeRemaining)"
      //(countDownString(timeRemaining: self.timeRemaining)
        Text((countDownString(timeRemaining: timeRemaining))
      )}.onReceive(timer) { time in
        if timeRemaining > 0.0 && !timerIsPaused {
          print(timeRemaining)
          timeRemaining -= 1.0
        }
      }
      HStack {
        if timerIsPaused {
          
            Button(action:{
              print("START")
              self.startTimer()
            }){
              Image(systemName: "play.fill")
                .padding(.all)
            }
            .padding(.all)
        } else {
          Button(action:{
                  print("Paused")
              self.pauseTimer()
                  }){
                    Image(systemName: "pause.fill")
                      .padding(.all)
                  }
                  .padding(.all)
        }
      
        Button(action:{
                print("Stop")
          self.viewRouter.currentPage = .tabbedPage
            self.stopTimer()
                }){
                  Image(systemName: "stop.fill")
                    .padding(.all)
                }
            .padding(.all)
        
      }
    }
      
  
    func startTimer(){
        timerIsPaused = false
    }
    func pauseTimer(){
        timerIsPaused = true
    }
    
  func stopTimer(){
    
  }
  
  func countDownString(timeRemaining: Double) -> String {
    let hours = (Int(timeRemaining) / 3600)
        let minutes = Int(timeRemaining / 60) - Int(hours * 60)
        let seconds = Int(timeRemaining) - (Int(timeRemaining / 60) * 60)

        return String(format: "%0.2d:%0.2d:%0.2d",hours,minutes,seconds)
  }

}


struct DoingTaskView_Previews: PreviewProvider {
    static var previews: some View {
      DoingTaskView(viewModel: ViewModel()).environmentObject(ViewRouter())
    }

}

//
//  TasksView.swift
//  StudyBuddyApp
//
//  Created by austin on 10/27/21.
//

import SwiftUI
import SwiftySound

struct TasksView: View {
  @ObservedObject var viewModel: ViewModel
  @EnvironmentObject var viewRouter: ViewRouter
  
  @State var name: String = ""
  @State var duration: TimeInterval = TimeInterval(1200)
  @State private var selection: TaskCategory = .STUDY
  
  var body: some View {
    ZStack {
      Color(red: 241 / 255, green: 241 / 255, blue: 241 / 255).edgesIgnoringSafeArea([.top])
      VStack {
        
        VStack(alignment: .leading) {
          Text("New Task")
            .font(Font.custom("Chalkboard SE", size: 24))
            .padding(.bottom, 10)
            .padding(.horizontal);
          
          VStack(alignment: .leading, spacing: 0) {
            HStack {
              Text("Name")
                .fontWeight(.light)
                + Text("*")
                .fontWeight(.light)
                .foregroundColor(.red)
              TextField("Task Name", text: $name)
                .padding(.horizontal)
                .cornerRadius(3.0);
            }
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding(.horizontal)
            
            if (viewModel.showTaskErrorMessage) {
              Text("Please provide a name for your task!")
                .font(Font.custom("Chalkboard SE", size: 10))
                .foregroundColor(.red)
                .padding(.horizontal)
            }
          }
          
          VStack(alignment: .leading, spacing: -15) {
            Text("Duration")
              .fontWeight(.light)
            DurationPicker(duration: $duration)
              .padding(.horizontal)
          }.padding(.horizontal)
          
          HStack {
            Text("Category")
              .fontWeight(.light)
            Picker("\(selection.rawValue)", selection: $selection) {
              ForEach(TaskCategory.allCases.reversed(), id: \.self) {
                Text($0.rawValue)
              }
            }
            .pickerStyle(MenuPickerStyle())
            .padding(.vertical, 1)
            .padding(.horizontal, 25)
            .frame(width: 125)
            .overlay(
              RoundedRectangle(cornerRadius: 10)
                .stroke(Color(red: 230 / 255, green: 230 / 255, blue: 230 / 255), lineWidth: 2))
          }.padding(.horizontal)
        }
        .font(Font.custom("Chalkboard SE", size: 18))
        .padding(.horizontal, 20)
        .padding(.bottom, 20)
        
        VStack(alignment: .center) {
          VStack (spacing: 0) {
            Text("Expected Reward")
              .fontWeight(.light)
            HStack {
              Image("coin")
              Text("\(Task.calculateBaseRewards(duration: duration))+")
                .font(Font.custom("Chalkboard SE", size: 34))
                .fontWeight(.light)
                .baselineOffset(5)
            }
          }
          .padding(.vertical, 10)
          .padding(.horizontal, 70)
          .overlay(
            RoundedRectangle(cornerRadius: 10)
              .stroke(Color(red: 230 / 255, green: 230 / 255, blue: 230 / 255), lineWidth: 2)
          )
        }
        .padding(15)
        
        Button(action: {
                Sound.play(file: "click", fileExtension: "wav", numberOfLoops: 0)
                self.viewModel.createTask(name: name, duration: duration, category: selection, isStarted: true, completion: {
          viewRouter.currentPage = .doingTaskPage
        })}) {
          Text("Start Now")
            .font(Font.custom("Chalkboard SE", size: 20))
            .fontWeight(.light)
        }
        .padding()
        .background(Color(red: 248 / 255, green: 208 / 255, blue: 116 / 255))
        .foregroundColor(.black)
        .cornerRadius(10)
        .shadow(color: Color(red: 185 / 255, green: 108 / 255, blue: 37 / 255), radius: 1, x: 0, y: 5)
      }
      .font(Font.custom("Chalkboard SE", size: 22))
      .padding(.vertical, 40)
      .frame(maxWidth: 385)
      .background(Color.white)
      .cornerRadius(10)
      .shadow(color: Color.gray, radius: 3, x: 0, y: 5)

    }    
  }
}

struct TasksView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      TasksView(viewModel: ViewModel()).environmentObject(ViewRouter())
      TasksView(viewModel: ViewModel()).environmentObject(ViewRouter())
    }
  }
}

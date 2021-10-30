//
//  TasksView.swift
//  StudyBuddyApp
//
//  Created by austin on 10/27/21.
//

import SwiftUI

struct TasksView: View {
    @ObservedObject var taskViewModel: ViewModel
    @State var name: String = ""
    @State var duration: TimeInterval = TimeInterval()
    @State private var selection: TaskCategory = .STUDY
    
    var body: some View {
        VStack {
            
            VStack(alignment: .leading) {
                Text("New Task")
                    .font(.largeTitle)
                    .padding();
                
                HStack {
                    Text("Name")
                    TextField("Task Name", text: $name)
                        .padding()
                        .cornerRadius(3.0);
                }
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
                
                VStack(alignment: .leading, spacing: -15) {
                    Text("Duration")
                    DurationPicker(duration: $duration)
                        .padding(.horizontal)
                }.padding(.horizontal)
                
                HStack {
                    Text("Category")
                    Picker("\(selection.rawValue)", selection: $selection) {
                        ForEach(TaskCategory.allCases.reversed(), id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                }.padding(.horizontal)
            }
            .padding(20)
            
            VStack(alignment: .center) {
                VStack{
                    Text("Reward")
                        .font(.headline)
                    HStack {
                        Image("coin")
                        Text("\(Task.calculateBaseRewards(duration: duration))+")
                            .font(.system(size: 45))
                    }
                    .padding(.horizontal)
                }
                .padding()
                .padding(.horizontal, 40)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(red: 230 / 255, green: 230 / 255, blue: 230 / 255), lineWidth: 2)
                )
            }
            .padding(20)
            
            Button("Start Now", action: {self.taskViewModel.createTask(name: name, duration: duration, category: selection, isStarted: true)})
                .padding()
                .background(Color(red: 248 / 255, green: 208 / 255, blue: 116 / 255))
                .foregroundColor(.black)
                .cornerRadius(10)
                .shadow(color: Color(red: 185 / 255, green: 108 / 255, blue: 37 / 255), radius: 1, x: 0, y: 5)
                .font(.title)
        }
    }
}

//struct TasksView_Previews: PreviewProvider {
//    static var previews: some View {
//        TasksView(taskViewModel: <#ViewModel#>)
//    }
//}

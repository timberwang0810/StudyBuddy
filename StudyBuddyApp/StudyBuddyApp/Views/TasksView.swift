//
//  TasksView.swift
//  StudyBuddyApp
//
//  Created by austin on 10/27/21.
//

import SwiftUI

struct TasksView: View {
    @ObservedObject var viewModel: ViewModel
    @EnvironmentObject var viewRouter: ViewRouter
    @State var name: String = ""
    @State var duration: TimeInterval = TimeInterval()
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
                    
                    HStack {
                        Text("Name")
                            .fontWeight(.light)
                        TextField("Task Name", text: $name)
                            .padding()
                            .cornerRadius(3.0);
                    }
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                    
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
                    }.padding(.horizontal)
                }
                .font(Font.custom("Chalkboard SE", size: 18))
                .padding(20)
                
                VStack(alignment: .center) {
                    VStack (spacing: 0) {
                        Text("Reward")
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
                .padding(20)
                
                Button(action: {self.viewModel.createTask(name: name, duration: duration, category: selection, isStarted: true, completion: {
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
                Spacer()
            }
            .font(Font.custom("Chalkboard SE", size: 22))
            .frame(maxWidth: 385, maxHeight: 725)
            .background(Color.white)
            .cornerRadius(10)
            .shadow(color: Color.gray, radius: 3, x: 0, y: 5)
        }
        
    }
}

struct TasksView_Previews: PreviewProvider {
    static var previews: some View {
        TasksView(viewModel: ViewModel()).environmentObject(ViewRouter())
    }
}

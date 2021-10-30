//
//  TasksView.swift
//  StudyBuddyApp
//
//  Created by austin on 10/27/21.
//

import SwiftUI

struct TasksView: View {
    @State var name: String = ""
    // TODO: Make this duration get updated when picker is updated
    @State var duration: TimeInterval = TimeInterval()
    @State private var selection = "Study"
    let categories = ["Other", "Exercise", "Chores", "Work", "Study"]
    
    var body: some View {
        VStack {
            
            VStack(alignment: .leading) {
                Text("New Task")
                    .font(.largeTitle)
                    .padding();
                
                HStack {
                    Text("Name")
                        .padding();
                    TextField("Task Name", text: $name)
                        .padding()
                        .cornerRadius(3.0);
                }
                .textFieldStyle(RoundedBorderTextFieldStyle())
                
                HStack {
                    Text("Duration")
                        .padding();
                    DurationPicker(duration: $duration)
                }
                
                HStack {
                    Text("Category")
                        .padding();
                    Picker("\(selection)", selection: $selection) {
                        ForEach(categories, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                }
            }
            .padding(20)
            
            VStack(alignment: .center) {
                VStack{
                    Text("Reward")
                        .font(.headline)
                    HStack {
                        Image("coin")
                        Text("\(Int(duration) / 50)+")
                            .font(.system(size: 45))
                    }
                    .padding(.horizontal)
                }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color(red: 230 / 255, green: 230 / 255, blue: 230 / 255), lineWidth: 3)
                )
            }
            .padding(20)
        }
    }
}

struct TasksView_Previews: PreviewProvider {
    static var previews: some View {
        TasksView()
    }
}

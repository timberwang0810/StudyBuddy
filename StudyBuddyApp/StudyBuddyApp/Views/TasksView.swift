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
        VStack(alignment: .leading) {
            HStack {
                Text("Name")
                    .padding();
                TextField("Task Name", text: $name)
                    .padding()
                    .cornerRadius(3.0);
            }
            
            HStack {
                Text("Duration")
                    .padding();
                DurationPicker(duration: $duration)
            }
            
            HStack {
                Text("Category")
                Picker("\(selection)", selection: $selection) {
                    ForEach(categories, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(MenuPickerStyle())
            }
            
            VStack {
                Text("Reward")
                    .font(.headline)
                HStack {
                    Image("coin")
                    Text("100+")
                }
            }
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 3)
                .stroke(lineWidth: 2)
            )
        }
        .padding(20)
        .textFieldStyle(RoundedBorderTextFieldStyle())
    }
}

struct TasksView_Previews: PreviewProvider {
    static var previews: some View {
        TasksView()
    }
}

//
//  TasksView.swift
//  StudyBuddyApp
//
//  Created by austin on 10/27/21.
//

import SwiftUI

struct TasksView: View {
    @State var name: String = ""
    @State var duration: TimeInterval = TimeInterval()
    
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
                DurationPicker(duration: .constant(duration))
            }
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

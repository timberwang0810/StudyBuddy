//
//  TasksView.swift
//  StudyBuddyApp
//
//  Created by austin on 10/27/21.
//

import SwiftUI

struct TasksView: View {
    @State var name: String = ""
    @State var duration: Date = Date()
    
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
                DatePicker("Duration", selection: $duration, displayedComponents: .hourAndMinute);
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

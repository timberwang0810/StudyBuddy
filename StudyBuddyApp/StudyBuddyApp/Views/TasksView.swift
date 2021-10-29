//
//  TasksView.swift
//  StudyBuddyApp
//
//  Created by austin on 10/27/21.
//

import SwiftUI

struct TasksView: View {
    @State var name: String = ""
    @State var hours: Int = 0
    @State var minutes: Int = 0
    
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
                TimeDurationPickerView(time: .constant(Time(hour: 0, minute: 30)))
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

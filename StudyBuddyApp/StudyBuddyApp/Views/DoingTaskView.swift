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

    var body: some View {
        Text("Doing Task View")
    }
}

struct DoingTaskView_Previews: PreviewProvider {
    static var previews: some View {
        DoingTaskView(viewModel: ViewModel()).environmentObject(ViewRouter())
    }
}

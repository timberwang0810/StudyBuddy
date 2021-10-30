//
//  TabbedView.swift
//  StudyBuddyApp
//
//  Created by austin on 10/30/21.
//

import SwiftUI

struct TabbedView: View {
    @ObservedObject var viewModel: ViewModel
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View {
        TabView {
            TasksView(viewModel: viewModel)
                .tabItem {
                    Label("Task", systemImage: "list.dash")
                }
            PlaygroundView()
                .tabItem {
                    Label("Playground", systemImage: "gamecontroller")
                }
        }
    }
}

struct TabbedView_Previews: PreviewProvider {
    static var previews: some View {
        TabbedView(viewModel: ViewModel()).environmentObject(ViewRouter())
    }
}
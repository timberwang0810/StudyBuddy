//
//  ContentView.swift
//  StudyBuddyApp
//
//  Created by Tim Wang on 10/25/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = ViewModel()
  
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

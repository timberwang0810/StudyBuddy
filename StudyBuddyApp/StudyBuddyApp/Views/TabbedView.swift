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
          PlaygroundView(viewModel: viewModel)
                .tabItem {
                    Label("Playground", systemImage: "gamecontroller")
                }
            TasksView(viewModel: viewModel)
                .tabItem {
                    Label("Task", systemImage: "list.dash")
                }
          StoreView(viewModel: viewModel)
                .tabItem {
                    Label("Store", systemImage: "cart")
                }
        }
    }
}

struct TabbedView_Previews: PreviewProvider {
    static var previews: some View {
        TabbedView(viewModel: ViewModel()).environmentObject(ViewRouter())
    }
}

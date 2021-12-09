//
//  TabbedView.swift
//  StudyBuddyApp
//
//  Created by austin on 10/30/21.
//

import SwiftUI
import SwiftySound

struct TabbedView: View {
    @ObservedObject var viewModel: ViewModel
    @EnvironmentObject var viewRouter: ViewRouter
  @State var selectedTab: Int = 1
    
    var body: some View {
      TabView(selection: $selectedTab){
          PlaygroundView(viewModel: viewModel)
                .tabItem {
                  Label("Playground", systemImage: "gamecontroller")                }.tag(1)
            TasksView(viewModel: viewModel)
                .tabItem {
                    Label("Task", systemImage: "list.dash")
                }.tag(2)
          StoreView(viewModel: viewModel)
                .tabItem {
                    Label("Store", systemImage: "cart")
                }.tag(3)
      }.onChange(of: selectedTab){_ in
        Sound.play(file: "switch", fileExtension: "mp3", numberOfLoops: 0)
      }
    }
}

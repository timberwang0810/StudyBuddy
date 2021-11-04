//
//  ContentView.swift
//  StudyBuddyApp
//
//  Created by Tim Wang on 10/25/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = ViewModel()
    @EnvironmentObject var viewRouter: ViewRouter

    var body: some View {
        switch viewRouter.currentPage {
            case .tabbedPage:
                TabbedView(viewModel: viewModel)
            case .doingTaskPage:
                DoingTaskView(viewModel: viewModel)
            case .rewardsPage:
                RewardsView(viewModel: viewModel)
          case .playgroundPage:
            PlaygroundView(viewModel: viewModel)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(ViewRouter())
    }
}

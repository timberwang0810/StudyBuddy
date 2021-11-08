//
//  ViewRouter.swift
//  StudyBuddyApp
//
//  Created by austin on 10/30/21.
//

import SwiftUI
import SwiftUIPager

class ViewRouter: ObservableObject {
    @Published var currentPage: Page = .tabbedPage
}

import Foundation

enum Page {
    case tabbedPage
    case doingTaskPage
    case rewardsPage
    case playgroundPage
}

//struct ViewRouter_Previews: PreviewProvider {
//    static var previews: some View {
//        ViewRouter()
//    }
//}

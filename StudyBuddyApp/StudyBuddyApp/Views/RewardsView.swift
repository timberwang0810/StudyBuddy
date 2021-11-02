//
//  RewardsView.swift
//  StudyBuddyApp
//
//  Created by austin on 11/2/21.
//

import SwiftUI

struct RewardsView: View {
    @ObservedObject var viewModel: ViewModel
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View {
        Text("Rewards View")
    }
}

struct RewardsView_Previews: PreviewProvider {
    static var previews: some View {
        RewardsView(viewModel: ViewModel()).environmentObject(ViewRouter())
    }
}

//
//  NavbarView.swift
//  StudyBuddyApp
//
//  Created by austin on 10/27/21.
//

import SwiftUI

struct NavbarView: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        Text("Navbar " + viewModel.testString)
    }
}

//struct NavbarView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavbarView()
//    }
//}

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
        VStack {
            Text("Hello, world!")
                .padding()
            NavbarView(viewModel: viewModel)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

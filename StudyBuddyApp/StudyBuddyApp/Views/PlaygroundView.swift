//
//  PlaygroundView.swift
//  StudyBuddyApp
//
//  Created by austin on 10/27/21.
//

import SwiftUI

struct PlaygroundView: View {
  @ObservedObject var viewModel: ViewModel
  @EnvironmentObject var viewRouter: ViewRouter
    var body: some View {
      VStack{
        HStack{
          Text("\(viewModel.getCurrentMoney())")
              .font(Font.custom("Chalkboard SE", size: 24))
              .baselineOffset(5)
              .padding(.trailing, 10)
          Image("coin")
              .resizable()
              .frame(width: 32.0, height: 32.0)
          
        }
      }
      
    }
}

struct PlaygroundView_Previews: PreviewProvider {
    static var previews: some View {
      PlaygroundView(viewModel: ViewModel()).environmentObject(ViewRouter())
    }
}

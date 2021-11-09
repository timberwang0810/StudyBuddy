//
//  PlaygroundView.swift
//  StudyBuddyApp
//
//  Created by austin on 10/27/21.
//

import SwiftUI
import SpriteKit

struct PlaygroundView: View {
  @ObservedObject var viewModel: ViewModel
  @EnvironmentObject var viewRouter: ViewRouter
    
    var scene: SKScene {
        let scene = PlaygroundScene()
        scene.size = CGSize(width: 400, height: 700)
        scene.scaleMode = .fill
        return scene
    }
    
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
        SpriteView(scene: scene)
            .frame(width: 400.0, height: 700.0)
            .edgesIgnoringSafeArea(.all)
      }
      
    }
}

struct PlaygroundView_Previews: PreviewProvider {
    static var previews: some View {
      PlaygroundView(viewModel: ViewModel()).environmentObject(ViewRouter())
    }
}

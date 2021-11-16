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
        ZStack{
            VStack {
                Spacer()
                Divider()
                ScrollView(.horizontal) {
                    HStack(spacing: 10) {
                        ForEach(0..<10) { index in
                            Circle()
                               .fill(Color.yellow)
                               .frame(width: 70, height: 70)
                           Text("\(index)")
                        }
                    }.padding()
                    .padding(.top, 20)
                }.frame(height: 100)
                Divider()
                
                HStack{
                    Text("\(viewModel.getCurrentMoney())")
                        .font(Font.custom("Chalkboard SE", size: 24))
                        .baselineOffset(5)
                        .padding(.trailing, 10)
                        .onAppear(perform: {
                            self.viewModel.updateUserData()
                        })
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
}

struct PlaygroundView_Previews: PreviewProvider {
    static var previews: some View {
        PlaygroundView(viewModel: ViewModel()).environmentObject(ViewRouter())
    }
}

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
    @State var selectedIndex = 0
    
    let MENU_BG_COLOR = Color(red: 248 / 255, green: 208 / 255, blue: 116 / 255)
    
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
                    HStack(spacing: 0) {
                        ForEach(0..<10) { index in
                            PlaygroundItemView(item: index % 2 == 0 ? "hill_painting" : "yellow_lamp", isSelected: index == self.selectedIndex ? true : false)
                                .onTapGesture {
                                    print(index)
                                    self.selectedIndex = index
                                }
                        }
                    }.padding(.horizontal, 15)
                }.frame(height: 93)
                .background(MENU_BG_COLOR)
                .overlay(RoundedRectangle(cornerRadius: 6.0).stroke(Color.gray))
                .padding(.horizontal, 20)
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

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
  @State private var selectedItems: [PlaygroundItem: Bool] = [:]
  
  let MENU_BG_COLOR = Color(red: 248 / 255, green: 208 / 255, blue: 116 / 255)
  
  init(viewModel: ViewModel) {
    self.viewModel = viewModel
    
    // initialize state with currently selected items
    self.viewModel.initializePlaygroundItems()
    
    for item in viewModel.getAllPlaygroundItems() {
      self.selectedItems[item] = viewModel.isItemInUse(item: item)
    }
  }

  
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
            ForEach(viewModel.getAllPlaygroundItems(), id: \.self) { playgroundItem in
              PlaygroundItemView(viewModel: viewModel, item: playgroundItem, isInUse: selectedItems[playgroundItem] ?? false)
                .onTapGesture {
                  print(playgroundItem.name)
                  print("Before: \(viewModel.isItemInUse(item: playgroundItem))")
                  viewModel.togglePlaygroundItem(item: playgroundItem)
                  // update visual display of whether item is selected
                  selectedItems[playgroundItem] = viewModel.isItemInUse(item: playgroundItem)
                  print("After: \(viewModel.isItemInUse(item: playgroundItem))")
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

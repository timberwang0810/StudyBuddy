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
  @State private var showMenu: Bool = false
  
  let MENU_BG_COLOR = Color(red: 248 / 255, green: 208 / 255, blue: 116 / 255)
  let BOX_BG_COLOR = Color(red: 254 / 255, green: 250 / 255, blue: 224 / 255)
  
  init(viewModel: ViewModel) {
    self.viewModel = viewModel
    
    // initialize state with currently selected items
    //self.viewModel.initializePlaygroundItems()
    
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
        HStack {
          Spacer()
          Button(action: {
            self.showMenu.toggle()
          }) {
            Image(self.showMenu ? "open-box" : "closed-box")
              .resizable()
              .frame(width: 32.0, height: 32.0)
          }
          .frame(width: 60.0, height: 60.0)
          .background(BOX_BG_COLOR)
          .overlay(RoundedRectangle(cornerRadius: 100).stroke(Color.gray))
          .clipShape(Circle())
          .padding(20)
        }
        
        SpriteView(scene: scene)
          .frame(width: 400.0, height: 700.0)
          .edgesIgnoringSafeArea(.all)
      }
      
      if self.showMenu {
        ScrollView(.horizontal) {
          HStack(spacing: 0) {
            ForEach(viewModel.getAllPlaygroundItems(), id: \.self) { playgroundItem in
              PlaygroundItemView(viewModel: viewModel, item: playgroundItem, isInUse: selectedItems[playgroundItem] ?? false)
                .onTapGesture {
                  print(playgroundItem.name)

                  //                    print("Before: \(viewModel.isItemInUse(item: playgroundItem))")
                  viewModel.togglePlaygroundItem(item: playgroundItem)
                  // update visual display of whether item is selected
                  
                  for item in viewModel.getAllPlaygroundItems() {
                    self.selectedItems[item] = viewModel.isItemInUse(item: item)
                  }
                  
                  //                    print("After: \(viewModel.isItemInUse(item: playgroundItem))")
                  print(viewModel.playground.getAllDecorations())
                }
            }
          }.padding(.horizontal, 15)
        }.frame(height: 93)
        .background(MENU_BG_COLOR)
        .overlay(RoundedRectangle(cornerRadius: 6.0).stroke(Color.gray))
        .padding(.horizontal, 20)
        .offset(y: -250)
        .onAppear{
          self.viewModel.updateItemData(viewToUpdate: "playground")
          for item in viewModel.getAllPlaygroundItems() {
            self.selectedItems[item] = viewModel.isItemInUse(item: item)
          }
        }
      }
    }
    
  }
}

struct PlaygroundView_Previews: PreviewProvider {
  static var previews: some View {
    PlaygroundView(viewModel: ViewModel()).environmentObject(ViewRouter())
  }
}

//
//  PlaygroundView.swift
//  StudyBuddyApp
//
//  Created by austin on 10/27/21.
//

import SwiftUI
import SpriteKit
import SwiftySound

struct PlaygroundView: View {
  @ObservedObject var viewModel: ViewModel
  @EnvironmentObject var viewRouter: ViewRouter
  @State private var selectedItems: [PlaygroundItem: Bool] = [:]
  @State private var showMenu: Bool = false
    
    @ObservedObject var sceneStore: SceneStore
  
  let MENU_BG_COLOR = Color(red: 248 / 255, green: 208 / 255, blue: 116 / 255)
  let BOX_BG_COLOR = Color(red: 254 / 255, green: 250 / 255, blue: 224 / 255)
    
  init(viewModel: ViewModel) {
    self.viewModel = viewModel

    // Doing this to avoid 'self' used before all stored properties are initialized error
    self.sceneStore = SceneStore(scene: SKScene())
    
    self.sceneStore = SceneStore(
        scene: PlaygroundScene(size: CGSize(width: 400, height: 700), viewModel: self.viewModel)
    )
    
    self.viewModel.updateItemData(viewToUpdate: "playground")
    for item in viewModel.getAllPlaygroundItems() {
      self.selectedItems[item] = viewModel.isItemInUse(item: item)
    }
    let scene = self.sceneStore.scene as! PlaygroundScene
    scene.updatePlaygroundItems()
  }
  
  var body: some View {
    ZStack {
      VStack(spacing: 0) {
        HStack {
          Spacer()
          Button(action: {
            Sound.play(file: "cardboard", fileExtension: "wav", numberOfLoops: 0)
            self.showMenu.toggle()
            let scene = self.sceneStore.scene as! PlaygroundScene
            scene.toggleBobVisibility()
          }) {
            Image(self.showMenu ? "open-box" : "closed-box")
              .resizable()
              .frame(width: 32.0, height: 32.0)
          }
          .frame(width: 60.0, height: 60.0)
          .background(BOX_BG_COLOR)
          .overlay(RoundedRectangle(cornerRadius: 100).stroke(Color.gray))
          .clipShape(Circle())
          .padding(.top, 20)
          .padding(.horizontal, 20)
        }

        SpriteView(scene: self.sceneStore.scene)
          .frame(width: 360.0, height: 630.0)
          .edgesIgnoringSafeArea(.all)
      }
      
      if self.showMenu {
        ScrollView(.horizontal) {
          HStack(spacing: 0) {
            ForEach(viewModel.getAllPlaygroundItems(), id: \.self) { playgroundItem in
              PlaygroundItemView(viewModel: viewModel, item: playgroundItem, isInUse: selectedItems[playgroundItem] ?? false)
                .onTapGesture {
                  print(playgroundItem.name)
                  viewModel.togglePlaygroundItem(item: playgroundItem)
                  // update visual display of whether item is selected
                  
                  for item in viewModel.getAllPlaygroundItems() {
                    self.selectedItems.updateValue(viewModel.isItemInUse(item: item), forKey: item)
                  }
                    //Update spritekit scene
                  let scene = self.sceneStore.scene as! PlaygroundScene
                  scene.updatePlaygroundItems()
                  
                }
            }
          }.padding(.horizontal, 15)
        }.frame(height: 93)
        .background(MENU_BG_COLOR)
        .overlay(RoundedRectangle(cornerRadius: 6.0).stroke(Color.gray))
        .padding(.horizontal, 20)
        .offset(y: -210)
      }
    }.onAppear{
      self.viewModel.updateItemData(viewToUpdate: "playground")
      for item in viewModel.getAllPlaygroundItems() {
        self.selectedItems[item] = viewModel.isItemInUse(item: item)
      }
        
      if self.showMenu {
        let scene = self.sceneStore.scene as! PlaygroundScene
        scene.toggleBobVisibility()
      }
//      self.viewModel.deleteEntityData(entityName: "ItemEntity")
//      self.viewModel.deleteEntityData(entityName: "UserEntity")
//          self.viewModel.earnMoney(inc: 179250)
//          self.viewModel.saveUserData()
    }.onDisappear{
      if (self.showMenu){
        self.showMenu = false
        let scene = self.sceneStore.scene as! PlaygroundScene
        scene.toggleBobVisibility()
      }
    }
    
  }
}

struct PlaygroundView_Previews: PreviewProvider {
  static var previews: some View {
    PlaygroundView(viewModel: ViewModel()).environmentObject(ViewRouter())
  }
}

//
//  PlaygroundItemView.swift
//  StudyBuddyApp
//
//  Created by austin on 11/15/21.
//

import SwiftUI

struct PlaygroundItemView: View {
  @ObservedObject var viewModel: ViewModel
  var item: PlaygroundItem
  var isInUse: Bool
  let SELECTED_BG_COLOR = Color(red: 170 / 255, green: 208 / 255, blue: 161 / 255)
  
  var body: some View {
    Image(item.image)
      .resizable()
      .scaledToFit()
      .frame(width: 35.0, height: 35.0)
      .padding()
      .border(Color.gray, width: 1)
      .background(isInUse ? SELECTED_BG_COLOR : Color.white)
  }
}

struct PlaygroundItemView_Previews: PreviewProvider {
  static var previews: some View {
    PlaygroundItemView(viewModel: ViewModel(), item: PlaygroundItem(name: "Painting", price: 400, image: "hill_painting", category: PlaygroundItemCategory.Wall, position: Vector2(x: 0.25, y: 0.7)), isInUse: true).environmentObject(ViewRouter())
  }
}

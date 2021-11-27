//
//  StoreItemView.swift
//  StudyBuddyApp
//
//  Created by Megan Lin on 11/18/21.
//

import SwiftUI

struct StoreItemView: View {
  @ObservedObject var viewModel: ViewModel
  var item : PlaygroundItem
  let SELECTED_BG_COLOR = Color(red: 170 / 255, green: 208 / 255, blue: 161 / 255)
  let OUTLINE_COLOR = Color(red: 203 / 255, green: 202 / 255, blue: 183 / 255)
  
  var body: some View {
    VStack{
      HStack{
        Spacer().frame(minWidth: 10, maxWidth:80)
        Image("coin")
          .resizable()
          .scaledToFit()
          .frame(width: 20.0, height: 20.0)
        Text(String(item.price)).padding(.trailing, 5).font(Font.custom("Chalkboard SE", size: 14))
      }
      Image(item.image)
        .resizable()
        .scaledToFit()
        .frame(width: 60.0, height: 60.0)
        .padding(10)
      Text(item.name).font(Font.custom("Chalkboard SE", size: 18))
    }
    .padding(10)
    .overlay(RoundedRectangle(cornerRadius: 5).stroke(OUTLINE_COLOR, lineWidth: 1))
    .background(RoundedRectangle(cornerRadius: 5).fill(viewModel.isItemPurchased(item: item) ? SELECTED_BG_COLOR : Color.white).shadow(color: Color.gray, radius: 2, x: 0, y: 2))
  }
}

struct StoreView_Previews: PreviewProvider {
  static var previews: some View {
    StoreItemView(viewModel: ViewModel(), item:  PlaygroundItem(name: "Painting", price: 400, image: "hill_painting", category:  PlaygroundItemCategory.Wall, position: Vector2(x: 0.25, y: 0.7))).environmentObject(ViewRouter())
  }
}

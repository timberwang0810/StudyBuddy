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
    }.padding(15)
    .padding(.leading, 10)
    .padding(.trailing, 10)
    .border(Color.gray, width: 1)
    .background(viewModel.isItemPurchased(item: item) ? SELECTED_BG_COLOR : Color.white)
  }
}

struct StoreView_Previews: PreviewProvider {
  static var previews: some View {
    StoreItemView(viewModel: ViewModel(), item:  PlaygroundItem(name: "Pjainting", price: 400, image: "hill_painting", category:  PlaygroundItemCategory.Wall)).environmentObject(ViewRouter())
  }
}

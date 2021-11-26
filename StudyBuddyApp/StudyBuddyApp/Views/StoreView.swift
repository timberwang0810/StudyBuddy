//
//  StoreView.swift
//  StudyBuddyApp
//
//  Created by Megan Lin on 11/15/21.
//

import SwiftUI

struct StoreView: View {
  @ObservedObject var viewModel: ViewModel
  @EnvironmentObject var viewRouter: ViewRouter
  let data = (1...10).map { "Item \($0)" }

  let columns = [
      GridItem(.adaptive(minimum: 80))
  ]
//  ForEach(viewModel.getStorageItems(), id: \.self) { playgroundItem in
//    PlaygroundItemView(viewModel: viewModel, item: playgroundItem)
//      .onTapGesture {
//        print(playgroundItem.name)
//        print("Before: \(viewModel.isItemInUse(item: playgroundItem))")
//        viewModel.togglePlaygroundItem(item: playgroundItem)
//        print("After: \(viewModel.isItemInUse(item: playgroundItem))")
//
  var body: some View {
       ScrollView {
        VStack(spacing: 5) {
          Text("Store").font(Font.custom("Chalkboard SE", size: 30))
          HStack{
            Image("coin")
              .resizable()
              .frame(width: 14.0, height: 14.0)
            Text("\(viewModel.getCurrentMoney())")
              .font(Font.custom("Chalkboard SE", size: 24))
              .baselineOffset(5)
              .padding(.leading, 10)
              .onAppear(perform: {
                self.viewModel.updateUserData()
              })
          }
        }
        LazyVGrid(columns: Array(repeating: GridItem(), count: 2), spacing: 20) {
               ForEach(viewModel.getStoreItems(), id: \.self) { storeItem in
               StoreItemView(viewModel: viewModel,  item:  storeItem)
                      .onTapGesture {
                        print(storeItem.name)
               }
           }
       }
    }
}

struct StoreView_Previews: PreviewProvider {
    static var previews: some View {
      StoreView(viewModel: ViewModel()).environmentObject(ViewRouter())
    }
}
  

//VStack(alignment: .leading, spacing: 10) {
//   Image("\(item.image)")
//           .resizable()
//           .frame(width: 150, height: 200)
//           .padding(4)
//           .cornerRadius(10)
//
//   Text(item.name)
//   Text(item.price)

//
//var body: some View {
//         ScrollView {
//             LazyVGrid(columns: Array(repeating: GridItem(), count: 4)) {
//                 ForEach(data, id: \.self) { object in
//                     StoreItem(item: object)
//                 }
//             }
//         }
//    }
}

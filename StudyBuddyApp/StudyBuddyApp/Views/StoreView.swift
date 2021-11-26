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
  @State private var showingConfirmationAlert = false
  @State private var showingInsufficientFundsAlert = false
  @State private var selectedItem: PlaygroundItem? = nil
  @State private var selectedItemCost: Int = -1

  let data = (1...10).map { "Item \($0)" }
  let CART_ICON_SIZE: CGFloat = 23.0
  
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
    ZStack {
      Color(red: 241 / 255, green: 241 / 255, blue: 241 / 255).edgesIgnoringSafeArea([.top])
      ScrollView {
        VStack {
          VStack(spacing: 8) {
            HStack(spacing: 10) {
              Image(systemName: "cart")
                .resizable()
                .scaledToFill()
                .frame(width: CART_ICON_SIZE, height: CART_ICON_SIZE)
              Text("Store").font(Font.custom("Chalkboard SE", size: 30))
            }
            HStack{
              Image("coin")
                .resizable()
                .frame(width: 20.0, height: 20.0)
              Text("\(viewModel.getCurrentMoney())")
                .font(Font.custom("Chalkboard SE", size: 24))
                .baselineOffset(5)
                .padding(.leading, 10)
                .onAppear(perform: {
                  self.viewModel.updateUserData()
                  self.viewModel.updateItemData(viewToUpdate: "store")
                })
            }
            .padding(.horizontal, 30)
            .background( RoundedRectangle(cornerRadius: 5).fill(Color.white))
          }
          LazyVGrid(columns: Array(repeating: GridItem(), count: 2), spacing: 20) {
            ForEach(viewModel.getStoreItems(), id: \.self) { storeItem in
              StoreItemView(viewModel: viewModel,  item:  storeItem)
                .onTapGesture {
                  if (viewModel.getCurrentMoney() < storeItem.price) {
                    self.showingInsufficientFundsAlert = true
                  } else {
                    self.showingConfirmationAlert = true
                    self.selectedItem = storeItem
                    self.selectedItemCost = storeItem.price
                  }
                }
                .alert(isPresented: $showingConfirmationAlert) {
                  Alert(
                    title: Text("Would you like to purchase \(selectedItem!.name)?"),
                    message: Text("This will cost \(selectedItemCost) coins."),
                    primaryButton: .default(Text("Purchase"), action: {
                      if (self.viewModel.buyStorePlaygroundItem(item: storeItem)){
                        self.viewModel.saveUserData()
                        self.viewModel.saveItemData(itemName: storeItem.name, isPurchased: true, isEquipped: false)
                        self.viewModel.updateUserData()
                        self.viewModel.updateItemData(viewToUpdate: "store")
                      }
                    }),
                    secondaryButton: .default(Text("Cancel"), action: {
                      self.showingConfirmationAlert = false
                    })
                  )
                }
                .alert(isPresented: $showingInsufficientFundsAlert) {
                  Alert(
                    title: Text("Insufficient Funds"),
                    dismissButton: .default(Text("Okay"), action: {
                      self.showingInsufficientFundsAlert = false
                    })
                  )
                }
            }
          }
        }
        .padding(.horizontal, 30)
        .padding(.bottom, 30)
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

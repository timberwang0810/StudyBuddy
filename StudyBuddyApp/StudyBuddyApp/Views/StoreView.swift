//
//  StoreView.swift
//  StudyBuddyApp
//
//  Created by Megan Lin on 11/15/21.
//

import SwiftUI

struct StoreView: View {
  let data = (1...10).map { "Item \($0)" }

  let columns = [
      GridItem(.adaptive(minimum: 80))
  ]
  var body: some View {
    Text("hi")
//           ScrollView {
//               LazyVGrid(columns: Array(repeating: GridItem(), count: 4)) {
//                   ForEach(data, id: \.self) { item in VStack(alignment: .leading, spacing: 10) {
//                      Image("\(item.image)")
//                              .resizable()
//                              .frame(width: 150, height: 200)
//                              .padding(4)
//                              .cornerRadius(10)
//
//                      Text(item.name)
//                      Text(item.price)
//                   }
//               }
//           }
//      }
}

struct StoreView_Previews: PreviewProvider {
    static var previews: some View {
        StoreView()
      
    }
}

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

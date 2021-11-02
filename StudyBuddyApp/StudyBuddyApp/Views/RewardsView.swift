//
//  RewardsView.swift
//  StudyBuddyApp
//
//  Created by austin on 11/2/21.
//

import SwiftUI

struct RewardsView: View {
    @ObservedObject var viewModel: ViewModel
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View {
        VStack {
            Spacer()
            Text("Nicely Done!")
                .font(Font.custom("Chalkboard SE", size: 40))
                .padding(.bottom, 50)
            Button(action: { viewRouter.currentPage = .tabbedPage }) {
                Image(systemName: "gift.fill")
                    .font(Font.custom("Chalkboard SE", size: 35))
                // TODO: Calculate final rewards
//                Text("\(Task.calculateBaseRewards(duration: viewModel.currentTask!.duration))+")
                Text("+150")
                    .font(Font.custom("Chalkboard SE", size: 24))
                    .baselineOffset(5)
                    .padding(.trailing, 10)
                Image("coin")
                    .resizable()
                    .frame(width: 32.0, height: 32.0)
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 35)
            .background(Color(red: 142 / 255, green: 248 / 255, blue: 116 / 255))
            .foregroundColor(.black)
            .cornerRadius(10)
            .shadow(color: Color.gray, radius: 3, x: 0, y: 5)
        }
    }
}

struct RewardsView_Previews: PreviewProvider {
    static var previews: some View {
        RewardsView(viewModel: ViewModel()).environmentObject(ViewRouter())
    }
}

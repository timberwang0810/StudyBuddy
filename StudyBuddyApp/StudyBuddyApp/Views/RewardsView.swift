//
//  RewardsView.swift
//  StudyBuddyApp
//
//  Created by austin on 11/2/21.
//

import SwiftUI
import SpriteKit
import SwiftySound

struct RewardsView: View {
  @ObservedObject var viewModel: ViewModel
  @EnvironmentObject var viewRouter: ViewRouter
  
  var scene: SKScene {
    let scene = RewardsScene()
    scene.size = CGSize(width: 400, height: 400)
    scene.scaleMode = .fill
    return scene
  }
  
  var body: some View {
    VStack {
      Text("Completed Task:\n\(viewModel.getTaskName())")
        .font(Font.custom("Chalkboard SE", size: 24))
        .multilineTextAlignment(.center)
        .padding(.trailing, 10)
      
      Text("Nicely Done!")
        .font(Font.custom("Chalkboard SE", size: 40))
      
      SpriteView(scene: scene)
        .frame(width: 400.0, height: 400.0)
        .edgesIgnoringSafeArea(.all)
      
      Text("Timed Reward: \(viewModel.getTimedReward())")
        .font(Font.custom("Chalkboard SE", size: 24))
        .baselineOffset(5)
        .padding(.trailing, 5)
      if (viewModel.getBonusReward() > 0){
        Text("On-time Bonus: \(viewModel.getBonusReward())")
          .font(Font.custom("Chalkboard SE", size: 24))
          .baselineOffset(5)
          .padding(.trailing, 5)
      }
      
      Button(action: {
              Sound.play(file: "coin", fileExtension: "wav", numberOfLoops: 0)
              viewModel.earnMoney(inc: viewModel.getTaskReward())
              viewRouter.currentPage = .tabbedPage }) {
        Image(systemName: "gift.fill")
          .font(Font.custom("Chalkboard SE", size: 35))
        Text("\(viewModel.getTaskReward())")
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
    }.onAppear{
      Sound.play(file: "success", fileExtension: "wav", numberOfLoops: 0)
    }
  }
}

struct RewardsView_Previews: PreviewProvider {
  static var previews: some View {
    RewardsView(viewModel: ViewModel()).environmentObject(ViewRouter())
  }
}

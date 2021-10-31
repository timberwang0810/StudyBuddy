//
//  PlaygroundView.swift
//  StudyBuddyApp
//
//  Created by austin on 10/27/21.
//

import SwiftUI
import SpriteKit

struct PlaygroundView: View {
    var scene: SKScene {
        let scene = PlaygroundScene()
        scene.size = CGSize(width: 400, height: 700)
        scene.scaleMode = .fill
        return scene
    }
    
    var body: some View {
        VStack {
            SpriteView(scene: scene)
                .frame(width: 400.0, height: 700.0)
                .edgesIgnoringSafeArea(.all)
            Text("Playground View")
        }
    }
}

struct PlaygroundView_Previews: PreviewProvider {
    static var previews: some View {
        PlaygroundView()
    }
}

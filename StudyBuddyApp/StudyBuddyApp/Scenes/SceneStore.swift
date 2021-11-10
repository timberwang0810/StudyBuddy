//
//  SceneStore.swift
//  StudyBuddyApp
//
//  Created by Jonathan Fischer on 11/10/21.
//

import Foundation
import SpriteKit

class SceneStore : ObservableObject {
    var scene: SKScene
    
    init(scene: SKScene) {
        self.scene = scene
        self.scene.scaleMode = .fill
    }
}

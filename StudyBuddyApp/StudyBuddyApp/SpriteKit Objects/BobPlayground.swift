//
//  BobPlayground.swift
//  StudyBuddyApp
//
//  Created by Jonathan Fischer on 12/3/21.
//

import UIKit
import SpriteKit

enum BobState {
    case STANDING
    case WALKING_RIGHT
    case WALKING_LEFT
    case WAVING
}

class BobPlayground: SKSpriteNode {

    let atlases:[BobState: String] = [
        BobState.STANDING: "bob_standing",
        BobState.WALKING_RIGHT: "bob_walking_right",
        BobState.WALKING_LEFT: "bob_walking_left",
        BobState.WAVING: "bob_waving"
    ]
    
}

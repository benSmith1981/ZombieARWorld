//
//  SCNAnimationExtension.swift
//  HelloARWorld
//
//  Created by Ben Smith on 23/04/2018.
//  Copyright © 2018 ben. All rights reserved.
//

import Foundation
import ARKit
extension SCNAnimation {
    static func fromFile(named name: String, inDirectory: String ) -> SCNAnimation? {
        let animScene = SCNScene(named: name, inDirectory: inDirectory)
        var animation: SCNAnimation?
        animScene?.rootNode.enumerateChildNodes({ (child, stop) in
            if !child.animationKeys.isEmpty {
                let player = child.animationPlayer(forKey: child.animationKeys[0])
                animation = player?.animation
                stop.initialize(to: true)
            }
        })
        
        animation?.keyPath = name
        
        return animation
    }
}

//
//  Zombie.swift
//  HelloARWorld
//
//  Created by ben on 28/10/2017.
//  Copyright © 2017 ben. All rights reserved.
//

import Foundation
import UIKit
import SceneKit
import ARKit

class Zombie: SCNNode {
    
    //this holds all the differnet types of animations
    var animations = [String: CAAnimation]()
    //Is the animation idle or not
    var idle:Bool = true
    var transition:Bool = false
    var walking:Bool = true
    private var idleAnimation: SCNAnimation?
    private var walkingAnimation: SCNAnimation?
    private var transitionAnimation: SCNAnimation?
    private var attackAnimation: SCNAnimation?
    private var agonizingAnimation: SCNAnimation?
    private var runningAnimation: SCNAnimation?

    let contentRootNode = SCNNode()

    override init() {
        super.init()
        guard let virtualObjectScene = SCNScene(named: "ZombieIdle", inDirectory: "art.scnassets/ZombieIdle/") else {
            return
        }
        let wrapperNode = SCNNode()
        //        wrapperNode.setName(itemName: id)
        
        for child in virtualObjectScene.rootNode.childNodes {
            //            child.setName(itemName: id)
            wrapperNode.addChildNode(child)
        }
        contentRootNode.addChildNode(wrapperNode)
        self.addChildNode(contentRootNode)
        contentRootNode.scale = SCNVector3(0.01, 0.01, 0.01)
        preloadAnimations()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addToNode(rootNode: SCNNode) {
        

    }
    
    func preloadAnimations() {
        idleAnimation = SCNAnimation.fromFile(named: "ZombieIdle", inDirectory: "art.scnassets/ZombieIdle/")
        idleAnimation?.repeatCount = -1
        
        walkingAnimation = SCNAnimation.fromFile(named: "Walking-1", inDirectory: "art.scnassets/Walking/")
        walkingAnimation?.repeatCount = 1
        walkingAnimation?.blendInDuration = 0.3
        walkingAnimation?.blendOutDuration = 0.3
        
        transitionAnimation = SCNAnimation.fromFile(named: "ZombieTransition", inDirectory: "art.scnassets/ZombieTransition/")
        transitionAnimation?.repeatCount = 1
        transitionAnimation?.blendInDuration = 0.3
        transitionAnimation?.blendOutDuration = 0.3
        
        attackAnimation = SCNAnimation.fromFile(named: "ZombieAttack", inDirectory: "art.scnassets/ZombieAttack/")
        attackAnimation?.repeatCount = 1
        attackAnimation?.blendInDuration = 0.3
        attackAnimation?.blendOutDuration = 0.3
        
        agonizingAnimation = SCNAnimation.fromFile(named: "ZombieAgonizing", inDirectory: "art.scnassets/ZombieAgonizing/")
        agonizingAnimation?.repeatCount = 1
        agonizingAnimation?.blendInDuration = 0.3
        agonizingAnimation?.blendOutDuration = 0.3
        
        runningAnimation = SCNAnimation.fromFile(named: "ZombieRunning", inDirectory: "art.scnassets/ZombieRunning/")
        runningAnimation?.repeatCount = 1
        runningAnimation?.blendInDuration = 0.3
        runningAnimation?.blendOutDuration = 0.3
        
        // Start playing idle animation.
        if let anim = idleAnimation {
            contentRootNode.childNodes[0].addAnimation(anim, forKey: anim.keyPath)
        }
    }
    
    
    func playWalkingAnimation() {
        var distance: Float = 1.0
        if let walkingAnimation = walkingAnimation{
            let modelBaseNode = contentRootNode.childNodes[0]
            modelBaseNode.addAnimation(walkingAnimation, forKey: walkingAnimation.keyPath)
            
            walking = true
            SCNTransaction.begin()
            SCNTransaction.animationTimingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
            SCNTransaction.animationDuration = walkingAnimation.duration
            modelBaseNode.transform = SCNMatrix4Mult(modelBaseNode.presentation.transform, SCNMatrix4MakeTranslation(0, 0, distance))
            SCNTransaction.completionBlock = {
                self.walking = false
            }
            SCNTransaction.commit()
        }

    }

}

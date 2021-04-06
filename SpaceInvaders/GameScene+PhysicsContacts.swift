//
//  GameScene+HitTests.swift
//  SpaceInvaders
//
//  Created by Guillermo Fernandez on 29/03/2021.
//

import SpriteKit
import GameplayKit

extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        guard let nodeA = contact.bodyA.node else { return }
        guard let nodeB = contact.bodyB.node else { return }

        guard let nameA = nodeA.name, let nameB = nodeB.name else { return }
        
        let oneNodeIsEnemy = nameA.hasPrefix("Enemy") || nameB.hasPrefix("Enemy")
        let oneNodeIsShoot = nameA == "shoot" || nameB == "shoot"

        if oneNodeIsEnemy && oneNodeIsShoot {
            nodeA.removeFromParent()
            nodeB.removeFromParent()
            
            self.currentScore += 1
            self.scoreLabel.text = "SCORE: \(self.currentScore)"
        
            // TODO: Explosion
        }
    }
}


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
        let oneNodeIsBomb = nameA == "bomb" || nameB == "bomb"
        let oneNodeIsHouse = nameA == "house" || nameB == "house"

        if oneNodeIsEnemy && oneNodeIsShoot {
            nodeA.removeFromParent()
            nodeB.removeFromParent()
            
            self.currentScore += 1
            self.scoreLabel.text = "SCORE: \(self.currentScore)"
        
            // TODO: Explosion
            
            return
        }
        
        if oneNodeIsHouse && oneNodeIsBomb {
            var houseNode: SKSpriteNode
            
            if nameA == "bomb" {
                nodeA.removeFromParent()
                guard houseNode = nodeB as? SKSpriteNode else { return }
            } else {
                nodeB.removeFromParent()
                guard houseNode = nodeA as? SKSpriteNode else { return }
            }
            
            let currentHouseTexture = houseNode.texture?.description
            print(currentHouseTexture)
        }
    }
}


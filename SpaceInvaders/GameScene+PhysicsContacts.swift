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
        let oneNodeIsHouse = nameA.hasPrefix("house") || nameB.hasPrefix("house")
        let oneNodeIsPlayer = nameA == "spaceship" || nameB == "spaceship"

        if oneNodeIsEnemy && oneNodeIsShoot
        {
            if nameA.hasPrefix("Enemy")
            {
                let id = nameA.suffix(2)
                if Int(id) == self.rightEnemy
                {
                    self.CheckForNewRightEnemy()
                }
                print("Enemy with id \(id) was killed")
            }
            else
            {
                let id = nameB.suffix(2)
                print("Enemy with id \(id) was killed")
            }
            
            nodeA.removeFromParent()
            nodeB.removeFromParent()
            
            self.currentScore += 1
            self.scoreLabel.text = "SCORE: \(self.currentScore)"
            
            run(self.boomSound)
            
            return
        }
        
        if oneNodeIsHouse && oneNodeIsBomb
        {
            run(self.bombSound)
            nodeA.removeFromParent()
            nodeB.removeFromParent()
            return
        }

        if oneNodeIsShoot && oneNodeIsBomb
        {
            nodeA.removeFromParent()
            nodeB.removeFromParent()
            return
        }
        
        if oneNodeIsPlayer && oneNodeIsBomb
        {
            if nameA == "bomb"
            {
                nodeA.removeFromParent()
                return
            }
            
            nodeB.removeFromParent()
        }

        if oneNodeIsShoot
        {
            nodeA.name == "shoot" ? nodeA.removeFromParent() : nodeB.removeFromParent()
        }
    }
}


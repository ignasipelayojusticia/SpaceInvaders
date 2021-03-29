//
//  GameScene.swift
//  SpaceInvaders
//
//  Created by Guillermo Fernandez on 24/03/2021.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var spaceShip: SKSpriteNode!
    private let laserShootSound = SKAction.playSoundFileNamed("lasershoot.wav", waitForCompletion: false)
    private var spaceshipTouch: UITouch?
    var scoreLabel: SKLabelNode!
    
    var currentScore: Int = 0
    
    override func didMove(to view: SKView) {
        let spaceshipYPositon = -(self.size.height / 2) + 100
        
        self.backgroundColor = .black
        self.spaceShip = SKSpriteNode(imageNamed: "SpaceShip")
        self.spaceShip.size = CGSize(width: 75.0, height: 37.5)
        self.spaceShip.position = CGPoint(x: 0, y: spaceshipYPositon)
        self.addChild(self.spaceShip)
        
        self.addHouses(spaceshipYPositon)
        
        self.addEnemies(at: 100)
        
        self.physicsWorld.contactDelegate = self
        
        self.scoreLabel = SKLabelNode(text: "SCORE: 0")
        self.scoreLabel.position = CGPoint(x: 0, y: (self.size.height / 2) - 50)
        self.addChild(self.scoreLabel)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard self.spaceshipTouch == nil else {
            createShoot()
            run(self.laserShootSound)
            return
        }
        
        if let touch = touches.first {
            self.spaceshipTouch = touch
            let newPosition = touch.location(in: self)
            let action = SKAction.moveTo(x: newPosition.x, duration: 0.5)
            action.timingMode = .easeInEaseOut
            self.spaceShip.run(action)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            if touch == self.spaceshipTouch {
                let newPosition = touch.location(in: self)
                let action = SKAction.moveTo(x: newPosition.x, duration: 0.05)
                action.timingMode = .easeInEaseOut
                self.spaceShip.run(action)
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            if touch == self.spaceshipTouch {
                self.spaceshipTouch = nil
            }
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            if touch == self.spaceshipTouch {
                self.spaceshipTouch = nil
            }
        }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        cleanPastShoots()
    }
}

extension GameScene {
    private func cleanPastShoots() {
        for node in children {
            guard node.name == "shoot" else { return }
            
            if node.position.y > 700 {
                node.removeFromParent()
            }
        }
    }
}


//
//  GameScene+Creations.swift
//  SpaceInvaders
//
//  Created by Guillermo Fernandez on 29/03/2021.
//

import SpriteKit
import GameplayKit

extension GameScene {
    
    func createShoot() {
        let sprite = SKSpriteNode(imageNamed: "Shoot")
        sprite.position = self.spaceShip.position
        sprite.name = "shoot"
        sprite.zPosition = 1
        addChild(sprite)
        sprite.physicsBody = SKPhysicsBody(texture: sprite.texture!, size: sprite.size)
        sprite.physicsBody?.velocity = CGVector(dx: 0, dy: 500)
        sprite.physicsBody?.affectedByGravity = false
        sprite.physicsBody?.linearDamping = 0
        sprite.physicsBody?.categoryBitMask = 0x00000000
        sprite.physicsBody?.contactTestBitMask = 0x00000001
    }
    

    func addHouses(_ spaceshipYPositon: CGFloat) {
        let houseSpacing = self.size.width / 9
        var startX = -(self.size.width / 2) + (1.5 * houseSpacing)
        for _ in (0...3) {
            self.addHouse(at: CGPoint(x: startX, y: spaceshipYPositon + 150))
            startX += 2 * houseSpacing
        }
    }
    
    private func addHouse(at center: CGPoint) {
        let sprite = SKSpriteNode(imageNamed: "house_1")
        sprite.size.resize(to: 0.5)
        sprite.position = center
        self.addChild(sprite)
        sprite.physicsBody?.categoryBitMask = 0x00000010
    }
 
    private func getPosition(from matrix: [[CGSize]], at: CGPoint, center: CGPoint) -> CGPoint {
        
        if at == CGPoint.zero { return center }
        var position = center
        for x in (1...Int(at.x)) {
                position.x += matrix[x-1][0].width
        }
        
        return position
    }
        
    func addEnemies(at y: CGFloat) {
        let enemySpacing = self.size.width / 16
        let startX = -(self.size.width / 2) + 30
        var startY = (self.size.height / 2) - 100

        for n in 0...8 {
            addEnemy(1, at: CGPoint(x: startX + ( 1.5 * CGFloat(n) * enemySpacing ), y: startY))
        }
        
        startY -= self.enemiesVerticaSpacing
        for n in 0...8 {
            addEnemy(2, at: CGPoint(x: startX + ( 1.5 * CGFloat(n) * enemySpacing ), y: startY))
        }
        
        startY -= self.enemiesVerticaSpacing
        for n in 0...8 {
            addEnemy(2, at: CGPoint(x: startX + ( 1.5 * CGFloat(n) * enemySpacing ), y: startY))
        }
        
        startY -= self.enemiesVerticaSpacing
        for n in 0...8 {
            addEnemy(3, at: CGPoint(x: startX + ( 1.5 * CGFloat(n) * enemySpacing ), y: startY))
        }

        startY -= self.enemiesVerticaSpacing
        for n in 0...8 {
            addEnemy(3, at: CGPoint(x: startX + ( 1.5 * CGFloat(n) * enemySpacing ), y: startY))
        }

    }
    
    private func addEnemy(_ number: Int, at position: CGPoint) {
        let enemyAnimatedAtlas = SKTextureAtlas(named: "Enemy\(number)")
        var moveFrames: [SKTexture] = []
        
        let numImages = enemyAnimatedAtlas.textureNames.count
        for i in 1...numImages {
            let enemyTextureName = "Enemy_\(number)_\(i)"
            moveFrames.append(enemyAnimatedAtlas.textureNamed(enemyTextureName))
        }
        
        let firstFrameTexture = moveFrames[0]
        let enemy = SKSpriteNode(texture: firstFrameTexture)
        enemy.size.resize(to: 0.35)
        enemy.position = position
        enemy.physicsBody = SKPhysicsBody(texture: enemy.texture!, size: enemy.size)
        enemy.physicsBody?.categoryBitMask = 0x00000001
        enemy.physicsBody?.contactTestBitMask = 0x00000000
        enemy.name = "Enemy_\(number)"
        enemy.physicsBody?.affectedByGravity = false
        self.addChild(enemy)

        enemy.run(SKAction.repeatForever(SKAction.animate(with: moveFrames,
                                                          timePerFrame: 1,
                                                          resize: false,
                                                          restore: true)))
    }
    
    func createBomb(at position: CGPoint) {
        let sprite = SKSpriteNode(imageNamed: "Shoot")
        sprite.position = position
        sprite.name = "bomb"
        sprite.zPosition = 1
        addChild(sprite)
        sprite.physicsBody = SKPhysicsBody(texture: sprite.texture!, size: sprite.size)
        sprite.physicsBody?.affectedByGravity = true
        sprite.physicsBody?.linearDamping = 0
        sprite.physicsBody?.categoryBitMask = 0x00000000
        sprite.physicsBody?.contactTestBitMask = 0x0000010
    }

}

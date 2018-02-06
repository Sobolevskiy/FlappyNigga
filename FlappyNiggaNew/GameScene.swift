//
//  GameScene.swift
//  FlappyNiggaNew
//
//  Created by Владислав Соболев on 05.02.2018.
//  Copyright © 2018 Владислав Соболев. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var sky: EndlessWorld!
    var ground: EndlessWorld!
    var bird: SKSpriteNode!
    var houses: SpawnBlock!
    let backgroundMusic = SKAudioNode(fileNamed: "SoundtrekFlyingNigga.m4a")
    var score = 0
    
    override func didMove(to view: SKView) {
        
        sky = EndlessWorld(parent: self, sprite: self.childNode(withName: "background") as! SKSpriteNode, speed: 5)
        ground = EndlessWorld(parent: self, sprite: self.childNode(withName: "ground") as! SKSpriteNode, speed: 5)
        
        bird = self.childNode(withName: "bird") as! SKSpriteNode!
        
        houses = SpawnBlock(parent: self, sprite1: self.childNode(withName: "houseDown") as! SKSpriteNode, sprite2: self.childNode(withName: "houseUp") as! SKSpriteNode, speed: 5)
        
        physicsWorld.contactDelegate = self
        
        backgroundMusic.autoplayLooped = true
        self.addChild(backgroundMusic)
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        sky.update()
        ground.update()
        if houses.update() == true {
            score += 1
            let scoreLabel = self.childNode(withName: "score") as! SKLabelNode
            scoreLabel.text = String(score)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if bird.physicsBody?.isDynamic == true{
            self.run(SKAction.playSoundFileNamed("flyForNigga.m4a", waitForCompletion: false))
        }
        bird.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        bird.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 200))
        
        if !(bird.physicsBody?.isDynamic)! {
            for touch in touches {
                let homeButton = self.childNode(withName: "home") as! SKSpriteNode
                
                if homeButton.contains(touch.location(in: self)) {
                    if let scene = SKScene(fileNamed: "MenuScene") {
                        // Set the scale mode to scale to fit the window
                        scene.scaleMode = .aspectFill
                        
                        // Present the scene
                        self.view?.presentScene(scene, transition: .fade(withDuration: 1))
                    }
                    
                }
            }
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        if contactMask == 2 | 4 {
            gameOver()
        }
    }
    
    func gameOver() {
        bird.removeAllActions()
        bird.physicsBody?.isDynamic = false
        
        sky.stop()
        ground.stop()
        houses.stop()
        showGameOver()
    }
    
    func showGameOver() {
        let gameOverLabel = self.childNode(withName: "gameOver") as! SKLabelNode
        let homeButton = self.childNode(withName: "home") as! SKSpriteNode
        
        gameOverLabel.position.x = (self.view?.center.x)!
        homeButton.position.x = (self.view?.center.x)!
    }
    
}

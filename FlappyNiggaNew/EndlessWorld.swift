//
//  EndlessWorld.swift
//  FlappyNiggaNew
//
//  Created by Владислав Соболев on 05.02.2018.
//  Copyright © 2018 Владислав Соболев. All rights reserved.
//

import SpriteKit

class EndlessWorld {
    unowned let parent: SKScene
    
    var sprite1: SKSpriteNode
    var sprite2: SKSpriteNode
    
    var speed: CGFloat
    var viewSize: CGSize
    
    init(parent _parent: SKScene, sprite _sprite: SKSpriteNode, speed _speed: CGFloat) {
        parent = _parent
        viewSize = parent.size
        speed = _speed
        
        sprite1 = _sprite.copy() as! SKSpriteNode
        sprite1.position = CGPoint(x: 0, y: 0)
        
        sprite2 = _sprite.copy() as! SKSpriteNode
        sprite2.position = CGPoint(x: sprite1.size.width, y: 0)
        
        parent.addChild(sprite1)
        parent.addChild(sprite2)
    }
    
    func update() {
        sprite1.position.x -= speed
        sprite2.position.x -= speed
        
        if sprite1.position.x < -sprite1.size.width {
            sprite1.position.x = sprite2.position.x + sprite1.size.width
        }
        
        if sprite2.position.x < -sprite2.size.width {
            sprite2.position.x = sprite1.position.x + sprite2.size.width
        }
    }
    
    func stop() {
        speed = 0
    }
}


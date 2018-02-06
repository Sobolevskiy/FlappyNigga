//
//  SpawnBlock.swift
//  FlappyNiggaNew
//
//  Created by Владислав Соболев on 05.02.2018.
//  Copyright © 2018 Владислав Соболев. All rights reserved.
//

import SpriteKit

class SpawnBlock {
    unowned let parent: SKScene
    
    var sprite1: SKSpriteNode
    var sprite2: SKSpriteNode
    var spriteUp1: SKSpriteNode
    var spriteUp2: SKSpriteNode
    
    var speed: CGFloat
    var viewSize: CGSize
    var posY: CGFloat   //добавить функцию
    let interval: CGFloat = 300 //интервал между блоками
    let pipeGap = 470.0     //зазор между блоками
    var halfHeight: CGFloat //половина высоты спрайта(блока)
    var halfWidth: CGFloat //половина длины спрайта(блока)
    
    init(parent _parent: SKScene, sprite1 _sprite1: SKSpriteNode, sprite2 _sprite2: SKSpriteNode, speed _speed: CGFloat) {
        parent = _parent
        viewSize = parent.size
        speed = _speed
        
        sprite1 = _sprite1.copy() as! SKSpriteNode
        spriteUp1 = _sprite2.copy() as! SKSpriteNode
        sprite2 = _sprite1.copy() as! SKSpriteNode
        spriteUp2 = _sprite2.copy() as! SKSpriteNode
        
        halfHeight = sprite1.size.height/2
        halfWidth = sprite1.size.width/2
        
        let pos = UIScreen.main.bounds.width + (sprite1.size.width/2) + halfWidth   //точка спавна блоков
        let height = UInt32(viewSize.height / 2.5)
        
        /*sprite1.physicsBody = SKPhysicsBody(rectangleOf: sprite1.size, center: CGPoint(x: sprite1.size.width/2, y: sprite1.size.height/2))
         sprite1.physicsBody?.isDynamic = false
         sprite2.physicsBody = SKPhysicsBody(rectangleOf: sprite2.size, center: CGPoint(x: sprite2.size.width/2, y: sprite2.size.height/2))
         sprite2.physicsBody?.isDynamic = false
         spriteUp1.physicsBody = SKPhysicsBody(rectangleOf: spriteUp1.size, center: CGPoint(x: spriteUp1.size.width/2, y: spriteUp1.size.height/2))
         spriteUp1.physicsBody?.isDynamic = false
         spriteUp2.physicsBody = SKPhysicsBody(rectangleOf: spriteUp2.size, center: CGPoint(x: spriteUp2.size.width/2, y: spriteUp2.size.height/2))
         spriteUp2.physicsBody?.isDynamic = false*/
        
        posY = CGFloat(arc4random() % height + height) + halfHeight
        
        sprite1.position = CGPoint(x: pos, y: posY - CGFloat(pipeGap))
        spriteUp1.position = CGPoint(x: pos, y: posY)
        
        posY = CGFloat(arc4random() % height + height) + halfHeight
        
        sprite2.position = CGPoint(x: pos + interval, y: posY - CGFloat(pipeGap))
        spriteUp2.position = CGPoint(x: pos + interval, y: posY)
        
        parent.addChild(sprite1)
        parent.addChild(spriteUp1)
        parent.addChild(sprite2)
        parent.addChild(spriteUp2)
    }
    
    func update() -> Bool {
        let height = UInt32(viewSize.height / 2.5)
        var pos: CGFloat
        sprite1.position.x -= speed
        sprite2.position.x -= speed
        spriteUp1.position.x -= speed
        spriteUp2.position.x -= speed
        
        if sprite1.position.x < -sprite1.size.width {
            pos = CGFloat(arc4random() % height + height) + halfHeight
            sprite1.position = CGPoint(x: sprite2.position.x + interval, y: pos - CGFloat(pipeGap))
            spriteUp1.position = CGPoint(x: spriteUp2.position.x + interval, y: pos)
            return true
        }
        
        if sprite2.position.x < -sprite2.size.width {
            pos = CGFloat(arc4random() % height + height) + halfHeight
            sprite2.position = CGPoint(x: sprite1.position.x + interval, y: pos - CGFloat(pipeGap))
            spriteUp2.position = CGPoint(x: spriteUp1.position.x + interval, y: pos)
            return true
        }
        return false
    }
    
    func stop() {
        speed = 0
    }
    
}

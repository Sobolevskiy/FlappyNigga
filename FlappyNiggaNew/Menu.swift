//
//  Menu.swift
//  FlappyNiggaNew
//
//  Created by Владислав Соболев on 05.02.2018.
//  Copyright © 2018 Владислав Соболев. All rights reserved.
//

import SpriteKit

class MenuScene: SKScene {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let scene = SKScene(fileNamed: "GameScene") {
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
            
            // Present the scene
            self.view?.presentScene(scene, transition: .fade(withDuration: 1))
        }
        
        
    }
}

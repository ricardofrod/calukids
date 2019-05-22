//
//  GameScene.swift
//  Calu Basic
//
//  Created by Ricardo Rodrigues on 26/05/17.
//  Copyright © 2017 Ponto Curvo. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    //variaveis para configurar do sks
    var theca:SKSpriteNode=SKSpriteNode()
        
    override func didMove(to view: SKView) {
        view.showsFPS = false
        view.showsNodeCount = false
        UIApplication.shared.isIdleTimerDisabled = true

        self.scene?.scaleMode = SKSceneScaleMode.resizeFill

        view.showsPhysics=true
        
        //muda de scena apos x timeInterval -> usei 6 pois é a duracao da minha animacao na .sks
        _ = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(GameScene.changescene), userInfo: nil, repeats: true)

    }
    //animation for intro images
   
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
    }
    
    func touchDown(atPoint pos : CGPoint) {
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        

        
        
        //for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    //mudar de cena
    func changescene(){
        
        let changemenu = MenuScene(fileNamed: "MenuScene")
        
        self.scene?.view?.presentScene(changemenu!, transition: SKTransition.doorsOpenHorizontal(withDuration: 1.0))
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    
}

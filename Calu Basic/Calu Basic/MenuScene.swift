//
//  MenuScene.swift
//  Calu Basic
//
//  Created by Ricardo Rodrigues on 26/05/17.
//  Copyright © 2017 Ricardo Rodrigues. All rights reserved.
//

import SpriteKit
import GameplayKit
import AVFoundation


class MenuScene: SKScene {
    
    //variaveis para animações
    var mousesprite = SKSpriteNode()
    var mouseimages :SKTextureAtlas=SKTextureAtlas()
    var cocksprite = SKSpriteNode()
    var cockimages :SKTextureAtlas=SKTextureAtlas()
    var monkeysprite = SKSpriteNode()
    var monkeyimages: SKTextureAtlas=SKTextureAtlas()
    var forparents = SKSpriteNode()
    var images = [SKTexture]()
    var imagemouse = SKSpriteNode()
    var imagemonkey = SKSpriteNode()
    var imagecock = SKSpriteNode()
    let delayMouse = 0.0
    let delayMonkey = 3.5
    let delayCock = 9.0
    let background = SKSpriteNode(imageNamed: "background")
    let scaleimage = SKAction.scaleX(by: 1, y: CGFloat(1.5), duration: 1.5)
    var purchase = SKSpriteNode(imageNamed: "btn_purchase")
    var touchedLocation = CGPoint()
    var Ximage = CGFloat()
    var Yimage = CGFloat()
    
    let finger = UISwipeGestureRecognizer()
    //sound
    var menusound = NSURL(fileURLWithPath: Bundle.main.path(forResource: "menu", ofType: "mp3")!)
    var audioPlayer = AVAudioPlayer()
    
    
    override func didMove(to view: SKView) {
        view.showsFPS = false
        view.showsNodeCount = false
        UIApplication.shared.isIdleTimerDisabled = true
        //addd background
        background.position=CGPoint(x: size.width / 2, y: size.height / 2)
        background.size=CGSize(width: view.bounds.width, height: view.bounds.height)
        insertChild(background, at: 0)
        //self.scene?.scaleMode = SKSceneScaleMode.resizeFill
        //sound call
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: menusound as URL)
            audioPlayer.prepareToPlay()
            audioPlayer.play()
            audioPlayer.numberOfLoops = -1
        } catch {
            // Create an assertion crash in the event that the app fails to play the sound
            assert(false, error.localizedDescription)
        }
        
        purchase.position = CGPoint(x: (self.view?.scene?.size.width)! * (0.93), y: (self.view?.scene?.size.height)! * (0.9))
        purchase.size = CGSize(width: purchase.size.width, height: purchase.size.height)
        purchase.zPosition = 1
        self.addChild(purchase)
        
        
        
        //Adicionar animais na scene
        
        //mouse
        imagemouse = SKSpriteNode(imageNamed : "imagemouse")
        //imagemouse.size = CGSize(width: monkeysprite.size.width * 0.50 , height: monkeysprite.size.height * 0.50)
        imagemouse.position = CGPoint(x: background.position.x * 0.50, y: background.position.y * 0.40)
        imagemouse.zPosition=1.0
        self.addChild(imagemouse)
        
        //monkey
        imagemonkey = SKSpriteNode(imageNamed : "imagemonkey")
        imagemonkey.size = CGSize(width: imagemonkey.size.width , height: imagemonkey.size.height)
        imagemonkey.position = CGPoint(x: background.position.x * 0.50, y: background.position.y * 1.62)
        imagemonkey.zPosition=1.0
        
        self.addChild(imagemonkey)
        
        //cock
        imagecock = SKSpriteNode(imageNamed : "imagecock")
        imagecock.size = CGSize(width: imagecock.size.width , height: imagecock.size.height)
        imagecock.position = CGPoint(x: background.position.x * 1.17, y: background.position.y * 1.45)
        imagecock.zPosition=1.0
        
        self.addChild(imagecock)
        
        //parens
        //forparents = SKSpriteNode(imageNamed : "")
        forparents.size = CGSize(width: imagecock.size.width * 0.75, height: imagecock.size.height * 0.2)
        forparents.position = CGPoint(x: background.position.x * 1.77, y: background.position.y * 0.97)
        forparents.zPosition=1.0
        
        self.addChild(forparents)
        
        
        
        _ = Timer.scheduledTimer(timeInterval: 0, target: self, selector: #selector(MenuScene.timerAnimations(sender:)), userInfo: nil, repeats: false)
        _ = Timer.scheduledTimer(timeInterval: 14, target: self, selector: #selector(MenuScene.timerAnimations(sender:)), userInfo: nil, repeats: true)
    }
    func timerAnimations(sender: Timer){
        
        imagemouse.isHidden = false
        mousesprite.removeFromParent()
        
        _ = Timer.scheduledTimer(timeInterval: delayMouse, target: self, selector: #selector(MenuScene.animateImageMouse(sender:)), userInfo: mousesprite, repeats: false)
        
        //monkey
        imagemonkey.isHidden = false
        monkeysprite.removeFromParent()
        
        _ = Timer.scheduledTimer(timeInterval: delayMonkey, target: self, selector: #selector(MenuScene.animateImageMonkey(sender:)), userInfo: monkeysprite, repeats: false)
        
        //cook
        imagecock.isHidden = false
        cocksprite.removeFromParent()
        
        _ = Timer.scheduledTimer(timeInterval: delayCock, target: self, selector: #selector(MenuScene.animateImageCock(sender:)), userInfo: cocksprite, repeats: false)
    }
    
    //animation for mouse images
    func animateImageMouse(sender: Timer) {
        imagemouse.isHidden = true
        images.removeAll()
        mouseimages=SKTextureAtlas(named:"mouse")
        //percorre a pasta onde estão as imagens e ordena
        for i in 1...mouseimages.textureNames.count{
            //Int(UInt32(arc4random()) % UInt32(i))
            
            let name = "mouse\(i).png"
            images.append(SKTexture(imageNamed: name))
        }
        //animate mouse
        mousesprite = SKSpriteNode(imageNamed: mouseimages.textureNames[0])
        mousesprite.size = CGSize(width: mousesprite.size.width * 0.50 , height: mousesprite.size.height * 0.50)
        mousesprite.position = CGPoint(x: background.position.x * 0.50, y: background.position.y * 0.40)
        //mousesprite.run(SKAction.repeatForever(SKAction.animate(with: images , timePerFrame: 0.2 )))
        mousesprite.run(SKAction.wait(forDuration: 6.0))
        mousesprite.run(SKAction.animate(with: images, timePerFrame: 0.3))
        mousesprite.zPosition=1.0
        
        mousesprite.removeFromParent()
        self.addChild(mousesprite)
        
        // delay
        
        //ter um scale ao carregar/tocar na imagem
        
    }
    
    //animation for monkey images
    func animateImageMonkey(sender: Timer) {
        imagemonkey.isHidden = true
        images.removeAll()
        monkeyimages=SKTextureAtlas(named:"monkey")
        //percorre a pasta onde estão as imagens e ordena
        for i in 1...monkeyimages.textureNames.count{
            
            let name = "monkey\(i).png"
            images.append(SKTexture(imageNamed: name))
        }
        
        //animate monkey
        monkeysprite = SKSpriteNode(imageNamed: monkeyimages.textureNames[0])
        monkeysprite.size = CGSize(width: monkeysprite.size.width * 0.50 , height: monkeysprite.size.height * 0.50)
        monkeysprite.position = CGPoint(x: background.position.x * 0.50, y: background.position.y * 1.62)
        //monkeysprite.run(SKAction.repeatForever(SKAction.animate(with: images , timePerFrame: 0.2 )))
        monkeysprite.run(SKAction.wait(forDuration: 6.0))
        monkeysprite.run(SKAction.animate(with: images, timePerFrame: 0.3))
        monkeysprite.zPosition=1.0
        
        monkeysprite.removeFromParent()
        self.addChild(monkeysprite)
        
        //delay
        
    }
    //animation for cock images
    func animateImageCock(sender: Timer) {
        imagecock.isHidden = true
        images.removeAll()
        cockimages=SKTextureAtlas(named:"cock")
        //percorre a pasta onde estão as imagens e ordena
        for i in 1...cockimages.textureNames.count{
            
            let name = "cock\(i).png"
            images.append(SKTexture(imageNamed: name))
            
        }
        
        //animate cock
        cocksprite = SKSpriteNode(imageNamed: cockimages.textureNames[0])
        cocksprite.size = CGSize(width: cocksprite.size.width * 0.50 , height: cocksprite.size.height * 0.50)
        cocksprite.position = CGPoint(x: background.position.x * 1.17, y: background.position.y * 1.45)
        //cocksprite.run(SKAction.repeatForever(SKAction.animate(with: images , timePerFrame: 0.2 )))
        cocksprite.run(SKAction.wait(forDuration: 6.0))
        cocksprite.run(SKAction.animate(with: images, timePerFrame: 0.3))
        cocksprite.zPosition=1.0
        
        cocksprite.removeFromParent()
        self.addChild(cocksprite)
        
        
        
        //delay
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        finger.numberOfTouchesRequired = 2
        
        
        //faz scale quando toco
        for touch: AnyObject in touches {
            
            let location = (touch as! UITouch).location(in: self)
            let touchedNode = self.atPoint(location)
            
            
            if touchedNode == mousesprite{
                
                //mousesprite.run(SKAction.repeatForever(scaleimage))
                goToGameMouse()
                audioPlayer.stop()
                
                
            } else if (touchedNode == monkeysprite || touchedNode == imagemonkey){
                
                //monkeysprite.run(SKAction.repeatForever(scaleimage))
                goToGameMonkey()
                audioPlayer.stop()
                
                
            } else if (touchedNode == cocksprite || touchedNode == imagecock){
                
                //cocksprite.run(SKAction.repeatForever(scaleimage))
                goToGameCock()
                audioPlayer.stop()
                
            } else if(touchedNode == forparents){
                goToForParents()
                audioPlayer.stop()
                
                
            } else if(touchedNode == background){
                //print("entra")
            } else if(touchedNode == purchase){
                
                finger.direction = .down
                finger.addTarget(self, action: #selector(self.purchaseButton(sender:)))
                self.view?.addGestureRecognizer(finger)
                
                
            }
        }
    }
    
    func purchaseButton(sender: UISwipeGestureRecognizer){
        
        if(sender.direction == .down) {
            print("Swipe")
            
            // code for buy full version
            
            
        }
        
    }
    
    func goToGameMouse()
    {
        let changemenu = GameMouse(fileNamed: "GameMouse")
        self.scene?.view?.presentScene(changemenu!, transition: SKTransition.reveal(with: SKTransitionDirection.down, duration: 0.5))
        
    }
    
    func goToGameMonkey()
    {
        let changemenu = GameMonkey(fileNamed: "GameMonkey")
        
        self.scene?.view?.presentScene(changemenu!, transition: SKTransition.reveal(with: SKTransitionDirection.down, duration: 0.5))
    }
    
    func goToGameCock()
    {
        let changemenu = GameCock(fileNamed: "GameCock")
        
        self.scene?.view?.presentScene(changemenu!, transition: SKTransition.reveal(with: SKTransitionDirection.down, duration: 0.5))
    }
    func goToForParents()
    {
        let changemenu = ForParents(fileNamed: "ForParents")
        let skView = self.view!
        scene?.scaleMode = .aspectFit
        skView.presentScene(changemenu)
        //self.scene?.view?.presentScene(changemenu!, transition: SKTransition.reveal(with: SKTransitionDirection.down, duration: 1.0))
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
    }
    
    func touchDown(atPoint pos : CGPoint) {
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        //for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        /*for touch: AnyObject in touches {
         
         let location = (touch as! UITouch).location(in: self)
         let touchedNode = self.atPoint(location)
         
         if touchedNode == mousesprite {
         
         mousesprite.run(SKAction.repeatForever(scaleimage))
         
         } else if touchedNode == monkeysprite{
         
         monkeysprite.run(SKAction.repeatForever(scaleimage))
         
         } else if touchedNode == cocksprite{
         
         cocksprite.run(SKAction.repeatForever(scaleimage))
         }
         
         }*/
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        //for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    
}

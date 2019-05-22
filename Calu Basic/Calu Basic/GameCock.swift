//
//  GameCock.swift
//  Calu Basic
//
//  Created by Ricardo Rodrigues on 26/05/17.
//  Copyright © 2017 Ricardo Rodrigues. All rights reserved.
//

import SpriteKit
import GameplayKit
import CoreData
import AVFoundation


class GameCock: SKScene {
    
    //variaveis para configurar do sks
    var backsprite = SKSpriteNode(imageNamed: "backbtn")
    var purchase = SKSpriteNode(imageNamed: "btn_purchase")
    var blockHabitat = SKSpriteNode(imageNamed: "habitatBlock")
    var arrayA = [Animal]()
    var arrayH = [Habitat]()
    var gridFood = SKSpriteNode()
    var movableNode : SKNode?
    var arrayAnimalF = [SKSpriteNode]()
    var arrayHabitatF = [SKSpriteNode]()
    var imageStar = [SKTexture]()

    var imagenumber = Int(2)
    
    //var goposition = true
    var animalVar = Animal(imageName: "", textureImage: SKTexture(), foodAnimal: Food(imageNameF: "", textureImageF: SKTexture()), habitatAnimal: Habitat(imageHabitat: "", textureHabitat: SKTexture()), type: "")
    var HabitatVar = Habitat(imageHabitat: "", textureHabitat: SKTexture())
    //var para animacao
    var images = [SKTexture]()
    
    var atlasimagesWalk : SKTextureAtlas=SKTextureAtlas()
    var atlasimagesHabitat : SKTextureAtlas=SKTextureAtlas()
    var atlasimagesStars : SKTextureAtlas=SKTextureAtlas()
    var Ximage = CGFloat()
    var Yimage = CGFloat()
    var imageCenter1 = CGRect()
    var imageCenter2 = CGRect()
    var movedSprite = SKSpriteNode()
    var correct = 0
    var correctAll = 1
    var success = false
    var wrongAnswer = false
    var animationEnded = false
    var starsSprite = SKSpriteNode()
    let walk = SKSpriteNode()
    let walkAction = SKAction()
    var animation = SKSpriteNode()
    var walkOrigin = CGPoint()

    var audioPlayer = AVAudioPlayer()

    let finger = UISwipeGestureRecognizer()

    
    //Disable touch until habitat animation starts
    var lockTouch = false
    
    //After first intersect, lock other catched moves
    var matchedIntersect = false
    var blockImageStar = false

    
    var arrayAnimais = [cock, horse, monkey]
    var arrayHabitat = [chickenHouse, stable, tree]
    
    
    var touchedLocation = CGPoint()
    
    override func didMove(to view: SKView) {
        view.showsFPS = false
        view.showsNodeCount = false
        UIApplication.shared.isIdleTimerDisabled = true
        
        //var skView = self.view! as SKView
        self.size = view.frame.size
        
        //storing core data
        
        
        backgroundColor = UIColor(red: 205/255, green: 233/255, blue: 236/255, alpha: 1)
        
        
        //adicionar back button
        addgoback()
        addpurchase()
        randomImage()
        
    }
    
    
    func addgoback(){
        backsprite.position=CGPoint(x: (view?.scene?.size.width)! * (-0.42), y: (view?.scene?.size.height)! * 0.42)
        backsprite.size=CGSize(width: (view?.scene?.size.width)! * 0.09, height: (view?.scene?.size.height)! * 0.11)
        backsprite.zPosition = 1
        self.addChild(backsprite)
    }
    func addpurchase(){
        purchase.position=CGPoint(x: (view?.scene?.size.width)! * (0.42), y: (view?.scene?.size.height)! * 0.42)
        purchase.size=CGSize(width: purchase.size.width, height: purchase.size.height)
        purchase.zPosition = 1
        self.addChild(purchase)
    }
    func randomImage(){
        
        //Imagens consoante o nivel
        var texture = SKTexture()
        var nameAnimal = String()
        var excludeIndex = Array<Int>()
        //var para imagem animais
        let inc = CGFloat(1.0 / CGFloat(imagenumber))
        var psize = CGFloat()
        if(imagenumber == 2){
            psize = CGFloat(inc - 0.2)
        } else {
            psize = CGFloat(inc - 0.05)
        }
        let hsize = CGFloat(((view?.scene?.size.height)! * psize))
        var posY = CGFloat(0.5 - inc / 2)
        var tmpAnimal = Animal(imageName: "", textureImage: SKTexture(), foodAnimal: Food(imageNameF: "", textureImageF: SKTexture()), habitatAnimal: Habitat(imageHabitat: "", textureHabitat: SKTexture()), type: "")
        
        var tmpHabitat = Habitat(imageHabitat: "", textureHabitat: SKTexture())
        //criar animal sprite
        for i in 0 ... (imagenumber - 1){
            var rand = Int(arc4random_uniform(UInt32(arrayAnimais.count)))
            //Verificar se o excludeIndex já tem valores e se algum deles se repete
            var z = 0
            while(z != excludeIndex.count) {
                if(rand == excludeIndex[z]) {
                    rand = Int(arc4random_uniform(UInt32(arrayAnimais.count)))
                    z = 0
                } else {
                    z += 1
                }
            }
            
            let spriteAnimal = SKSpriteNode()
            
            tmpAnimal = arrayAnimais[rand]
            texture = tmpAnimal.getTexture() as SKTexture
            nameAnimal = tmpAnimal.getName() as String
            arrayA.insert(arrayAnimais[rand], at: i)
            arrayH.insert(arrayAnimais[rand].gethabitatAnimal(), at: i)
            
            let wsize = CGFloat((texture.size().width * hsize) / texture.size().height)
            
            spriteAnimal.texture = texture
            spriteAnimal.position = CGPoint(x: (view?.scene?.size.width)! * (-0.2), y: (view?.scene?.size.height)! * (posY))
            spriteAnimal.size = CGSize(width: wsize, height: hsize)
            //spriteanimal.physicsBody = SKPhysicsBody.init(rectangleOf: CGSize(width: spriteanimal.size.width, height: spriteanimal.size.height))
            //spriteanimal.physicsBody?.isDynamic = false
            spriteAnimal.zPosition = 4
            spriteAnimal.name = nameAnimal
            
            posY -= inc
            
            arrayAnimalF.append(spriteAnimal)
            spriteAnimal.removeFromParent()
            self.addChild(spriteAnimal)
            excludeIndex.append(rand)
        }
        
        var texture2 = SKTexture()
        var nameHabitat = String()
        let inca = CGFloat(1.0 / CGFloat(imagenumber))
        var psizea = CGFloat()
        
        if(imagenumber == 2){
            psizea = CGFloat(inca - 0.2)
        } else {
            psizea = CGFloat(inca - 0.05)
        }
        let hsizea = CGFloat(((view?.scene?.size.height)! * psizea))
        var posYa = CGFloat(0.5 - inca / 2)
        //ReInit excludeIndex var
        excludeIndex = Array<Int>()
        for _ in 0...(imagenumber - 1){
            var rand = Int(arc4random_uniform(UInt32(arrayH.count)))
            
            //Verificar se o excludeIndex já tem valores e se algum deles se repete
            var z = 0
            while(z != excludeIndex.count) {
                if(rand == excludeIndex[z]) {
                    rand = Int(arc4random_uniform(UInt32(arrayH.count)))
                    z = 0
                } else {
                    z += 1
                }
            }
            
            //tmpAnimal = arrayA[rand]
            tmpHabitat = arrayH[rand]
            
            texture2 = tmpHabitat.getTexture() as SKTexture
            nameHabitat = tmpHabitat.getName() as String
            
            let wsizea = CGFloat((texture2.size().width * hsizea) / texture2.size().height)
            
            let spritehabitat = SKSpriteNode()
            
            spritehabitat.texture = texture2
            spritehabitat.position = CGPoint(x: (view?.scene?.size.width)! * (0.2), y: (view?.scene?.size.height)! * (posYa))
            spritehabitat.size = CGSize(width: wsizea, height: hsizea)
            spritehabitat.name = nameHabitat
            spritehabitat.zPosition = 1
            
            posYa -= inca
            
            arrayHabitatF.append(spritehabitat)
            spritehabitat.removeFromParent()
            self.addChild(spritehabitat)
            excludeIndex.append(rand)
        }
    }    //animation for intro images
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if(!lockTouch) {
            for touch: AnyObject in touches {
                
                let location = (touch as! UITouch).location(in: self)
                let touchedNode = self.atPoint(location)
                walkOrigin = touchedNode.position
                
                if touchedNode == backsprite {
                    goBack()
                } else if(touchedNode == purchase){
                    
                    finger.direction = .down
                    finger.addTarget(self, action: #selector(self.purchaseButton(sender:)))
                    self.view?.addGestureRecognizer(finger)
                    
                    
                }
                
                success = false
                
                for imageAnimal in arrayAnimalF {
                    
                    if(imageAnimal.isEqual(touchedNode)) {
                        Ximage = imageAnimal.position.x
                        Yimage = imageAnimal.position.y
                        movedSprite = imageAnimal
                    }
                }
            }
        }
        
    }
    
    func purchaseButton(sender: UISwipeGestureRecognizer){
        
        if(sender.direction == .down) {
            print("Swipe")
            
            // code for buy full version
            
            
        }
        
    }

    func goBack()
    {
        let changemenu = MenuScene(fileNamed: "MenuScene")
        
        self.scene?.view?.presentScene(changemenu!, transition: SKTransition.reveal(with: SKTransitionDirection.down, duration: 0.5))
    }
    
    func touchHabitat() {
        blockImageStar = false
        for imageHabitat in arrayHabitatF {
            
            //remove stars when not having error
            starsSprite.removeFromParent()
            
            let center1 = CGRect(x: movedSprite.position.x + (movedSprite.size.width / 2), y: movedSprite.position.y + (movedSprite.size.height / 2), width: movedSprite.size.width / 3, height: movedSprite.size.height / 3)
            let center2 = CGRect(x: imageHabitat.position.x + (imageHabitat.size.width / 2), y: imageHabitat.position.y + (imageHabitat.size.height / 2), width: imageHabitat.size.width / 3, height: imageHabitat.size.height / 3)
            
            if center2.intersects(center1) && imageHabitat.name != "matched" {
                let strhabitat = imageHabitat.name
                
                let nameAnimal = movedSprite.name
                
                for tmpHabitat in arrayH {
                    
                    if(tmpHabitat.getName() == strhabitat) {
                        for tmpAnimal in arrayA{
                            if(tmpAnimal.getName() == nameAnimal){
                                if(tmpAnimal.gethabitatAnimal().getName() == tmpHabitat.getName()) {
                                    if(!matchedIntersect) {
                                        do {
                                            audioPlayer = try AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: Bundle.main.path(forResource: movedSprite.name, ofType: "wav")!) as URL)
                                            audioPlayer.prepareToPlay()
                                            audioPlayer.currentTime = 0
                                            audioPlayer.numberOfLoops = 0
                                        blockImageStar = false
                                        
                                        matchedIntersect = true
                                        let nameAtlasHabitat = nameAnimal! + "_habitat"
                                        let nameAtlasWalk = nameAnimal! + "_walk"
                                        let center = CGPoint(x: imageHabitat.position.x, y: imageHabitat.position.y)
                                        
                                        atlasimagesWalk = SKTextureAtlas(named: "\(nameAtlasWalk)")
                                        
                                        var imagesWalk = [SKTexture]()
                                        //percorre a pasta onde estão as imagens e ordena
                                        for i in 1...atlasimagesWalk.textureNames.count{
                                            let nameAtlasWalk = nameAnimal! + "_w_\(i)"
                                            
                                            let name = "\(nameAtlasWalk).png"
                                            imagesWalk.append(SKTexture(imageNamed: "\(name)"))
                                        }
                                        
                                        atlasimagesHabitat = SKTextureAtlas(named: "\(nameAtlasHabitat)")
                                        var imagesHabitat = [SKTexture]()
                                        for i in 1...atlasimagesHabitat.textureNames.count {
                                            let nameatlashabitat = nameAnimal! + "_h_\(i)"
                                            let name1 = "\(nameatlashabitat).png"
                                            
                                            imagesHabitat.append(SKTexture(imageNamed: "\(name1)"))
                                        }
                                        
                                        //animate
                                        success = true
                                        
                                        let walkDestination = center
                                        let walkAction = SKAction.move(to: walkDestination, duration: 1.5)
                                        let walkAnimation = SKAction.repeatForever(SKAction.sequence([SKAction.scaleX(to: -1, duration: 0),SKAction.animate(with: imagesWalk, timePerFrame: 0.1)]))
                                        let habitatAnimation = SKAction.sequence([SKAction.scaleX(to: -1, duration: 0),SKAction.animate(with: imagesHabitat, timePerFrame: 0.15)])
                                        
                                        animation = SKSpriteNode(imageNamed: atlasimagesWalk.textureNames[0])
                                        animation.position = walkOrigin
                                        animation.size = imageHabitat.size
                                        animationEnded = false
                                        lockTouch = true
                                        
                                        animation.zPosition=6
                                        movedSprite.isHidden = true
                                        animation.removeFromParent()
                                        
                                        self.addChild(animation)
                                        
                                        animation.run(walkAnimation)
                                        animation.run(walkAction, completion: {
                                            self.lockTouch = false
                                            self.soundDelay()

                                            self.animation.zPosition = 2
                                            self.animation.removeAllActions()
                                            imageHabitat.name = "matched"
                                            
                                            self.animation.run(habitatAnimation, completion: {
                                                self.correct += 1
                                                self.levelFinished()
                                                self.correctAll += 1
                                                self.animation.zPosition = 3
                                                
                                                
                                            })
                                            
                                        })
                                        
                                        animation.zPosition = 3
                                        movedSprite.isHidden = true
                                        animation.removeFromParent()
                                        
                                        self.addChild(animation)
                                        }catch {
                                            // Create an assertion crash in the event that the app fails to play the sound
                                            assert(false, error.localizedDescription)
                                        }

                                    }
                                    //return
                                } else {
                                    blockImageStar = true
                                    
                                    imageStar.removeAll()
                                    atlasimagesStars = SKTextureAtlas(named: "stars")
                                    
                                    for i in 1...atlasimagesStars.textureNames.count{
                                        
                                        let name = "stars\(i).png"
                                        imageStar.append(SKTexture(imageNamed: "\(name)"))
                                        
                                    }
                                    starsSprite.position = CGPoint(x: imageHabitat.position.x / 1.5, y: imageHabitat.position.y)
                                    starsSprite.size = imageHabitat.size
                                    starsSprite.run(SKAction.wait(forDuration: 6.0))
                                    starsSprite.zPosition = 7
                                    starsSprite.run(SKAction.repeat(SKAction.animate(with: imageStar, timePerFrame: 0.05), count: -1), completion: {
                                        self.starsSprite.alpha = 0.0
                                        self.isUserInteractionEnabled = false
                                    })
                                    
                                    starsSprite.removeFromParent()
                                    self.addChild(starsSprite)
                                    //blockImageStar = true
                                    success = false
                                    wrongAnswer = true
                                    return
                                    
                                }
                                
                            }
                        }
                        
                    }
                }
            }
        }
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
    private func levelFinished() {
        
        
        if(correct == imagenumber){
            
            imagenumber += 1
            if(imagenumber == 4){
                clearBoard()
            } else {
                
                arrayHabitatF.removeAll()
                arrayAnimalF.removeAll()
                arrayA.removeAll()
                arrayH.removeAll()
                self.removeAllChildren()
                addgoback()
                randomImage()
                addpurchase()
                correct = 0
                
                correctAll = 0
            }
            
            
        }
    }
    
    func clearBoard(){
        self.removeAllChildren()
        addgoback()
        addpurchase()
        blockHabitat.position=CGPoint(x: (view?.bounds.minX)!, y: (view?.bounds.minY)!)
        blockHabitat.size=CGSize(width: (view?.bounds.width)!, height: (view?.bounds.height)!)
        insertChild(blockHabitat, at: 0)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if(!blockImageStar){
            
            for touch: AnyObject in touches {
                touchedLocation = touch.location(in: self)
                
                movedSprite.position.x = touchedLocation.x
                movedSprite.position.y = touchedLocation.y
            }
        }
        
        touchHabitat()
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (success == false){
            movedSprite.position = CGPoint(x: Ximage, y: Yimage)
            starsSprite.removeFromParent()
            if(wrongAnswer) {
                wrongAnswer = false
            }
        } else {
            matchedIntersect = false
        }
        
        movedSprite = SKSpriteNode()
    }
    
    func soundDelay(){
        audioPlayer.prepareToPlay()
        audioPlayer.play()
    }
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    
}



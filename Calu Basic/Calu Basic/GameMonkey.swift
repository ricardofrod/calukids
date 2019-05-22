//
//  GameMonkey.swift
//  Calu Basic
//
//  Created by Ricardo Rodrigues on 26/05/17.
//  Copyright © 2017 Ricardo Rodrigues. All rights reserved.
//

import SpriteKit
import GameplayKit
import AVFoundation


class GameMonkey: SKScene {
    
    //variaveis para configurar do sks
    
    var backsprite = SKSpriteNode(imageNamed: "backbtn")
    var purchase = SKSpriteNode(imageNamed: "btn_purchase")
    var btn_domestic = SKSpriteNode(imageNamed: "btn_domestic_active")
    var btn_wild = SKSpriteNode(imageNamed : "btn_wild")
    var btn_domestic_photo = SKSpriteNode(imageNamed: "btn_domestic_photo")
    var btn_wild_photo = SKSpriteNode(imageNamed : "btn_wild_photo")
    var btn_sound = SKSpriteNode(imageNamed : "btn_sound")
    var imagenumber = Int(10)
    var arrayD = [Animal]()
    var arrayW = [Animal]()
    var arraySound = [Animal]()
    var arrayDF = [SKSpriteNode]()
    var arrayWF = [SKSpriteNode]()
    var arraySoundF = [SKSpriteNode]()
    var fullimage = SKSpriteNode()
    var images = [SKTexture]()
    var atlasImages : SKTextureAtlas=SKTextureAtlas()
    var animation = SKSpriteNode()
    let spriteAnimal = SKSpriteNode()
    let blockdomestic = SKSpriteNode(imageNamed: "blockMonkey")
    var blockWild = SKSpriteNode(imageNamed: "blockWild")
    var soundAnimation = SKAction()
    var touchedNode = SKNode()
    var Ximage = CGFloat()
    var Yimage = CGFloat()
    let colorSprite = SKSpriteNode()
    var timer:Timer? = nil {
        willSet {
            timer?.invalidate()
        }
    }
    let finger = UISwipeGestureRecognizer()
    
    var showRealImage = false
    var touchSoundStart = false
    var animationSoundStart = false
    
    //Animal name on Sound Played to get verify
    var animalSoundPlayed = ""
    //Variable to begin game
    var numberShowAnimals = 2
    
    //sound
    //var menusound = NSURL(fileURLWithPath: Bundle.main.path(forResource: "menu", ofType: "mp3")!)
    var audioPlayer = AVAudioPlayer()
    var audioPlayer2 = AVAudioPlayer()
    
    
    var tmpAnimal = Animal(imageName: "", textureImage: SKTexture(), foodAnimal: Food(imageNameF: "", textureImageF: SKTexture()), habitatAnimal: Habitat(imageHabitat: "", textureHabitat: SKTexture()), type: "")
    var animalArray = [horse, cock, monkey]
    
    override func didMove(to view: SKView) {
        view.showsFPS = false
        view.showsNodeCount = false
        UIApplication.shared.isIdleTimerDisabled = true
        
        
        //self.size = view.frame.size
        backgroundColor = UIColor(red: 205/255, green: 233/255, blue: 236/255, alpha: 1)
        
        addgoback()
        addpurchase()
        MakeMenu()
        btn_domestic.name = "btn_domestic_active"
        addImagesDomestic()
        addblockDomestic()
    }
    func addblockDomestic(){
        blockdomestic.position=CGPoint(x: (view?.bounds.minX)!, y: (view?.bounds.minY)!)
        blockdomestic.size=CGSize(width: (view?.bounds.width)!, height: (view?.bounds.height)!)
        insertChild(blockdomestic, at: 0)
    }
    func addblockWild(){
        blockWild.position=CGPoint(x: (view?.bounds.minX)!, y: (view?.bounds.minY)!)
        blockWild.size=CGSize(width: (view?.bounds.width)!, height: (view?.bounds.height)!)
        insertChild(blockWild, at: 0)
    }
    
    //animation for intro images
    func addgoback(){
        backsprite.position=CGPoint(x: (self.view?.scene?.size.width)! * (-0.45), y: (self.view?.scene?.size.height)! * 0.43)
        backsprite.size=CGSize(width: (view?.scene?.size.width)! * 0.08, height: (view?.scene?.size.height)! * 0.1)
        backsprite.zPosition = 1
        insertChild(backsprite, at: 0)
    }
    func addpurchase(){
        purchase.position=CGPoint(x: (self.view?.scene?.size.width)! * (0.42), y: (self.view?.scene?.size.height)! * 0.42)
        purchase.size=CGSize(width: purchase.size.width, height: purchase.size.height)
        purchase.zPosition = 1
        self.addChild(purchase)
    }
    func addImagesDomestic(){
        arrayD.removeAll()
        var texture = SKTexture()
        var nameAnimal = String()
        var excludeIndex = Array<Int>()
        
        //var para imagem animais
        let posInitX = CGFloat(-230)
        let posInitY = CGFloat(250)
        var posX = posInitX
        let posY = posInitY
        var count = 0
        //criar animal sprite
        for i in 0 ... (animalArray.count-1){
            
            tmpAnimal = animalArray[i]
            
            if(tmpAnimal.getType() == "domestic"){
                arrayD.append(tmpAnimal)
            }
        }
        
        for _ in 0 ... (arrayD.count-1){
            
            var rand = Int(arc4random_uniform(UInt32(arrayD.count)))
            //Verificar se o excludeIndex já tem valores e se algum deles se repete
            var z = 0
            while(z != excludeIndex.count) {
                if(rand == excludeIndex[z]) {
                    rand = Int(arc4random_uniform(UInt32(arrayD.count)))
                    z = 0
                } else {
                    z += 1
                }
            }
            
            let spriteAnimal = SKSpriteNode()
            
            tmpAnimal = arrayD[rand]
            texture = tmpAnimal.getTexture() as SKTexture
            nameAnimal = tmpAnimal.getName() as String
            //typeAnimal = tmpAnimal.getType() as String
            
            //let wsize = CGFloat((texture.size().width * hsize) / texture.size().height)
            
            
            spriteAnimal.texture = texture
            spriteAnimal.position = CGPoint(x: posX, y: posY)
            spriteAnimal.size = CGSize(width:(self.view?.scene?.size.width)! * 0.2, height: (self.view?.scene?.size.height)! * 0.2)
            //spriteanimal.physicsBody = SKPhysicsBody.init(rectangleOf: CGSize(width: spriteanimal.size.width, height: spriteanimal.size.height))
            //spriteanimal.physicsBody?.isDynamic = false
            spriteAnimal.zPosition = 1
            spriteAnimal.name = nameAnimal
            
            //posX -= inc
            arrayDF.append(spriteAnimal)
            spriteAnimal.removeFromParent()
            self.addChild(spriteAnimal)
            excludeIndex.append(rand)
            
            
            posX += 230
            count += 1
            
        }
        
        
    }
    
    func addImageWild(){
        arrayW.removeAll()
        var texture = SKTexture()
        var nameAnimal = String()
        var excludeIndex = Array<Int>()
        
        //var para imagem animais
        let posInitX = CGFloat(-230)
        let posInitY = CGFloat(250)
        var posX = posInitX
        let posY = posInitY
        var count = 0
        //criar animal sprite
        for i in 0 ... (animalArray.count-1){
            
            tmpAnimal = animalArray[i]
            
            if(tmpAnimal.getType() == "wild"){
                arrayW.append(tmpAnimal)
            }
        }
        
        for _ in 0 ... (arrayW.count-1){
            
            var rand = Int(arc4random_uniform(UInt32(arrayW.count)))
            //Verificar se o excludeIndex já tem valores e se algum deles se repete
            var z = 0
            while(z != excludeIndex.count) {
                if(rand == excludeIndex[z]) {
                    rand = Int(arc4random_uniform(UInt32(arrayW.count)))
                    z = 0
                } else {
                    z += 1
                }
            }
            
            
            tmpAnimal = arrayW[rand]
            texture = tmpAnimal.getTexture() as SKTexture
            nameAnimal = tmpAnimal.getName() as String
            //typeAnimal = tmpAnimal.getType() as String
            
            //let wsize = CGFloat((texture.size().width * hsize) / texture.size().height)
            
            
            spriteAnimal.texture = texture
            spriteAnimal.position = CGPoint(x: posX, y: posY)
            spriteAnimal.size = CGSize(width:(view?.scene?.size.width)! * 0.2, height: (view?.scene?.size.height)! * 0.2)
            //spriteanimal.physicsBody = SKPhysicsBody.init(rectangleOf: CGSize(width: spriteanimal.size.width, height: spriteanimal.size.height))
            //spriteanimal.physicsBody?.isDynamic = false
            spriteAnimal.zPosition = 1
            spriteAnimal.name = nameAnimal
            
            //posX -= inc
            arrayWF.append(spriteAnimal)
            
            spriteAnimal.removeFromParent()
            self.addChild(spriteAnimal)
            excludeIndex.append(rand)
            
            posX += 230
            count += 1
            
            
        }
        
        
    }
    
    func addImagesSound(){
        arraySound.removeAll()
        var texture = SKTexture()
        var nameAnimal = String()
        var excludeIndex = Array<Int>()
        var randShowAnimalsIndex = Array<Int>()
        
        //var para imagem animais
        let posInitX = CGFloat(-230)
        let posInitY = CGFloat(250)
        let posX = posInitX
        let posY = posInitY
        let arrayPos = [[posX, posY], [posX + 230, posY], [posX + (230*2), posY], [posX - 150, posY - 200], [posX + 90, posY - 200], [posX + 360, posY - 200], [posX + (300*2), posY - 200], [posX, posY - (200*2)], [posX + 230, posY - (200*2)], [posX + (230*2), posY - (200*2)]]
        var excludePositionIndex = Array<Int>()
        
        //get 10 random animals from all animals list
        for _ in 0 ... 2 {
            
            var rand = Int(arc4random_uniform(UInt32(animalArray.count)))
            //Verificar se o excludeIndex já tem valores e se algum deles se repete
            var z = 0
            while(z != excludeIndex.count) {
                if(rand == excludeIndex[z]) {
                    rand = Int(arc4random_uniform(UInt32(animalArray.count)))
                    z = 0
                } else {
                    z += 1
                }
            }
            
            excludeIndex.append(rand)
            arraySound.append(animalArray[rand])
        }
        
        //Random a number of animals to show
        for _ in 0 ... (numberShowAnimals - 1) {
            
            var rand = Int(arc4random_uniform(UInt32(arraySound.count)))
            //Verificar se o excludeIndex já tem valores e se algum deles se repete
            var z = 0
            while(z != randShowAnimalsIndex.count) {
                if(rand == randShowAnimalsIndex[z]) {
                    rand = Int(arc4random_uniform(UInt32(arraySound.count)))
                    z = 0
                } else {
                    z += 1
                }
            }
            
            randShowAnimalsIndex.append(rand)
            
            //Rand Position
            var randPosition = Int(arc4random_uniform(UInt32(arrayPos.count)))
            //Verificar se o excludeIndex já tem valores e se algum deles se repete
            var y = 0
            while(y != excludePositionIndex.count) {
                if(randPosition == excludePositionIndex[y]) {
                    randPosition = Int(arc4random_uniform(UInt32(arrayPos.count)))
                    y = 0
                } else {
                    y += 1
                }
            }
            
            excludePositionIndex.append(randPosition)
            
            let spriteAnimal = SKSpriteNode()
            
            tmpAnimal = arraySound[rand]
            texture = tmpAnimal.getTexture() as SKTexture
            nameAnimal = tmpAnimal.getName() as String
            
            spriteAnimal.texture = texture
            spriteAnimal.position = CGPoint(x: arrayPos[randPosition][0], y: arrayPos[randPosition][1])
            spriteAnimal.size = CGSize(width:(view?.scene?.size.width)! * 0.2, height: (view?.scene?.size.height)! * 0.2)
            spriteAnimal.zPosition = 1
            spriteAnimal.name = nameAnimal
            
            arraySoundF.append(spriteAnimal)
            spriteAnimal.removeFromParent()
            self.addChild(spriteAnimal)
            
            //Call function to reproduce the animal sound
            playSound(randAnimalsIndex: randShowAnimalsIndex)
            
        }
        
    }
    
    
    private func playSound(randAnimalsIndex: Array<Int>) {
        let rand = Int(arc4random_uniform(UInt32(randAnimalsIndex.count)))
        let animalSound = arraySound[randAnimalsIndex[rand]]
        let animalName = animalSound.getName()
        animalSoundPlayed = animalName
        
        //Delay 1sec before playing the sound
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1) ) {
            do {
                self.audioPlayer2 = try AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: Bundle.main.path(forResource: animalName, ofType: "wav")!) as URL)
                self.audioPlayer2.play()
                self.audioPlayer2.numberOfLoops = 0
            } catch {
                // Create an assertion crash in the event that the app fails to play the sound
                assert(false, error.localizedDescription)
            }
        }
        startTimer()
        
    }
    
    func MakeMenu(){
        
        //Domestic btn
        //btn_domestic = SKSpriteNode(imageNamed : "btn_domestic")
        btn_domestic.size = CGSize(width: btn_domestic.size.width , height: btn_domestic.size.height)
        btn_domestic.position = CGPoint(x: (view?.scene?.size.width)! * (-0.404), y: (view?.scene?.size.height)! * (-0.44))
        btn_domestic.zPosition=1.0
        self.addChild(btn_domestic)
        
        //wild btn
        //btn_wild = SKSpriteNode(imageNamed : "btn_wild")
        btn_wild.size = CGSize(width: btn_domestic.size.width , height: btn_domestic.size.height)
        btn_wild.position = CGPoint(x: (view?.scene?.size.width)! * (-0.202), y: (view?.scene?.size.height)! * (-0.44))
        btn_wild.zPosition=1.0
        self.addChild(btn_wild)
        
        //Domestic photo btn
        //btn_domestic_photo = SKSpriteNode(imageNamed : "btn_domestic_photo")
        btn_domestic_photo.size = CGSize(width: btn_domestic.size.width , height: btn_domestic.size.height)
        btn_domestic_photo.position = CGPoint(x: (view?.scene?.size.width)! * (0), y: (view?.scene?.size.height)! * (-0.44))
        btn_domestic_photo.zPosition=1.0
        self.addChild(btn_domestic_photo)
        
        //wild photo btn
        //btn_wild_photo = SKSpriteNode(imageNamed : "btn_wild_photo")
        btn_wild_photo.size = CGSize(width: btn_domestic.size.width , height: btn_domestic.size.height)
        btn_wild_photo.position = CGPoint(x: (view?.scene?.size.width)! * (0.202), y: (view?.scene?.size.height)! * (-0.44))
        btn_wild_photo.zPosition=1.0
        self.addChild(btn_wild_photo)
        
        //sound btn
        //btn_sound = SKSpriteNode(imageNamed : "btn_sound")
        btn_sound.size = CGSize(width: btn_domestic.size.width , height: btn_domestic.size.height)
        btn_sound.position = CGPoint(x: (view?.scene?.size.width)! * (0.404), y: (view?.scene?.size.height)! * (-0.44))
        btn_sound.zPosition=1.0
        self.addChild(btn_sound)
        
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
    
    func purchaseButton(sender: UISwipeGestureRecognizer){
        
        if(sender.direction == .down) {
            print("Swipe")
            
            // code for buy full version
            
            
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch: AnyObject in touches {
            let location = (touch as! UITouch).location(in: self)
            touchedNode = self.atPoint(location)
            
            if(touchSoundStart) {
                stopTimer()
                removeAction()
            }
            
            if touchedNode == backsprite {
                stopTimer()
                goBack()
                
            }
            
            if touchedNode == btn_wild{
                stopTimer()
                self.removeAllChildren()
                btn_domestic = SKSpriteNode(imageNamed: "btn_domestic")
                btn_wild = SKSpriteNode(imageNamed: "btn_wild_active")
                btn_domestic_photo = SKSpriteNode(imageNamed: "btn_domestic_photo")
                btn_wild_photo = SKSpriteNode(imageNamed: "btn_wild_photo")
                btn_sound = SKSpriteNode(imageNamed: "btn_sound")
                btn_wild.name = "btn_wild_active"
                MakeMenu()
                addblockWild()
                //btn_wild_photo = SKSpriteNode
                addImageWild()
                addgoback()
                addpurchase()
                
            }
            if touchedNode == btn_domestic{
                stopTimer()
                self.removeAllChildren()
                btn_domestic = SKSpriteNode(imageNamed: "btn_domestic_active")
                btn_wild = SKSpriteNode(imageNamed: "btn_wild")
                btn_domestic_photo = SKSpriteNode(imageNamed: "btn_domestic_photo")
                btn_wild_photo = SKSpriteNode(imageNamed: "btn_wild_photo")
                btn_sound = SKSpriteNode(imageNamed: "btn_sound")
                btn_domestic.name = "btn_domestic_active"
                MakeMenu()
                addblockDomestic()
                addImagesDomestic()
                addgoback()
                addpurchase()
            }
            if touchedNode == btn_domestic_photo{

                stopTimer()
                self.removeAllChildren()
                btn_domestic = SKSpriteNode(imageNamed: "btn_domestic")
                btn_wild = SKSpriteNode(imageNamed: "btn_wild")
                btn_domestic_photo = SKSpriteNode(imageNamed: "btn_domestic_photo_active")
                btn_wild_photo = SKSpriteNode(imageNamed: "btn_wild_photo")
                btn_sound = SKSpriteNode(imageNamed: "btn_sound")
                btn_domestic_photo.name = "btn_domestic_photo_active"
                MakeMenu()
                addblockDomestic()
                addImagesDomestic()
                addgoback()
                addpurchase()
            }
            if touchedNode == btn_wild_photo{

                stopTimer()
                self.removeAllChildren()
                btn_domestic = SKSpriteNode(imageNamed: "btn_domestic")
                btn_wild = SKSpriteNode(imageNamed: "btn_wild")
                btn_domestic_photo = SKSpriteNode(imageNamed: "btn_domestic_photo")
                btn_wild_photo = SKSpriteNode(imageNamed: "btn_wild_photo_active")
                btn_sound = SKSpriteNode(imageNamed: "btn_sound")
                btn_wild_photo.name = "btn_wild_photo_active"
                MakeMenu()
                addblockWild()
                //btn_wild_photo = SKSpriteNode
                addImageWild()
                addgoback()
                addpurchase()
            }
            if touchedNode == btn_sound{
                self.removeAllChildren()
                btn_domestic = SKSpriteNode(imageNamed: "btn_domestic")
                btn_wild = SKSpriteNode(imageNamed: "btn_wild")
                btn_domestic_photo = SKSpriteNode(imageNamed: "btn_domestic_photo")
                btn_wild_photo = SKSpriteNode(imageNamed: "btn_wild_photo")
                btn_sound = SKSpriteNode(imageNamed: "btn_sound_active")
                btn_sound.name = "btn_sound_active"
                MakeMenu()
                
                //btn_wild_photo = SKSpriteNode
                numberShowAnimals = 2
                addImagesSound()
                addgoback()
                addpurchase()
            } else if(touchedNode == purchase){
                
                finger.direction = .down
                finger.addTarget(self, action: #selector(self.purchaseButton(sender:)))
                self.view?.addGestureRecognizer(finger)
                
                
            }
            
            
        }
        
        //for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    func goBack() {
        let changemenu = MenuScene(fileNamed: "MenuScene")
        
        self.scene?.view?.presentScene(changemenu!, transition: SKTransition.reveal(with: SKTransitionDirection.down, duration: 0.5))
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            
            let location = (touch as! UITouch).location(in: self)
            touchedNode = self.atPoint(location)
            if touchedNode is SKSpriteNode {
                
                let isAnimal = isAnimalTouched(node: touchedNode)
                
                if((btn_domestic.name == "btn_domestic_active" || btn_wild.name == "btn_wild_active") && isAnimal){
                    stopTimer()
                    
                    if(!touchSoundStart){
                        
                        do {
                            audioPlayer = try AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: Bundle.main.path(forResource: touchedNode.name, ofType: "wav")!) as URL)
                            audioPlayer.prepareToPlay()
                            audioPlayer.numberOfLoops = 10
                            let atlasAnimal = touchedNode.name! + "_sing"
                            
                            atlasImages = SKTextureAtlas(named: "\(atlasAnimal)")
                            var imagesSing = [SKTexture]()
                            //percorre a pasta onde estão as imagens e ordena
                            for i in 1...atlasImages.textureNames.count {
                                let nameAtlas = touchedNode.name! + "_s_\(i)"
                                
                                let name = "\(nameAtlas).png"
                                imagesSing.append(SKTexture(imageNamed: "\(name)"))
                            }
                            
                            
                            //animate
                            animation = SKSpriteNode(imageNamed: atlasImages.textureNames[0])
                            animation.size = CGSize(width:(view?.scene?.size.width)! * 0.2, height: (view?.scene?.size.height)! * 0.2)
                            animation.position = touchedNode.position
                            
                            colorSprite.color = UIColor(red: 205/255, green: 233/255, blue: 236/255, alpha: 1)
                            colorSprite.size = animation.size
                            colorSprite.position = animation.position
                            colorSprite.zPosition = 2.0
                            
                            //Delay 1sec before playing the sound
                            DispatchQueue.main.asyncAfter(deadline: .now() ) {
                                self.touchSoundStart = true
                                self.addChild(self.colorSprite)
                                self.audioPlayer.play()
                                self.animation.run(SKAction.sequence([SKAction.scaleX(to: -1, duration: 0),SKAction.animate(with: imagesSing, timePerFrame: 0.15)]), completion: {
                                    //after complete animation
                                    //self.touchedNode.isHidden = false
                                    self.removeAction()
                                })
                            }
                            
                            animation.zPosition=3.0
                            
                            animation.removeFromParent()
                            self.addChild(animation)
                            
                        } catch {
                            // Create an assertion crash in the event that the app fails to play the sound
                            assert(false, error.localizedDescription)
                        }
                    }
                    
                }
                if (btn_wild_photo.name == "btn_wild_photo_active" || btn_domestic_photo.name == "btn_domestic_photo_active" && isAnimal){
                    stopTimer()
                    
                    let name = touchedNode.name! + "_photo"
                    if(name as String != "btn_domestic_photo_active_photo" && name as String != "btn_wild_photo_active_photo"){
                        if(!showRealImage) {
                            do {
                                audioPlayer = try AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: Bundle.main.path(forResource: touchedNode.name, ofType: "wav")!) as URL)
                                audioPlayer.prepareToPlay()
                                audioPlayer.numberOfLoops = 0
                                fullimage = SKSpriteNode(imageNamed: name)
                                fullimage.size = CGSize(width: (view?.bounds.width)!, height: (view?.bounds.height)!)
                                fullimage.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
                                
                                fullimage.zPosition = 2
                                fullimage.name = name
                                
                                let add = SKAction.run({() in self.addRealImage()
                                    self.audioPlayer.play()
                                })
                                let wait = SKAction.wait(forDuration: 3)
                                let remove = SKAction.run({() in self.removeImage()})
                                
                                self.run(SKAction.sequence([add, wait, remove]))
                                
                            }catch {
                                // Create an assertion crash in the event that the app fails to play the sound
                                assert(false, error.localizedDescription)
                            }
                        } else {
                            self.removeImage()
                        }
                    }
                }

                
                //Sound touch to verify
                if(btn_sound.name == "btn_sound_active" && isAnimal) {
                    if(touchedNode.name == animalSoundPlayed) {
                        print("Correct")
                        //Stop sound to avoid mismatching on the next level
                        audioPlayer2.stop()
                        
                        //Update Correct Answers
                        
                        if(numberShowAnimals < 3) {
                            numberShowAnimals = numberShowAnimals + 1
                        }
                        self.removeAllChildren()
                        addgoback()
                        MakeMenu()
                        addImagesSound()
                        addpurchase()
                    } else {
                        audioPlayer2.play()
                        print("Not Correct")
                    }
                    
                    
                }
                
                /*if(!touchSoundStart && !animationSoundStart) {
                 print("entra")
                 removeAction()
                 touchedNode.isHidden = false
                 }
                 /*if(!animationSound && self.animation.hasActions()){
                 print("entra")
                 self.animation.removeAllActions()
                 }*/*/
                
            }
        }
    }
    func startTimer () {
        
        timer =  Timer.scheduledTimer(timeInterval: TimeInterval(5.0), target: self, selector: #selector(GameMonkey.repeatSound), userInfo: nil, repeats: true)
        
        
    }
    func stopTimer() {
        
        timer = nil
        
    }
    func repeatSound(){
        audioPlayer2.play()
    }
    func addRealImage() {
        self.addChild(fullimage)
        showRealImage = true
    }
    
    func removeImage() {
        self.audioPlayer.stop()
        fullimage.removeFromParent()
        showRealImage = false
    }
    func removeAction() {
        touchedNode.isHidden = false
        self.colorSprite.removeFromParent()
        self.animation.removeFromParent()
        
        self.audioPlayer.stop()
        touchSoundStart = false
        
    }

    
    //Verify if the sprite touched is an animal or a button from the menu
    private func isAnimalTouched(node: SKNode) -> Bool {
        if(node != btn_wild && node != btn_domestic && node != btn_domestic_photo && node != btn_wild_photo && node != btn_sound && node != blockdomestic && node != blockWild) {
            
            return true
        } else {
            return false
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    
    
}


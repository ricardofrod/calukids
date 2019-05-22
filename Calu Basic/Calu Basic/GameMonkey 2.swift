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
    var atlasimages : SKTextureAtlas=SKTextureAtlas()
    var animation = SKSpriteNode()
    let spriteAnimal = SKSpriteNode()
    let blockdomestic = SKSpriteNode(imageNamed: "blockMonkey")
    let blockwild = SKSpriteNode(imageNamed: "blockWild")
    
    
    
    
    //Animal name on Sound Played to get verify
    var animalSoundPlayed = ""
    //Variable to begin game
    var numberShowAnimals = 2
    
    //sound
    //var menusound = NSURL(fileURLWithPath: Bundle.main.path(forResource: "menu", ofType: "mp3")!)
    var audioPlayer = AVAudioPlayer()
    
    
    var tmpAnimal = Animal(imageName: "", textureImage: SKTexture(), foodAnimal: Food(imageNameF: "", textureImageF: SKTexture()), habitatAnimal: Habitat(imageHabitat: "", textureHabitat: SKTexture()), type: "")
    var animalArray = [horse, cock, monkey]
    
    override func didMove(to view: SKView) {
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
        blockwild.position=CGPoint(x: (view?.bounds.minX)!, y: (view?.bounds.minY)!)
        blockwild.size=CGSize(width: (view?.bounds.width)!, height: (view?.bounds.height)!)
        insertChild(blockwild, at: 0)
    }
    
   
    //animation for intro images
    func addgoback(){
        backsprite.position=CGPoint(x: (self.view?.scene?.size.width)! * (-0.45), y: (self.view?.scene?.size.height)! * 0.43)
        backsprite.size=CGSize(width: (view?.scene?.size.width)! * 0.08, height: (view?.scene?.size.height)! * 0.1)
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
        var typeAnimal = String()
        var excludeIndex = Array<Int>()
        
        //var para imagem animais
        let posInitX = CGFloat(-230)
        let posInitY = CGFloat(250)
        var posX = posInitX
        var posY = posInitY
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
            typeAnimal = tmpAnimal.getType() as String
            
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
        var typeAnimal = String()
        var excludeIndex = Array<Int>()
        
        //var para imagem animais
        let posInitX = CGFloat(-230)
        let posInitY = CGFloat(250)
        var posX = posInitX
        var posY = posInitY
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
            typeAnimal = tmpAnimal.getType() as String
            
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
        let arrayPos = [[posX, posY], [posX + 230, posY]]
        var excludePositionIndex = Array<Int>()
        
        //get 10 random animals from all animals list
        for _ in 0 ... 9 {
            
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
                self.audioPlayer = try AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: Bundle.main.path(forResource: animalName, ofType: "wav")!) as URL)
                self.audioPlayer.play()
                self.audioPlayer.numberOfLoops = 0
            } catch {
                // Create an assertion crash in the event that the app fails to play the sound
                assert(false, error.localizedDescription)
            }
        }
        
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
    func goBack()
    {
        let changemenu = MenuScene(fileNamed: "MenuScene")
        
        self.scene?.view?.presentScene(changemenu!, transition: SKTransition.reveal(with: SKTransitionDirection.down, duration: 0.5))
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch: AnyObject in touches {
            let location = (touch as! UITouch).location(in: self)
            let touchedNode = self.atPoint(location)

            if touchedNode == backsprite {
                goBack()
            }
            if touchedNode == btn_wild{
                self.removeAllChildren()
                btn_domestic = SKSpriteNode(imageNamed: "btn_domestic")
                btn_wild = SKSpriteNode(imageNamed: "btn_wild_active")
                btn_domestic_photo = SKSpriteNode(imageNamed: "btn_domestic_photo")
                btn_wild_photo = SKSpriteNode(imageNamed: "btn_wild_photo")
                btn_sound = SKSpriteNode(imageNamed: "btn_sound")
                btn_wild.name = "btn_wild_active"
                MakeMenu()
                
                //btn_wild_photo = SKSpriteNode
                addblockWild()
                addImageWild()
                addgoback()
                
            }
            if touchedNode == btn_domestic{

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
            }
            if touchedNode == btn_domestic_photo{
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
            }
            if touchedNode == btn_wild_photo{
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
            }
            
            
            
        }
        
        //for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    func clearBoard(){
        print("entra")
        self.removeAllChildren()
        addgoback()
        addpurchase()
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            
            
            let location = (touch as! UITouch).location(in: self)
            let touchedNode = self.atPoint(location)
            
            if touchedNode is SKSpriteNode {
                let isAnimal = isAnimalTouched(node: touchedNode)
                
                if((btn_domestic.name == "btn_domestic_active" || btn_wild.name == "btn_wild_active") && isAnimal){
                    do {
                        audioPlayer = try AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: Bundle.main.path(forResource: touchedNode.name, ofType: "wav")!) as URL)
                        //audioPlayer.prepareToPlay()
                        audioPlayer.play()
                        audioPlayer.numberOfLoops = 0
                        let atlasaniaml = touchedNode.name! + "_sing"
                        
                        images.removeAll()
                        
                        atlasimages = SKTextureAtlas(named: "\(atlasaniaml)")
                        
                        //percorre a pasta onde estão as imagens e ordena
                        for i in 1...atlasimages.textureNames.count{
                            let nameatlas = touchedNode.name! + "\(i)"
                            
                            let name = "\(nameatlas).png"
                            images.append(SKTexture(imageNamed: "\(name)"))
                        }
                        
                        
                        //animate
                        animation = SKSpriteNode(imageNamed: atlasimages.textureNames[0])
                        animation.size = CGSize(width:(view?.scene?.size.width)! * 0.2, height: (view?.scene?.size.height)! * 0.2)
                        animation.position = touchedNode.position
                        animation.run(SKAction.wait(forDuration: 6.0))
                        animation.run(SKAction.animate(with: images, timePerFrame: 0.15), completion: {
                            //after complete animation
                            touchedNode.isHidden = false
                            self.animation.removeFromParent()
                            
                        })
                        animation.zPosition=1.0
                        
                        animation.removeFromParent()
                        self.addChild(animation)
                        touchedNode.isHidden = true
                        
                        
                    } catch {
                        // Create an assertion crash in the event that the app fails to play the sound
                        assert(false, error.localizedDescription)
                    }
                }
                if (btn_wild_photo.name == "btn_wild_photo_active" || btn_domestic_photo.name == "btn_domestic_photo_active"){
                    print("entra active wild")
                    let name = touchedNode.name! + "_photo"
                    if(name as String != "btn_domestic_photo_active_photo" && name as String != "btn_wild_photo_active_photo"){
                        
                        fullimage = SKSpriteNode(imageNamed: name)
                        fullimage.size = CGSize(width: (view?.bounds.width)!, height: (view?.bounds.height)!)
                        fullimage.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
                        
                        fullimage.zPosition = 2
                        fullimage.name = name
                        print(fullimage)
                        let myFunction = SKAction.run({()in self.fullimage})
                        let wait = SKAction.wait(forDuration: 3)
                        let remove = SKAction.run({() in self.removeImage()})
                        
                        self.run(SKAction.sequence([myFunction, wait, remove]))
                        
                        self.addChild(fullimage)
                        
                    }
                }
                
                //Sound touch to verify
                if(btn_sound.name == "btn_sound_active" && isAnimal) {
                    if(touchedNode.name == animalSoundPlayed) {
                        print("Correct")
                        //Stop sound to avoid mismatching on the next level
                        audioPlayer.stop()
                        
                        //Update Correct Answers
                        
                        if(numberShowAnimals < 10) {
                            numberShowAnimals = numberShowAnimals + 1
                        }
                        self.removeAllChildren()
                        addgoback()
                        MakeMenu()
                        addImagesSound()
                    } else {
                        print("Not Correct")
                    }
                }
            }
        }
    }
    
    
    func removeImage() {
        
        fullimage.removeFromParent()
        
    }
    
    //Verify if the sprite touched is an animal or a button from the menu
    private func isAnimalTouched(node: SKNode) -> Bool {
        if(node != btn_wild && node != btn_domestic && node != btn_domestic_photo && node != btn_wild_photo && node != btn_sound && node != blockdomestic && node != blockwild) {
            return true
        } else {
            return false
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    
    
}


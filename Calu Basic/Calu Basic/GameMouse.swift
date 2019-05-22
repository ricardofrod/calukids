//
//  GameMouse.swift
//  Calu Basic
//
//  Created by Ricardo Rodrigues on 26/05/17.
//  Copyright © 2017 Ricardo Rodrigues. All rights reserved.
//

import SpriteKit
import GameplayKit
import CoreData


class GameMouse: SKScene {
    //variaveis para configurar do sks
    var backsprite = SKSpriteNode(imageNamed: "backbtn")
    var purchase = SKSpriteNode(imageNamed: "btn_purchase")
    var arrayA = [Animal]()
    var arrayF = [Food]()
    var gridFood = SKSpriteNode()
    var movableNode : SKNode?
    var arrayAnimalF = [SKSpriteNode]()
    var arrayFoodF = [SKSpriteNode]()
    var imagenumber = Int(2)
    var blockFood = SKSpriteNode(imageNamed: "foodBlock")
    
    //var goposition = true
    
    var animalVar = Animal(imageName: "", textureImage: SKTexture(), foodAnimal: Food(imageNameF: "", textureImageF: SKTexture()), habitatAnimal: Habitat(imageHabitat: "", textureHabitat: SKTexture()), type: "")
    var foodVar = Food(imageNameF: "", textureImageF: SKTexture())
    //var para animacao
    var images = [SKTexture]()
    var atlasimages1 : SKTextureAtlas=SKTextureAtlas()
    var test = true
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
    var spriteanimated = SKSpriteNode()
    var animatedEnded = false
    var matchedIntersect = false
    var arrayAnimais = [cock, horse, monkey]
    var arrayFood = [banana, carrot, corn]

    let finger = UISwipeGestureRecognizer()

    var touchedLocation = CGPoint()
    
    
    override func didMove(to view: SKView) {
        view.showsFPS = false
        view.showsNodeCount = false
        UIApplication.shared.isIdleTimerDisabled = true
        
        let skView = self.view! as SKView
        self.size = view.frame.size
        
        skView.showsFPS = false
        skView.showsNodeCount = false
        
        
        backgroundColor = UIColor(red: 205/255, green: 233/255, blue: 236/255, alpha: 1)
        
        //adicionar back button
        addgoback()
        addpurchase()
        randomImage()
        
    }
    //animation for intro images
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
        
        var tmpFood = Food(imageNameF: "", textureImageF: SKTexture())
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
            
            let spriteanimal = SKSpriteNode()
            
            tmpAnimal = arrayAnimais[rand]
            texture = tmpAnimal.getTexture() as SKTexture
            nameAnimal = tmpAnimal.getName() as String
            arrayA.insert(arrayAnimais[rand], at: i)
            arrayF.insert(arrayAnimais[rand].getFoodAnimal(), at: i)
            
            let wsize = CGFloat((texture.size().width * hsize) / texture.size().height)
            
            spriteanimal.texture = texture
            spriteanimal.position = CGPoint(x: (view?.scene?.size.width)! * (0.2), y: (view?.scene?.size.height)! * (posY))
            spriteanimal.size = CGSize(width: wsize, height: hsize)
            //spriteanimal.physicsBody = SKPhysicsBody.init(rectangleOf: CGSize(width: spriteanimal.size.width, height: spriteanimal.size.height))
            //spriteanimal.physicsBody?.isDynamic = false
            spriteanimal.name = nameAnimal
            spriteanimal.xScale = spriteanimal.xScale * -1
            //spriteanimal.size = self.frame.size
            
            posY -= inc
            
            arrayAnimalF.append(spriteanimal)
            self.addChild(spriteanimal)
            excludeIndex.append(rand)
        }
        
        var texture2 = SKTexture()
        var nameFood = String()
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
            var rand = Int(arc4random_uniform(UInt32(arrayF.count)))
            
            //Verificar se o excludeIndex já tem valores e se algum deles se repete
            var z = 0
            while(z != excludeIndex.count) {
                if(rand == excludeIndex[z]) {
                    rand = Int(arc4random_uniform(UInt32(arrayF.count)))
                    z = 0
                } else {
                    z += 1
                }
            }
            
            //tmpAnimal = arrayA[rand]
            tmpFood = arrayF[rand]
            
            texture2 = tmpFood.getTexture() as SKTexture
            nameFood = tmpFood.getName() as String
            
            let wsizea = CGFloat((texture2.size().width * hsizea) / texture2.size().height)
            
            let spritefood = SKSpriteNode()
            spritefood.texture = texture2
            spritefood.position = CGPoint(x: (view?.scene?.size.width)! * (-0.2), y: (view?.scene?.size.height)! * (posYa))
            spritefood.size = CGSize(width: wsizea, height: hsizea)
            spritefood.name = nameFood
            spritefood.zPosition = 3
            //spritefood.size = self.frame.size
            
            posYa -= inca
            
            arrayFoodF.append(spritefood)
            self.addChild(spritefood)
            excludeIndex.append(rand)
        }
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
            else if(touchedNode == purchase){
                
                finger.direction = .down
                finger.addTarget(self, action: #selector(self.purchaseButton(sender:)))
                self.view?.addGestureRecognizer(finger)
                
                
            }
            success = false
            
            for imageFood in arrayFoodF {
                
                if(imageFood.isEqual(touchedNode)) {
                    Ximage = imageFood.position.x
                    Yimage = imageFood.position.y
                    movedSprite = imageFood
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

    
    override func update(_ currentTime: TimeInterval) {
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        
        
        for touch: AnyObject in touches {
            
            touchedLocation = touch.location(in: self)
            
            movedSprite.position.x = touchedLocation.x
            movedSprite.position.y = touchedLocation.y
        }
        
        touchFood()
    }
    func touchFood (){
        
        for imageAnimal in arrayAnimalF {
            
            let center1 = CGRect(x: movedSprite.position.x + (movedSprite.size.width / 2), y: movedSprite.position.y + (movedSprite.size.height / 2), width: movedSprite.size.width / 2, height: movedSprite.size.height / 2)
            let center2 = CGRect(x: imageAnimal.position.x + (imageAnimal.size.width / 2), y: imageAnimal.position.y + (imageAnimal.size.height / 2), width: imageAnimal.size.width / 2, height: imageAnimal.size.height / 2)
            
            if center1.intersects(center2) {
                let stranimal = imageAnimal.name
                
                let namefood = movedSprite.name
                let nameatlas = stranimal! + "_eat"
                
                
                for tmpAnimal in arrayA {
                    
                    if(tmpAnimal.getName() == stranimal){
                        for tmpFood in arrayF{
                            if(tmpFood.getName() == namefood){
                                if(tmpAnimal.getFoodAnimal().getName() == tmpFood.getName()){
                                    if(!matchedIntersect) {
                                        matchedIntersect = true
                                        
                                        atlasimages1 = SKTextureAtlas(named: "\(nameatlas)")
                                        var imagesEat = [SKTexture]()
                                        //percorre a pasta onde estão as imagens e ordena
                                        for i in 1...atlasimages1.textureNames.count {
                                            let nameatlasanimal = stranimal! + "_e_\(i)"
                                            
                                            let name = "\(nameatlasanimal).png"
                                            imagesEat.append(SKTexture(imageNamed: "\(name)"))
                                        }
                                        
                                        success = true
                                        //animate mouse
                                        imageAnimal.isHidden = true
                                        var animation = SKSpriteNode()
                                        animation = SKSpriteNode(imageNamed: atlasimages1.textureNames[0])
                                        animation.position = imageAnimal.position
                                        animation.size = imageAnimal.size
                                        animation.run(SKAction.wait(forDuration: 6.0))
                                        animatedEnded = false
                                        animation.run(SKAction.sequence([SKAction.scaleX(to: -1, duration: 0),SKAction.animate(with: imagesEat, timePerFrame: 0.15)]), completion: {
                                            self.correct += 1
                                            self.levelFinished()
                                            self.correctAll += 1
                                            
                                        })
                                        animation.zPosition=2.0
                                        
                                        movedSprite.isHidden=true
                                        animation.removeFromParent()
                                        self.addChild(animation)
                                    }
                                    return
                                } else {
                                    success = false
                                    wrongAnswer = true
                                }
                            }
                            
                        }
                        
                    }
                }
            }
            
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if (success == false){
            movedSprite.position = CGPoint(x: Ximage, y: Yimage)
            spriteanimated.removeFromParent()
            if(wrongAnswer) {
                wrongAnswer = false
            }
        } else {
            matchedIntersect = false
        }
        
        movedSprite = SKSpriteNode()
    }
    
    private func levelFinished() {
        if(correct == imagenumber){
            
            imagenumber += 1
            if(imagenumber == 4){
                clearBoard()
            } else {
                arrayFoodF.removeAll()
                arrayAnimalF.removeAll()
                arrayA.removeAll()
                arrayF.removeAll()
                self.removeAllChildren()
                
                addgoback()
                addpurchase()
                randomImage()
                correct = 0
            }
        }
        
        
    }
    
    func clearBoard(){
        self.removeAllChildren()
        addgoback()
        addpurchase()
        blockFood.position=CGPoint(x: (view?.bounds.minX)!, y: (view?.bounds.minY)!)
        blockFood.size=CGSize(width: (view?.bounds.width)!, height: (view?.bounds.height)!)
        insertChild(blockFood, at: 0)
    }
    
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    func touchDown(atPoint pos : CGPoint) {
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    
}

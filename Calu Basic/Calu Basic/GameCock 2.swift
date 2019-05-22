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

class GameCock: SKScene {
    
    //variaveis para configurar do sks
    var backsprite = SKSpriteNode(imageNamed: "backbtn")
    var purchase = SKSpriteNode(imageNamed: "btn_purchase")
    var arrayA = [Animal]()
    var arrayH = [Habitat]()
    var gridFood = SKSpriteNode()
    var movableNode : SKNode?
    var arrayAnimalF = [SKSpriteNode]()
    var arrayHabitatF = [SKSpriteNode]()
    var imagenumber = Int(2)
    
    //var goposition = true
    var animalVar = Animal(imageName: "", textureImage: SKTexture(), foodAnimal: Food(imageNameF: "", textureImageF: SKTexture()), habitatAnimal: Habitat(imageHabitat: "", textureHabitat: SKTexture()), type: "")
    var HabitatVar = Habitat(imageHabitat: "", textureHabitat: SKTexture())
    //var para animacao
    var images = [SKTexture]()
    
    var atlasimages1 : SKTextureAtlas=SKTextureAtlas()
    var atlasimages2 : SKTextureAtlas=SKTextureAtlas()
    var test = true
    var Ximage = CGFloat()
    var Yimage = CGFloat()
    var imageCenter1 = CGRect()
    var imageCenter2 = CGRect()
    var movedsprite = SKSpriteNode()
    var correct = 0
    var correctAll = 1
    var sucess = false
    var wrongAnswer = false
    var animationEnded = false
    var spriteanimated = SKSpriteNode()
    let walk = SKSpriteNode()
    let walkAction = SKAction()
    var animation = SKSpriteNode()
    
    
    
    var arrayAnimais = [cock, horse, monkey]
    var arrayHabitat = [chickenHouse, stable, tree]
    
    
    var touchedLocation = CGPoint()
    
    override func didMove(to view: SKView) {
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
            spriteAnimal.zPosition = 1
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
            
            posYa -= inca
            
            arrayHabitatF.append(spritehabitat)
            spritehabitat.removeFromParent()
            self.addChild(spritehabitat)
            excludeIndex.append(rand)
        }
    }    //animation for intro images
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        for touch: AnyObject in touches {
            
            let location = (touch as! UITouch).location(in: self)
            let touchedNode = self.atPoint(location)
            
            if touchedNode == backsprite {
                goBack()
            }
            
            touchHabitat(touches: touches)
        }
    }
    func goBack()
    {
        let changemenu = MenuScene(fileNamed: "MenuScene")
        
        self.scene?.view?.presentScene(changemenu!, transition: SKTransition.reveal(with: SKTransitionDirection.down, duration: 0.5))
    }
    
    func touchHabitat(touches: Set<UITouch>){
        
        for touch: AnyObject in touches {
            
            
            let location = (touch as! UITouch).location(in: self)
            let touchedNode = self.atPoint(location)
            //let previousLocation = touch.previousLocation(in: touchedNode)
            //let distanceX = touchedLocation.x - previousLocation.x
            //let distanceY = touchedLocation.y - previousLocation.y
            //var tmpAnimal = Animal(imageName: "", textureImage: SKTexture(), foodAnimal: Food(imageNameF: "", textureImageF: SKTexture()), habitatAnimal: Habitat(imageHabitat: "", textureHabitat: SKTexture()))
            //var tmpFood = Food(imageNameF: "", textureImageF: SKTexture())
            
            
            if touchedNode is SKSpriteNode{
                sucess = false
                for image1 in arrayAnimalF{
                    
                    if(image1.isEqual(touchedNode)){
                        if(test == true){
                            Ximage = image1.position.x
                            Yimage = image1.position.y
                            movedsprite = image1
                            
                            //print("X= \(Ximage) e Y = \(Yimage)")
                            test = false
                        }
                        touchedLocation = touch.location(in: self)
                        
                        image1.position.x = touchedLocation.x
                        image1.position.y = touchedLocation.y
                        for image2 in arrayHabitatF{
                            /*let transparente =  SKSpriteNode()
                             let sizeimage = CGSize(width: image2.size.width / 6 , height: image2.size.height / 6)
                             
                             transparente.size = sizeimage
                             transparente.position = image2.position*/
                            let center1 = CGRect(x: image1.position.x + (image1.size.width / 2), y: image1.position.y + (image1.size.height / 2), width: image1.size.width / 4, height: image1.size.height / 4)
                            let center2 = CGRect(x: image2.position.x + (image2.size.width / 2), y: image2.position.y + (image2.size.height / 2), width: image2.size.width / 4, height: image2.size.height / 4)
                            //walk.position = CGPoint(x: center2.origin.x, y: center2.origin.y)
                            //walk.size = CGSize(width: center2.width, height: center2.height)
                            //walk.isHidden = true
                            //if(image2.frame.contains(image1.centerRect)){
                            if center2.intersects(center1){
                                //let nameanimal = image2.name! + "_food"
                                let strhabitat = image2.name
                                
                                let nameanimal = image1.name
                                //let nameanimalW = image1.name
                                
                                let nameatlas = nameanimal! + "_habitat"
                                //let nameAtlas2 = nameanimal! + "_walk"
                                
                                for tmpHabitat in arrayH{
                                    //print("class = \(tmpHabitat.getName())")
                                    
                                    if(tmpHabitat.getName() == strhabitat){
                                        
                                        for tmpAnimal in arrayA{
                                            if(tmpAnimal.getName() == nameanimal){
                                                if(tmpAnimal.gethabitatAnimal().getName() == tmpHabitat.getName()){
                                                    
                                                    images.removeAll()
                                                    
                                                    atlasimages1 = SKTextureAtlas(named: "\(nameatlas)")
                                                    
                                                    //percorre a pasta onde estão as imagens e ordena
                                                    for i in 1...atlasimages1.textureNames.count{
                                                        let nameatlashabitat = nameanimal! + "\(i)"
                                                        
                                                        let name = "\(nameatlashabitat).png"
                                                        images.append(SKTexture(imageNamed: "\(name)"))
                                                    }
                                                    
                                                    
                                                    //animate
                                                    sucess = true
                                                    //animate mouse
                                                    //image2.isHidden = true
                                                    
                                                    //walk.removeAllActions()
                                                    
                                                    animation = SKSpriteNode(imageNamed: atlasimages1.textureNames[0])
                                                    animation.position = image2.position
                                                    animation.size = image2.size
                                                    animation.run(SKAction.wait(forDuration: 6.0))
                                                    animationEnded = false
                                                    animation.run(SKAction.animate(with: images, timePerFrame: 0.15), completion: {
                                                        self.correct += 1
                                                        self.levelFinished()
                                                        self.correctAll += 1
                                                        
                                                        
                                                    })
                                                    animation.zPosition=1.0
                                                    
                                                    image1.isHidden=true
                                                    animation.removeFromParent()
                                                    
                                                    self.addChild(animation)
                                                    
                                                    /*var images2 = [SKTexture]()
                                                     atlasimages2 = SKTextureAtlas(named: "\(nameAtlas2)")
                                                     
                                                     for ii in 1...atlasimages2.textureNames.count{
                                                     let nameatlaswalk = nameanimalW! + "\(ii)"
                                                     
                                                     let name1 = "\(nameatlaswalk).png"
                                                     images2.append(SKTexture(imageNamed: "\(name1)"))
                                                     }
                                                     */
                                                    
                                                    
                                                    return
                                                } else {
                                                    var imageStar = [SKTexture]()
                                                    //while(animationEnded == false){
                                                    imageStar.removeAll()
                                                    let atlasimages = SKTextureAtlas(named: "stars")
                                                    
                                                    for i in 1...atlasimages.textureNames.count{
                                                        
                                                        let name = "stars\(i).png"
                                                        imageStar.append(SKTexture(imageNamed: "\(name)"))
                                                    }
                                                    //animate mouse
                                                    //image2.isHidden = true
                                                    //spriteanimated = SKSpriteNode(imageNamed: atlasimages.textureNames[0])
                                                    spriteanimated.position = CGPoint(x: image2.position.x / 1.5, y: image2.position.y)
                                                    spriteanimated.size = image2.size
                                                    spriteanimated.run(SKAction.wait(forDuration: 6.0))
                                                    spriteanimated.zPosition = 1
                                                    spriteanimated.run(SKAction.repeat(SKAction.animate(with: imageStar, timePerFrame: 0.05), count: -1), completion: {
                                                        self.spriteanimated.alpha = 0.0})
                                                    
                                                    //image1.isHidden=true
                                                    spriteanimated.removeFromParent()
                                                    self.addChild(spriteanimated)
                                                    sucess = false
                                                    wrongAnswer = true
                                                    //}
                                                    
                                                    
                                                    
                                                }
                                            }
                                            /*else {
                                             print("entra")
                                             image1.position.x = Ximage
                                             image1.position.y = Yimage
                                             }*/
                                        }
                                        
                                    }
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
                correct = 0
                
                correctAll = 0
            }
        }
    }
    func clearBoard(){
        print("entra")
        self.removeAllChildren()
        addgoback()
        addpurchase()
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchHabitat(touches: touches)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (sucess == false){
            movedsprite.position = CGPoint(x: Ximage, y: Yimage)
            test = true
            spriteanimated.removeFromParent()
            if(wrongAnswer) {
                wrongAnswer = false
            }
            //animation.removeAllActions()
            
            
            
            //self.addChild(walk)
            
        } else {
            
            //spriteanimated.removeFromParent()
            
            test = true
            //sucess = false
        }
        
        
    }
    
    
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    
}



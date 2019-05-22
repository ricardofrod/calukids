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
    var movedsprite = SKSpriteNode()
    var correct = 0
    var correctAll = 1
    
    var sucess = false
    var wrongAnswer = false
    var animationEnded = false
    var spriteanimated = SKSpriteNode()
    var animatedEnded = false
    
    var arrayAnimais = [cock, horse, monkey]
    var arrayFood = [banana, carrot, corn]
    
    
    var touchedLocation = CGPoint()
    
    
    override func didMove(to view: SKView) {
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
            spritefood.zPosition = 1
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
            
            touchFood(touches: touches)
        }
    }
    
    
    
    override func update(_ currentTime: TimeInterval) {
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        
        touchFood(touches: touches)
        
    }
    func touchFood (touches: Set<UITouch>){
        
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
                for image1 in arrayFoodF{
                    
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
                        for image2 in arrayAnimalF{
                            /*let transparente =  SKSpriteNode()
                             let sizeimage = CGSize(width: image2.size.width / 6 , height: image2.size.height / 6)
                             
                             transparente.size = sizeimage
                             transparente.position = image2.position*/
                            let center1 = CGRect(x: image1.position.x + (image1.size.width / 2), y: image1.position.y + (image1.size.height / 2), width: image1.size.width / 4, height: image1.size.height / 4)
                            let center2 = CGRect(x: image2.position.x + (image2.size.width / 2), y: image2.position.y + (image2.size.height / 2), width: image2.size.width / 4, height: image2.size.height / 4)
                            
                            //imageCenter1 = image1.centerRect
                            //imageCenter2 = image2.centerRect
                            
                            //if(image2.frame.contains(image1.centerRect)){
                            if center1.intersects(center2){
                                //let nameanimal = image2.name! + "_food"
                                let stranimal = image2.name
                                
                                let namefood = image1.name
                                let nameatlas = stranimal! + "_eat"
                                
                                
                                for tmpAnimal in arrayA{
                                    
                                    if(tmpAnimal.getName() == stranimal){
                                        
                                        
                                        for tmpFood in arrayF{
                                            if(tmpFood.getName() == namefood){
                                                if(tmpAnimal.getFoodAnimal().getName() == tmpFood.getName()){
                                                    
                                                    images.removeAll()
                                                    
                                                    
                                                    atlasimages1 = SKTextureAtlas(named: "\(nameatlas)")
                                                    
                                                    //percorre a pasta onde estão as imagens e ordena
                                                    for i in 1...atlasimages1.textureNames.count {
                                                        let nameatlasanimal = stranimal! + "\(i)"
                                                        
                                                        let name = "\(nameatlasanimal).png"
                                                        images.append(SKTexture(imageNamed: "\(name)"))
                                                    }
                                                    
                                                    sucess = true
                                                    //animate mouse
                                                    image2.isHidden = true
                                                    var animation = SKSpriteNode()
                                                    animation = SKSpriteNode(imageNamed: atlasimages1.textureNames[0])
                                                    animation.position = image2.position
                                                    animation.size = image2.size
                                                    animation.run(SKAction.wait(forDuration: 6.0))
                                                    animatedEnded = false
                                                    animation.run(SKAction.animate(with: images, timePerFrame: 0.15), completion: {
                                                        self.correct += 1
                                                        self.levelFinished()
                                                        self.correctAll += 1
                                                        
                                                        
                                                    })
                                                    animation.zPosition=1.0
                                                    
                                                    image1.isHidden=true
                                                    animation.removeFromParent()
                                                    
                                                    self.addChild(animation)
                                                    
                                                    return
                                                } else {
                                                    sucess = false
                                                    wrongAnswer = true
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
            
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        //if(animationEnded == true){
        
        //touchFood(touches: touches)
        if (sucess == false){
            movedsprite.position = CGPoint(x: Ximage, y: Yimage)
            test = true
            spriteanimated.removeFromParent()
            if(wrongAnswer) {
                wrongAnswer = false
            }
        } else {
            //spriteanimated.removeFromParent()
            test = true
            //sucess = false
        }
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
                print(imagenumber)
                
                addgoback()
                addpurchase()
                randomImage()
                correct = 0
            }
        }
        
        
    }
    
    func clearBoard(){
        print("entra")
        self.removeAllChildren()
        addgoback()
        addpurchase()
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

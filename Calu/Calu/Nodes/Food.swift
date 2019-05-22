//
//  Food.swift
//  calu
//
//  Created by Gonçalo Rodrigues on 23/11/14.
//  Copyright (c) 2014 Funzoi. All rights reserved.
//

import SpriteKit

enum FoodName: Int {
    case ACORNS = 1, BANANA, BONE, CARROT, CHEESE, CHICKEN, CORN, EARTHWORM, FISH, FLIES,
    GRASS_DRY, GRASS, LEAVES, MEAT
}

class Food: SKSpriteNode {
    var foodName:FoodName
    var foodNameString:NSString
    var sizeAnimal:CGSize
    var positionInitial:CGPoint?
    var validAnimals : [AnimalName]?
    var delegate: GameSceneDelegate?
    var draggable: Bool?
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(name: FoodName) {
        sizeAnimal = CGSizeMake(244, 188)
        foodName = name
        foodNameString = "food"
        validAnimals = []
        draggable = true
        super.init(texture: nil, color: UIColor.clearColor(), size: sizeAnimal)
        setFood(name)
    }
    
    func setFood(name: FoodName) {
        switch(name) {
        case .ACORNS:
            foodNameString = "acorns"
            validAnimals = [.PIG]
            break
        case .BANANA:
            foodNameString = "banana"
            validAnimals = [.MONKEY]
            break
        case .BONE:
            validAnimals = [.DOG]
            foodNameString = "bone"
            break
        case .CARROT:
            foodNameString = "carrot"
            validAnimals = [.DONKEY, .HORSE, .RABBIT]
            break
        case .CHEESE:
            foodNameString = "cheese"
            validAnimals = [.MOUSE]
            break
        case .CHICKEN:
            foodNameString = "chicken"
            validAnimals = [.WOLF]
            break
        case .CORN:
            foodNameString = "corn"
            validAnimals = [.COCK]
            break
        case .EARTHWORM:
            foodNameString = "earthworm"
            validAnimals = [.BIRD]
            break
        case .FISH:
            foodNameString = "fish"
            validAnimals = [.CAT, .SEAL, .DOLPHIN]
            break
        case .FLIES:
            foodNameString = "flies"
            validAnimals = [.FROG]
            break
        case .GRASS_DRY:
            foodNameString = "grass_dry"
            validAnimals = [.ZEBRA]
            break
        case .GRASS:
            foodNameString = "grass"
            validAnimals = [.COW, .SHEEP, .GOAT]
            break
        case .LEAVES:
            foodNameString = "leaves"
            validAnimals = [.ELEPHANT, .GIRAFFE]
            break
        case .MEAT:
            foodNameString = "meat"
            validAnimals = [.LION]
            break
        default:
            break
        }
        positionInitial = CGPointMake(0, 0)
        // set properties defined in super
        userInteractionEnabled = true

        super.texture = SKSpriteNode(imageNamed: foodNameString as String).texture
    }
    
    //MARK: Touch Handlers
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        
//        for touch in touches {
//            if (animate == true && draggable==false) {
//                stopAllAnimations()
//                self.playAnimation()
//                frontTexture.alpha = 0
//                makeAnimation(AnimalAnimation.NORMAL)
//                playAnimation(lastAnimationLoaded!, delay: 0.1, numberOfTimes: 2)
//                let soundAnimal = SKAction.playSoundFileNamed(animalNameString!+".wav", waitForCompletion: true);
//                let delayBegin = SKAction.waitForDuration(NSTimeInterval(2))
//                let delayAfter = SKAction.waitForDuration(NSTimeInterval(2))
//                //                TODO: set correct times for delays
//                let sequence = SKAction.sequence([
//                    soundAnimal,
//                    delayBegin,
//                    soundAnimal,
//                    delayAfter,
//                    SKAction.runBlock({ () -> Void in
//                        self.enableTouches()
//                    })])
//                runAction(sequence)
//                
//                return
//            }
//            else if (draggable == false) {
//                enlarge()
//                return
//            }
//            
//            if enlarged { return }
        
            zPosition = 15
            
//            delegate = DragScene(size: CGSizeMake(1024, 768))
//            self.name = "food"
//            delegate?.dragFood!(self)
        
            let dragFood: String
            dragFood = "DragFood"
            self.name = "food"
            let notificationCenter = NSNotificationCenter.defaultCenter()
            notificationCenter.postNotificationName(dragFood, object: self)
        
            let liftUp = SKAction.scaleTo(1.2, duration: 0.2)
            SKAction.runAction(liftUp, onChildWithName: "food")
            
            //            let wiggleIn = SKAction.scaleXTo(1.0, duration: 0.2)
            //            let wiggleOut = SKAction.scaleXTo(1.05, duration: 0.2)
            //            let wiggle = SKAction.sequence([wiggleIn, wiggleOut])
            //            let wiggleRepeat = SKAction.repeatActionForever(wiggle)
            
            // again, since this is the touched sprite
            // run the action on self (implied)
            //            runAction(wiggleRepeat, withKey: "wiggle")
        }

    func setPos(aPosition: CGPoint) {
        positionInitial = aPosition
        position = aPosition
    }
    
    func moveToPositionInitial() {
        self.userInteractionEnabled = false
        //        let move = SKAction.moveTo(positionInitial!, duration: 0.5)
        //        let fade = SKAction.fadeOutWithDuration(0.25)
        //        runAction(fade)
        //        runAction(move, completion: {
        //            self.removeFromParent()
        //        })
        
        self.removeFromParent()
        
    }

    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        if enlarged { return }
//        if (animate == true) { return }
//        if let touch = touches.first{
//            let location = touch.locationInNode(self)
//            
//            
////            if let touch = touches.first! as? UITouch {
////                _ = touch.locationInNode(self)
////            }
//            position = location
//        }
        
//        if let touch = touches.first {
//            let location = touch.locationInNode(scene!)  // make sure this is scene, not self
//            position = location
//        }
//        for _ in touches {
//            let location = (touches.first)?.locationInNode(scene!)  // make sure this is scene, not self
//            position = location!
//        }
        
        if let touch = touches.first {
            if let aScene = scene {
                let location = touch.locationInNode(aScene)  // make sure this is scene, not self
                position = location
            }
        }
    
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        if enlarged { return }
//        if (animate == true && draggable==false) { return }
//        
        for _ in touches {
//            zPosition = 0
//            
//            let dropDown = SKAction.scaleTo(1.0, duration: 0.2)
//            runAction(dropDown)
//            moveToPositionInitial()
            
            //            removeActionForKey("wiggle")
        }
        let dragFoodEnded: String
        dragFoodEnded = "DragFoodEnded"
        self.name = "food"
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.postNotificationName(dragFoodEnded, object: self)
    }
    
    func moveToPosition(pos: CGPoint, duration: NSTimeInterval) {
        let move = SKAction.moveTo(pos, duration: duration)
        runAction(move)
    }
    
    
}
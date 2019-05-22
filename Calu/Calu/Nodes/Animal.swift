//
//  Animal.swift
//  calu
//
//  Created by Gonçalo Rodrigues on 20/09/14.
//  Copyright (c) 2014 Funzoi. All rights reserved.
//

import Foundation
import SpriteKit
import SoundManager

extension Int {
    func format(f: String) -> String {
        return NSString(format: "%\(f)d", self) as String
    }
}

enum AnimalName: Int {
    case BEAR = 1, BIRD, CAT, COCK, COW, DOG, DOLPHIN, DONKEY, DUCK, ELEPHANT,
    FROG, HORSE, LION, MONKEY, PIG, SEAL, SHEEP, SNAKE, WOLF, ZEBRA, FISH, CAMEL, MOUSE, GOAT, RABBIT, GIRAFFE
}

enum AnimalType: Int {
    case DOMESTIC = 1,
    WILD
}

enum AnimalAnimation: Int {
    case NORMAL = 1,
    WALK,
    EATING
}

let domestic: [AnimalName] = [.DOG, .PIG, .COW, .CAT, .DONKEY, .DUCK, .FROG, .HORSE, .COCK, .SHEEP]
let wild: [AnimalName] = [.BEAR, .SNAKE, .DOLPHIN, .ELEPHANT, .LION, .MONKEY, .WOLF, .BIRD, .SEAL, .ZEBRA]

class Animal: SKUAnimatedNode {
    
    var animalName:AnimalName
    var animalNameString: NSString?
    var animalAnimationDefault: NSString?
    var animalType:AnimalType

    // Need to buy first
    var locked: Bool?
    var sizeAnimal:CGSize
    var positionInitial:CGPoint?
    
    var largeTexture: SKTexture?
    let photo :String?
    
    var enlarged = false
    var savedPosition = CGPointZero
    var delegate: GameSceneDelegate?
    
    var draggable: Bool?
    var animate: Bool?
    var selection: Bool?
    
    required init(coder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    init(name: AnimalName) {

        // TODO: check sizes iPhone!
        if (UIDevice.currentDevice().userInterfaceIdiom == .Pad) {
            sizeAnimal = CGSizeMake(218, 218)
        }
        else {
            sizeAnimal = CGSizeMake(90, 90)
        }

        
        animalName = name
        if (domestic.contains(animalName)) {
            animalType = .DOMESTIC
        }
        else {
            animalType = .WILD
        }
        
        var nameString : NSString
        switch(name) {
        case .BEAR:
            nameString = "bear"
            animalAnimationDefault = "sings"
            break
        case .FISH:
            nameString = "fish"
            animalAnimationDefault = "swim"
            break
        case .BIRD:
            nameString = "bird"
            animalAnimationDefault = "sings"
            break
        case .CAT:
            nameString = "cat"
            animalAnimationDefault = "meow"
            break
        case .CAMEL:
            nameString = "camel"
            animalAnimationDefault = "sings"
            break
        case .COCK:
            nameString = "cock"
            animalAnimationDefault = "sings"
            break
        case .COW:
            nameString = "cow"
            animalAnimationDefault = "mugir"
            break
        case .DOG:
            nameString = "dog"
            animalAnimationDefault = "barking"
            break
        case .DOLPHIN:
            nameString = "dolphin"
            animalAnimationDefault = "sings"
            break
        case .DONKEY:
            nameString = "donkey"
            animalAnimationDefault = "bray"
            break
        case .DUCK:
            nameString = "duck"
            animalAnimationDefault = "quacks"
            break
        case .ELEPHANT:
            nameString = "elephant"
            animalAnimationDefault = "roar"
            break
        case .FROG:
            nameString = "frog"
            animalAnimationDefault = "croak"
            break
        case .HORSE:
            nameString = "horse"
            animalAnimationDefault = "neighing"
            break
        case .LION:
            nameString = "lion"
            animalAnimationDefault = "roar"
            break
        case .MONKEY:
            nameString = "monkey"
            animalAnimationDefault = "squeal"
            break
        case .PIG:
            nameString = "pig"
            animalAnimationDefault = "grunt"
            break
        case .SEAL:
            nameString = "seal"
            animalAnimationDefault = "sings"
            break
        case .SHEEP:
            nameString = "sheep"
            animalAnimationDefault = "bleat"
            break
        case .SNAKE:
            nameString = "snake"
            animalAnimationDefault = "hiss"
            break
        case .WOLF:
            nameString = "wolf"
            animalAnimationDefault = "howl"
            break
        case .ZEBRA:
            nameString = "zebra"
            animalAnimationDefault = "neighing"
            break
        case .MOUSE:
            nameString = "mouse"
            animalAnimationDefault = "eating"
            break
        case .GOAT:
            nameString = "goat"
            animalAnimationDefault = "eating"
            break
        case .GIRAFFE:
            nameString = "giraffe"
            animalAnimationDefault = "eating"
            break
        case .RABBIT:
            nameString = "rabbit"
            animalAnimationDefault = "eating"
            break
            
        default:
            nameString = "bear"
        }
        
        animalNameString = nameString
        photo = (animalNameString! as String)+".jpg"

        super.init(image: (nameString as String)+"_"+(animalAnimationDefault! as String)+"_00.png")

        
        
        super.frontTexture.size = convertSizeToPhone(CGSizeMake(244, 188))
        draggable = false
        animate = false
        selection = false
        positionInitial = convertPointToPhone(CGPointMake(0, 0))
        
//        photo = (animalNameString! as String)+".jpg"
        
        // set properties defined in super
        userInteractionEnabled = true
        
        _ = SKScene()
    }
    
    func enableTouches(){
        delegate = GameScene(size: CGSizeMake(1024, 768))
        delegate?.enableAllTouchesWithName!("animal")
    }

    func disableTouches(){
        delegate = GameScene(size: CGSizeMake(1024, 768))
        delegate?.disableAllTouchesWithName!("animal")
    }
    
    func stopAllAnimations(){
        delegate = GameScene(size: CGSizeMake(1024, 768))
        delegate?.stopAllAnimations!("animal")
    }
    
    func playSound(delay: NSTimeInterval) {
        SoundManager.sharedManager().playSound((animalNameString! as String)+".wav")
    }
    
    func addBorder() {
        let border = SKSpriteNode(imageNamed: "border");
        if (getDevice() == DeviceType.IPHONE5) {
            border.setScale(0.5)
        }
        self.addChild(border);
    }
    
    func removeFrontTexture() {
 
    }
    
    //MARK: Touch Handlers
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {

        for _ in touches {
            if (selection == true) {
                let correctAnimal: String
                correctAnimal = "CorrectAnimal"
                let notificationCenter = NSNotificationCenter.defaultCenter()
                notificationCenter.postNotificationName(correctAnimal, object: self)
                return
            }
            else if (animate == true && draggable==false) {
                stopAllAnimations()
                self.playAnimation()
                frontTexture.alpha = 0
                makeAnimation(AnimalAnimation.NORMAL)
                playAnimation(lastAnimationLoaded!, delay: 0.1, numberOfTimes: 1)
                let soundAnimal = SKAction.playSoundFileNamed((animalNameString! as String)+".wav", waitForCompletion: true);
                
                var delayBegin = SKAction.waitForDuration(NSTimeInterval(0))
                var frame = 0.0
                if (animalName == .FROG) {
                    frame = 27
                }
                else if (animalName == .DOG) {
                    frame = 8
                }
                else if (animalName == .CAT) {
                    frame = 17
                }
                else if (animalName == .COW) {
                    frame = 9
                }
                else if (animalName == .SHEEP) {
                    frame = 13
                }
                else if (animalName == .DUCK) {
                    frame = 11
                }
                else if (animalName == .HORSE) {
                    frame = 15
                }
                else if (animalName == .PIG) {
                    frame = 14
                }
                else if (animalName == .COCK) {
                    frame = 5
                }
                else if (animalName == .BIRD) {
                    frame = 17
                }
                else if (animalName == .DONKEY) {
                    frame = 14
                }
                else if (animalName == .ELEPHANT) {
                    frame = 31
                }
                else if (animalName == .MONKEY) {
                    frame = 43
                }
                else if (animalName == .LION) {
                    frame = 19
                }
                else if (animalName == .ZEBRA) {
                    frame = 14
                }
                else if (animalName == .DOLPHIN) {
                    frame = 15
                }
                else if (animalName == .SEAL) {
                    frame = 13
                }
                else if (animalName == .BEAR) {
                    frame = 16
                }
                else if (animalName == .WOLF) {
                    frame = 16
                }
                else if (animalName == .SNAKE) {
                    frame = 15
                }
                let delay = frame*0.1
                delayBegin = SKAction.waitForDuration(NSTimeInterval(delay))
            
                
//                let delayAfter = SKAction.waitForDuration(NSTimeInterval(2))
//                TODO: set correct times for delays
                let sequence = SKAction.sequence([
                    delayBegin,
                    soundAnimal,
                    SKAction.runBlock({ () -> Void in
                        self.enableTouches()
                    })])
                runAction(sequence)

                return
            }
            else if (draggable == false) {
                enlarge()
                return
            }
            
            if (enlarged == true) { return }
            
            zPosition = 15
            let dragAnimal: String
            dragAnimal = "DragAnimal"
            self.name = "animal"
            let notificationCenter = NSNotificationCenter.defaultCenter()
            notificationCenter.postNotificationName(dragAnimal, object: self)

            
//            delegate = DragScene(size: CGSizeMake(1024, 768))
//            self.name = "animal"
//            delegate?.dragAnimal!(self)
            
            let liftUp = SKAction.scaleTo(1, duration: 0.2)
            SKAction.runAction(liftUp, onChildWithName: "animal")
            
//            let wiggleIn = SKAction.scaleXTo(1.0, duration: 0.2)
//            let wiggleOut = SKAction.scaleXTo(1.05, duration: 0.2)
//            let wiggle = SKAction.sequence([wiggleIn, wiggleOut])
//            let wiggleRepeat = SKAction.repeatActionForever(wiggle)
            
            // again, since this is the touched sprite
            // run the action on self (implied)
//            runAction(wiggleRepeat, withKey: "wiggle")
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if (enlarged == true) { return }
        if (animate == true) { return }
        if (draggable == false) { return }
        
        if let touch = touches.first {
            if let aScene = scene {
                let location = touch.locationInNode(aScene)  // make sure this is scene, not self
                position = location
            }
        }
        
//        if let touch = touches.first{
//            let location = touch.locationInNode(self)
//
////            let location = touch.locationInNode(scene!)  // make sure this is scene, not self
//            
//            if let touch = touches.first! as? UITouch {
//                _ = touch.locationInNode(self)
//            }
//            position = location
//        }
        
//        for touch in touches {
//            let location = (touches.first)?.locationInNode(scene!)  // make sure this is scene, not self
//            position = location!
//        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if (selection == true) { return }
        if (enlarged == true) { return }
        if (animate == true && draggable==false) { return }

        for _ in touches {
            zPosition = 0
            
//            let dropDown = SKAction.scaleTo(1.0, duration: 0.2)
//            runAction(dropDown)
            moveToPositionInitial()
//            removeActionForKey("wiggle")
        }
    }
    
    func enlarge() {
        if enlarged {
            let slide = SKAction.moveTo(savedPosition, duration:0.5)
            let scaleDown = SKAction.scaleTo(1.0, duration:0.5)
            runAction(SKAction.group([slide, scaleDown])) {
                self.enlarged = false
                self.zPosition = 0
                self.texture = self.frontTexture.texture
            }
        } else {
            enlarged = true
//            let animal = NSDictionary(object: photo!, forKey: "PhotoReal")
//            NSNotificationCenter.defaultCenter().postNotificationName("PostData", object: nil, userInfo: animal as [NSObject : AnyObject]);
            
            savedPosition = position
            delegate = GameScene(size: CGSizeMake(1024, 768))
            delegate?.goRealPhoto!(self)
        }
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
    
    override func pauseAnimation() {
        removeActionForKey("animation")
    }
    
    override func playAnimation() {
        self.speed = 1
    }
    
    func playAnimation(animationType: AnimalAnimation, numberOfTimes: Int) {
        
        
        if (animalName == (AnimalName).LION) {
            if (animationType == .NORMAL) {
                playAnimation("roar", delay:0.1, numberOfTimes: numberOfTimes)
            }
            else if (animationType == .WALK) {
                playAnimation("walking", delay:0.1, numberOfTimes: numberOfTimes)
            }
            else if (animationType == .EATING) {
                playAnimation("eating", delay:0.1, numberOfTimes: numberOfTimes)
            }
        }
        else if (animalName == (AnimalName).BEAR) {
            if (animationType == .NORMAL) {
                playAnimation("sings", delay:0.1, numberOfTimes: numberOfTimes)
            }
            else if (animationType == .WALK) {
                playAnimation("walking", delay:0.1, numberOfTimes: numberOfTimes)
            }
        }
        else if (animalName == (AnimalName).FISH) {
            if (animationType == .NORMAL) {
                playAnimation("swim", delay:0.1, numberOfTimes: numberOfTimes)
            }
            else if (animationType == .WALK) {
                playAnimation("walking", delay:0.1, numberOfTimes: numberOfTimes)
            }
        }
        else if (animalName == (AnimalName).BIRD) {
            if (animationType == .NORMAL) {
                playAnimation("sings", delay:0.1, numberOfTimes: numberOfTimes)
            }
            else if (animationType == .WALK) {
                playAnimation("walking", delay:0.1, numberOfTimes: numberOfTimes)
            }
            else if (animationType == .EATING) {
                playAnimation("eating", delay:0.1, numberOfTimes: numberOfTimes)
            }
        }
        else if (animalName == (AnimalName).DOG) {
            if (animationType == .NORMAL) {
                playAnimation("barking", delay:0.1, numberOfTimes: numberOfTimes)
            }
            else if (animationType == .WALK) {
                playAnimation("walking", delay:0.1, numberOfTimes: numberOfTimes)
            }
            else if (animationType == .EATING) {
                playAnimation("eating", delay:0.1, numberOfTimes: numberOfTimes)
            }
            
        }
        else if (animalName == (AnimalName).HORSE) {
            if (animationType == .NORMAL) {
                playAnimation("neighing", delay:0.1, numberOfTimes: numberOfTimes)
            }
            else if (animationType == .WALK) {
                playAnimation("walking", delay:0.1, numberOfTimes: numberOfTimes)
            }
            else if (animationType == .EATING) {
                playAnimation("eating", delay:0.1, numberOfTimes: numberOfTimes)
            }
            
        }
        else if (animalName == (AnimalName).SNAKE) {
            if (animationType == .NORMAL) {
                playAnimation("hiss", delay:0.1, numberOfTimes: numberOfTimes)
            }
            else if (animationType == .WALK) {
                playAnimation("walking", delay:0.1, numberOfTimes: numberOfTimes)
            }
        }
        else if (animalName == (AnimalName).ELEPHANT) {
            if (animationType == .NORMAL) {
                playAnimation("roar", delay:0.1, numberOfTimes: numberOfTimes)
            }
            else if (animationType == .WALK) {
                playAnimation("walking", delay:0.1, numberOfTimes: numberOfTimes)
            }
            else if (animationType == .EATING) {
                playAnimation("eating", delay:0.1, numberOfTimes: numberOfTimes)
            }
            
        }
        else if (animalName == (AnimalName).CAT) {
            if (animationType == .NORMAL) {
                playAnimation("meow", delay:0.1, numberOfTimes: numberOfTimes)
            }
            else if (animationType == .WALK) {
                playAnimation("walking", delay:0.1, numberOfTimes: numberOfTimes)
            }
            else if (animationType == .EATING) {
                playAnimation("eating", delay:0.1, numberOfTimes: numberOfTimes)
            }
            
        }
        else if (animalName == (AnimalName).COCK) {
            if (animationType == .NORMAL) {
                playAnimation("sings", delay:0.1, numberOfTimes: numberOfTimes)
            }
            else if (animationType == .WALK) {
                playAnimation("walking", delay:0.1, numberOfTimes: numberOfTimes)
            }
            else if (animationType == .EATING) {
                playAnimation("eating", delay:0.1, numberOfTimes: numberOfTimes)
            }
            
        }
        else if (animalName == (AnimalName).COW) {
            if (animationType == .NORMAL) {
                playAnimation("mugir", delay:0.1, numberOfTimes: numberOfTimes)
            }
            else if (animationType == .WALK) {
                playAnimation("walking", delay:0.1, numberOfTimes: numberOfTimes)
            }
            else if (animationType == .EATING) {
                playAnimation("eating", delay:0.1, numberOfTimes: numberOfTimes)
            }
        }
        else if (animalName == (AnimalName).DOLPHIN) {
            if (animationType == .NORMAL) {
                playAnimation("sings", delay:0.1, numberOfTimes: numberOfTimes)
            }
            else if (animationType == .WALK) {
                playAnimation("walking", delay:0.1, numberOfTimes: numberOfTimes)
            }
            else if (animationType == .EATING) {
                playAnimation("eating", delay:0.1, numberOfTimes: numberOfTimes)
            }
        }
        else if (animalName == (AnimalName).DUCK) {
            if (animationType == .NORMAL) {
                playAnimation("quacks", delay:0.1, numberOfTimes: numberOfTimes)
            }
            else if (animationType == .WALK) {
                playAnimation("walking", delay:0.1, numberOfTimes: numberOfTimes)
            }
        }
        else if (animalName == (AnimalName).FROG) {
            if (animationType == .NORMAL) {
                playAnimation("croak", delay:0.1, numberOfTimes: numberOfTimes)
            }
            else if (animationType == .WALK) {
                playAnimation("walking", delay:0.1, numberOfTimes: numberOfTimes)
            }
            else if (animationType == .EATING) {
                playAnimation("eating", delay:0.1, numberOfTimes: numberOfTimes)
            }
        }
        else if (animalName == (AnimalName).MONKEY) {
            if (animationType == .NORMAL) {
                playAnimation("squeal", delay:0.1, numberOfTimes: numberOfTimes)
            }
            else if (animationType == .WALK) {
                playAnimation("walking", delay:0.1, numberOfTimes: numberOfTimes)
            }
            else if (animationType == .EATING) {
                playAnimation("eating", delay:0.1, numberOfTimes: numberOfTimes)
            }
            
        }
        else if (animalName == (AnimalName).PIG) {
            if (animationType == .NORMAL) {
                playAnimation("grunt", delay:0.1, numberOfTimes: numberOfTimes)
            }
            else if (animationType == .WALK) {
                playAnimation("walking", delay:0.1, numberOfTimes: numberOfTimes)
            }
            else if (animationType == .EATING) {
                playAnimation("eating", delay:0.1, numberOfTimes: numberOfTimes)
            }
        }
        else if (animalName == (AnimalName).SEAL) {
            if (animationType == .NORMAL) {
                playAnimation("sings", delay:0.1, numberOfTimes: numberOfTimes)
            }
            else if (animationType == .WALK) {
                playAnimation("walking", delay:0.1, numberOfTimes: numberOfTimes)
            }
            else if (animationType == .EATING) {
                playAnimation("eating", delay:0.1, numberOfTimes: numberOfTimes)
            }
            
        }
        else if (animalName == (AnimalName).SHEEP) {
            if (animationType == .NORMAL) {
                playAnimation("bleat", delay:0.1, numberOfTimes: numberOfTimes)
            }
            else if (animationType == .WALK) {
                playAnimation("walking", delay:0.1, numberOfTimes: numberOfTimes)
            }
            else if (animationType == .EATING) {
                playAnimation("eating", delay:0.1, numberOfTimes: numberOfTimes)
            }
            
        }
        else if (animalName == (AnimalName).WOLF) {
            if (animationType == .NORMAL) {
                playAnimation("howl", delay:0.1, numberOfTimes: numberOfTimes)
            }
            else if (animationType == .WALK) {
                playAnimation("walking", delay:0.1, numberOfTimes: numberOfTimes)
            }
            else if (animationType == .EATING) {
                playAnimation("eating", delay:0.1, numberOfTimes: numberOfTimes)
            }
            
        }
        else if (animalName == (AnimalName).ZEBRA) {
            if (animationType == .NORMAL) {
                playAnimation("neighing", delay:0.1, numberOfTimes: numberOfTimes)
            }
            else if (animationType == .WALK) {
                playAnimation("walking", delay:0.1, numberOfTimes: numberOfTimes)
            }
            else if (animationType == .EATING) {
                playAnimation("eating", delay:0.1, numberOfTimes: numberOfTimes)
            }
            
        }
        else if (animalName == (AnimalName).CAMEL) {
            if (animationType == .NORMAL) {
                playAnimation("sings", delay:0.1, numberOfTimes: numberOfTimes)
            }
            else if (animationType == .WALK) {
                playAnimation("walking", delay:0.1, numberOfTimes: numberOfTimes)
            }
        }
        else if (animalName == (AnimalName).MOUSE) {
            if (animationType == .EATING) {
                playAnimation("eating", delay:0.1, numberOfTimes: numberOfTimes)
            }
        }
        else if (animalName == (AnimalName).GOAT) {
            if (animationType == .EATING) {
                playAnimation("eating", delay:0.1, numberOfTimes: numberOfTimes)
            }
        }
        else if (animalName == (AnimalName).DONKEY) {
            if (animationType == .EATING) {
                playAnimation("eating", delay:0.1, numberOfTimes: numberOfTimes)
            }
        }
        else if (animalName == (AnimalName).RABBIT) {
            if (animationType == .EATING) {
                playAnimation("eating", delay:0.1, numberOfTimes: numberOfTimes)
            }
        }
        else if (animalName == (AnimalName).GIRAFFE) {
            if (animationType == .EATING) {
                playAnimation("eating", delay:0.1, numberOfTimes: numberOfTimes)
            }
        }
        else {
            if (animationType == .NORMAL) {
                playAnimation("bray", delay:0.1, numberOfTimes: numberOfTimes)
            }
            else if (animationType == .WALK) {
                playAnimation("walking", delay:0.1, numberOfTimes: numberOfTimes)
            }
        }
    }

    
    func makeAnimation(animationType: AnimalAnimation) {
        self.frontTexture.removeFromParent()
        
        if (animalName == (AnimalName).LION) {
            if (animationType == .NORMAL) {
                makeAnimation("lion", animation: "roar", numberOfFrames: 43, framesFormat: "02")
            }
            else if (animationType == .WALK) {
                makeAnimation("lion", animation: "walking", numberOfFrames: 15, framesFormat: "02")
            }
            else if (animationType == .EATING) {
                makeAnimation("lion", animation: "eating", numberOfFrames: 35, framesFormat: "04")
            }
        }
        else if (animalName == (AnimalName).BEAR) {
            if (animationType == .NORMAL) {
                makeAnimation("bear", animation: "sings", numberOfFrames: 64, framesFormat: "02")
            }
            else if (animationType == .WALK) {
                makeAnimation("bear", animation: "walking", numberOfFrames: 15, framesFormat: "02")
            }
        }
        else if (animalName == (AnimalName).FISH) {
            if (animationType == .NORMAL) {
                makeAnimation("fish", animation: "swim", numberOfFrames: 15, framesFormat: "02")
            }
            else if (animationType == .WALK) {
                makeAnimation("fish", animation: "walking", numberOfFrames: 15, framesFormat: "02")
            }
        }
        else if (animalName == (AnimalName).BIRD) {
            if (animationType == .NORMAL) {
                makeAnimation("bird", animation: "sings", numberOfFrames: 34, framesFormat: "02")
            }
            else if (animationType == .WALK) {
                makeAnimation("bird", animation: "walking", numberOfFrames: 10, framesFormat: "02")
            }
            else if (animationType == .EATING) {
                makeAnimation("bird", animation: "eating", numberOfFrames: 30, framesFormat: "04")
            }
        }
        else if (animalName == (AnimalName).DOG) {
            if (animationType == .NORMAL) {
                makeAnimation("dog", animation: "barking", numberOfFrames: 27, framesFormat: "02")
            }
            else if (animationType == .WALK) {
                makeAnimation("dog", animation: "walking", numberOfFrames: 15, framesFormat: "02")
            }
            else if (animationType == .EATING) {
                makeAnimation("dog", animation: "eating", numberOfFrames: 24, framesFormat: "04")
            }
        }
        else if (animalName == (AnimalName).HORSE) {
            if (animationType == .NORMAL) {
                makeAnimation("horse", animation: "neighing", numberOfFrames: 44, framesFormat: "02")
            }
            else if (animationType == .WALK) {
                makeAnimation("horse", animation: "walking", numberOfFrames: 15, framesFormat: "02")
            }
            else if (animationType == .EATING) {
                makeAnimation("horse", animation: "eating", numberOfFrames: 42, framesFormat: "04")
            }
        }
        else if (animalName == (AnimalName).SNAKE) {
            if (animationType == .NORMAL) {
                makeAnimation("snake", animation: "hiss", numberOfFrames: 49, framesFormat: "02")
            }
            else if (animationType == .WALK) {
                makeAnimation("snake", animation: "walking", numberOfFrames: 12, framesFormat: "02")
            }
        }
        else if (animalName == (AnimalName).ELEPHANT) {
            if (animationType == .NORMAL) {
                makeAnimation("elephant", animation: "roar", numberOfFrames: 59, framesFormat: "02")
            }
            else if (animationType == .WALK) {
                makeAnimation("elephant", animation: "walking", numberOfFrames: 15, framesFormat: "02")
            }
            else if (animationType == .EATING) {
                makeAnimation("elephant", animation: "eating", numberOfFrames: 48, framesFormat: "04")
            }
        }
        else if (animalName == (AnimalName).CAT) {
            if (animationType == .NORMAL) {
                makeAnimation("cat", animation: "meow", numberOfFrames: 51, framesFormat: "02")
            }
            else if (animationType == .WALK) {
                makeAnimation("cat", animation: "walking", numberOfFrames: 15, framesFormat: "02")
            }
            else if (animationType == .EATING) {
                makeAnimation("cat", animation: "eating", numberOfFrames: 39, framesFormat: "04")
            }
        }
        else if (animalName == (AnimalName).COCK) {
            if (animationType == .NORMAL) {
                makeAnimation("cock", animation: "sings", numberOfFrames: 32, framesFormat: "02")
            }
            else if (animationType == .WALK) {
                makeAnimation("cock", animation: "walking", numberOfFrames: 15, framesFormat: "02")
            }
            else if (animationType == .EATING) {
                makeAnimation("cock", animation: "eating", numberOfFrames: 42, framesFormat: "04")
            }
            
        }
        else if (animalName == (AnimalName).COW) {
            if (animationType == .NORMAL) {
                makeAnimation("cow", animation: "mugir", numberOfFrames: 44, framesFormat: "02")
            }
            else if (animationType == .WALK) {
                makeAnimation("cow", animation: "walking", numberOfFrames: 12, framesFormat: "02")
            }
            else if (animationType == .EATING) {
                makeAnimation("cow", animation: "eating", numberOfFrames: 40, framesFormat: "04")
            }

        }
        else if (animalName == (AnimalName).DOLPHIN) {
            if (animationType == .NORMAL) {
                makeAnimation("dolphin", animation: "sings", numberOfFrames: 39, framesFormat: "02")
            }
            else if (animationType == .WALK) {
                makeAnimation("dolphin", animation: "walking", numberOfFrames: 15, framesFormat: "02")
            }
            else if (animationType == .EATING) {
                makeAnimation("dolphin", animation: "eating", numberOfFrames: 20, framesFormat: "04")
            }

        }
        else if (animalName == (AnimalName).DUCK) {
            if (animationType == .NORMAL) {
                makeAnimation("duck", animation: "quacks", numberOfFrames: 39, framesFormat: "02")
            }
            else if (animationType == .WALK) {
                makeAnimation("duck", animation: "walking", numberOfFrames: 15, framesFormat: "02")
            }
        }
        else if (animalName == (AnimalName).FROG) {
            if (animationType == .NORMAL) {
                makeAnimation("frog", animation: "croak", numberOfFrames: 51, framesFormat: "02")
            }
            else if (animationType == .WALK) {
                makeAnimation("frog", animation: "walking", numberOfFrames: 15, framesFormat: "02")
            }
            else if (animationType == .EATING) {
                makeAnimation("frog", animation: "eating", numberOfFrames: 34, framesFormat: "04")
            }
            
        }
        else if (animalName == (AnimalName).MONKEY) {
            if (animationType == .NORMAL) {
                makeAnimation("monkey", animation: "squeal", numberOfFrames: 69, framesFormat: "02")
            }
            else if (animationType == .WALK) {
                makeAnimation("monkey", animation: "walking", numberOfFrames: 15, framesFormat: "02")
            }
            else if (animationType == .EATING) {
                makeAnimation("monkey", animation: "eating", numberOfFrames: 44, framesFormat: "04")
            }
        }
        else if (animalName == (AnimalName).PIG) {
            if (animationType == .NORMAL) {
                makeAnimation("pig", animation: "grunt", numberOfFrames: 39, framesFormat: "02")
            }
            else if (animationType == .WALK) {
                makeAnimation("pig", animation: "walking", numberOfFrames: 15, framesFormat: "02")
            }
            else if (animationType == .EATING) {
                makeAnimation("pig", animation: "eating", numberOfFrames: 43, framesFormat: "04")
            }
            
        }
        else if (animalName == (AnimalName).SEAL) {
            if (animationType == .NORMAL) {
                makeAnimation("seal", animation: "sings", numberOfFrames: 44, framesFormat: "02")
            }
            else if (animationType == .WALK) {
                makeAnimation("seal", animation: "walking", numberOfFrames: 12, framesFormat: "02")
            }
            else if (animationType == .EATING) {
                makeAnimation("seal", animation: "eating", numberOfFrames: 20, framesFormat: "04")
            }
        }
        else if (animalName == (AnimalName).SHEEP) {
            if (animationType == .NORMAL) {
                makeAnimation("sheep", animation: "bleat", numberOfFrames: 51, framesFormat: "02")
            }
            else if (animationType == .WALK) {
                makeAnimation("sheep", animation: "walking", numberOfFrames: 14, framesFormat: "02")
            }
            else if (animationType == .EATING) {
                makeAnimation("sheep", animation: "eating", numberOfFrames: 39, framesFormat: "04")
            }
        }
        else if (animalName == (AnimalName).WOLF) {
            if (animationType == .NORMAL) {
                makeAnimation("wolf", animation: "howl", numberOfFrames: 49, framesFormat: "02")
            }
            else if (animationType == .WALK) {
                makeAnimation("wolf", animation: "walking", numberOfFrames: 15, framesFormat: "02")
            }
            else if (animationType == .EATING) {
                makeAnimation("wolf", animation: "eating", numberOfFrames: 32, framesFormat: "04")
            }
        }
        else if (animalName == (AnimalName).ZEBRA) {
            if (animationType == .NORMAL) {
                makeAnimation("zebra", animation: "neighing", numberOfFrames: 51, framesFormat: "02")
            }
            else if (animationType == .WALK) {
                makeAnimation("zebra", animation: "walking", numberOfFrames: 15, framesFormat: "02")
            }
            else if (animationType == .EATING) {
                makeAnimation("zebra", animation: "eating", numberOfFrames: 40, framesFormat: "04")
            }
        }
        else if (animalName == (AnimalName).CAMEL) {
            if (animationType == .NORMAL) {
                makeAnimation("camel", animation: "sings", numberOfFrames: 15, framesFormat: "02")
            }
            else if (animationType == .WALK) {
                makeAnimation("camel", animation: "walking", numberOfFrames: 15, framesFormat: "02")
            }
        }
        else if (animalName == (AnimalName).MOUSE) {
            if (animationType == .EATING) {
                makeAnimation("mouse", animation: "eating", numberOfFrames: 41, framesFormat: "04")
            }
        }
        else if (animalName == (AnimalName).GOAT) {
            if (animationType == .EATING) {
                makeAnimation("goat", animation: "eating", numberOfFrames: 39, framesFormat: "04")
            }
        }
        else if (animalName == (AnimalName).DONKEY) {
            if (animationType == .NORMAL) {
                makeAnimation("donkey", animation: "bray", numberOfFrames: 53, framesFormat: "02")
            }
            else if (animationType == .WALK) {
                makeAnimation("donkey", animation: "walking", numberOfFrames: 15, framesFormat: "02")
            }
            else if (animationType == .EATING) {
                makeAnimation("donkey", animation: "eating", numberOfFrames: 43, framesFormat: "04")
            }
            
        }
        else if (animalName == (AnimalName).RABBIT) {
            if (animationType == .EATING) {
                makeAnimation("rabbit", animation: "eating", numberOfFrames: 43, framesFormat: "04")
            }
            
        }
        else if (animalName == (AnimalName).GIRAFFE) {
            if (animationType == .EATING) {
                makeAnimation("giraffe", animation: "eating", numberOfFrames: 38, framesFormat: "04")
            }
            
        }
        else {
            if (animationType == .NORMAL) {
                makeAnimation("donkey", animation: "bray", numberOfFrames: 53, framesFormat: "02")
            }
            else if (animationType == .WALK) {
                makeAnimation("donkey", animation: "walking", numberOfFrames: 15, framesFormat: "02")
            }
            else if (animationType == .EATING) {
                makeAnimation("donkey", animation: "eating", numberOfFrames: 43, framesFormat: "04")
            }
        }
        
        addChild(frontTexture)
    }
    
    

}
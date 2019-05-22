//
//  Habitat.swift
//  calu
//
//  Created by Gonçalo Rodrigues on 05/10/14.
//  Copyright (c) 2014 Funzoi. All rights reserved.
//

import SpriteKit

enum HabitatName: Int {
    case SEA = 1, DECKHOUSE, CAPOEIRA, STABLE, LAKE, DESERT, SAVANNAH, NEST, BASKET_CAT, MEADOW,
    PIGSTY, FOREST
}

class Habitat: SKSpriteNode {
    
    var habitatName:HabitatName
    var habitatNameString:NSString
    var sizeAnimal:CGSize
    var positionAnimal:CGPoint?
    
    let frontTexture :SKSpriteNode?
    var validAnimals : [AnimalName]?
    var animation: SKUAnimatedNode?
    var animations: NSMutableDictionary?
        
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(name: HabitatName) {
        sizeAnimal = convertSizeToPhone(CGSizeMake(244, 188))
        habitatName = name
        habitatNameString = "habitat"
        validAnimals = []
        animations = NSMutableDictionary()
        frontTexture = nil
        super.init(texture: nil, color: UIColor.clearColor(), size: sizeAnimal)
        setHabitat(name)
    }
    
    
    func setHabitat(name: HabitatName) {
        switch(name) {
        case .SEA:
            habitatNameString = "sea"
            validAnimals = [.SEAL, .FISH, .DOLPHIN]
            animation = SKUAnimatedNode(animate: "dolphin", animation: "habitat", size: CGSizeMake(234, 178))
            animation?.makeAnimation("dolphin", animation: "habitat", numberOfFrames: 29, framesFormat: "04")
            animations?.setValue(animation, forKey: "dolphin")
            animation?.alpha = 0
            addChild(animation!)
            
            animation = SKUAnimatedNode(animate: "seal", animation: "habitat", size: CGSizeMake(234, 178))
            animation?.makeAnimation("seal", animation: "habitat", numberOfFrames: 30, framesFormat: "04")
            animations?.setValue(animation, forKey: "seal")
            animation?.alpha = 0
            addChild(animation!)
            
            animation = SKUAnimatedNode(animate: "fish", animation: "habitat", size: CGSizeMake(234, 178))
            animation?.makeAnimation("fish", animation: "habitat", numberOfFrames: 123, framesFormat: "04")
            animations?.setValue(animation, forKey: "fish")
            animation?.alpha = 0
            addChild(animation!)

            break
        //casota
        case .DECKHOUSE:
            habitatNameString = "deckhouse"
            validAnimals = [.DOG]
            animation = SKUAnimatedNode(animate: "dog", animation: "habitat", size: CGSizeMake(234, 178))
            animation?.makeAnimation("dog", animation: "habitat", numberOfFrames: 24, framesFormat: "04")
            animations?.setValue(animation, forKey: "dog")
            animation?.alpha = 0
            addChild(animation!)
            break
        case .CAPOEIRA:
            habitatNameString = "capoeira"
            validAnimals = [.COCK]
            animation = SKUAnimatedNode(animate: "cock", animation: "sings", size: CGSizeMake(244, 188))
            animation?.makeAnimation("cock", animation: "sings", numberOfFrames: 32, framesFormat: "02")
            animations?.setValue(animation, forKey: "cock")
            animation?.alpha = 0
            addChild(animation!)
            //TODO: Add bg on cock
            
            break
        case .STABLE:
            habitatNameString = "stable"
            validAnimals = [.HORSE]
            
            animation = SKUAnimatedNode(animate: "horse", animation: "habitat", size: CGSizeMake(244, 188))
            animation?.makeAnimation("horse", animation: "habitat", numberOfFrames: 26, framesFormat: "04")
            animations?.setValue(animation, forKey: "horse")
            animation?.alpha = 0
            addChild(animation!)
            
            break
        case .LAKE:
            habitatNameString = "lake"
            validAnimals = [.DUCK, .FROG]
            animation = SKUAnimatedNode(animate: "duck", animation: "habitat", size: CGSizeMake(244, 188))
            animation?.makeAnimation("duck", animation: "habitat", numberOfFrames: 50, framesFormat: "04")
            animations?.setValue(animation, forKey: "duck")
            animation?.alpha = 0
            addChild(animation!)
            
            animation = SKUAnimatedNode(animate: "frog", animation: "croak", size: CGSizeMake(244, 188))
            animation?.makeAnimation("frog", animation: "croak", numberOfFrames: 51, framesFormat: "02")
            animations?.setValue(animation, forKey: "frog")
            animation?.alpha = 0
            addChild(animation!)
            
            break
        case .DESERT:
            habitatNameString = "desert"
            validAnimals = [.CAMEL]
            
            animation = SKUAnimatedNode(animate: "camel", animation: "habitat", size: CGSizeMake(244, 188))
            animation?.makeAnimation("camel", animation: "habitat", numberOfFrames: 70, framesFormat: "04")
            animations?.setValue(animation, forKey: "camel")
            animation?.alpha = 0
            addChild(animation!)
            
            break
        case .SAVANNAH:
            habitatNameString = "savannah"
            validAnimals = [.LION, .ELEPHANT, .ZEBRA]
            
            animation = SKUAnimatedNode(animate: "lion", animation: "croak", size: CGSizeMake(244, 188))
            animation?.makeAnimation("lion", animation: "roar", numberOfFrames: 49, framesFormat: "02")
            animations?.setValue(animation, forKey: "lion")
            animation?.alpha = 0
            addChild(animation!)
            
            animation = SKUAnimatedNode(animate: "elephant", animation: "roar", size: CGSizeMake(244, 188))
            animation?.makeAnimation("elephant", animation: "roar", numberOfFrames: 59, framesFormat: "02")
            animations?.setValue(animation, forKey: "elephant")
            animation?.alpha = 0
            addChild(animation!)
            
            animation = SKUAnimatedNode(animate: "zebra", animation: "neighing", size: CGSizeMake(244, 188))
            animation?.makeAnimation("zebra", animation: "neighing", numberOfFrames: 51, framesFormat: "02")
            animations?.setValue(animation, forKey: "zebra")
            animation?.alpha = 0
            addChild(animation!)
            
            break
        case .NEST:
            habitatNameString = "nest"
            validAnimals = [.BIRD]
            animation = SKUAnimatedNode(animate: "bird", animation: "sings", size: CGSizeMake(244, 188))
            animation?.makeAnimation("bird", animation: "sings", numberOfFrames: 32, framesFormat: "02")
            animations?.setValue(animation, forKey: "bird")
            animation?.alpha = 0
            addChild(animation!)
            //TODO: Add bg on donkey
            
            break
        case .BASKET_CAT:
            habitatNameString = "basket_cat"
            validAnimals = [.CAT]
            animation = SKUAnimatedNode(animate: "cat", animation: "habitat", size: CGSizeMake(234, 178))
            animation?.makeAnimation("cat", animation: "habitat", numberOfFrames: 60, framesFormat: "04")
            animations?.setValue(animation, forKey: "cat")
            animation?.alpha = 0
            addChild(animation!)
            break
        case .MEADOW:
            habitatNameString = "meadow"
            validAnimals = [.COW, .DONKEY, .SHEEP]
            animation = SKUAnimatedNode(animate: "sheep", animation: "habitat", size: CGSizeMake(244, 188))
            animation?.makeAnimation("sheep", animation: "habitat", numberOfFrames: 78, framesFormat: "04")
            animations?.setValue(animation, forKey: "sheep")
            animation?.alpha = 0
            addChild(animation!)
            
            animation = SKUAnimatedNode(animate: "cow", animation: "mugir", size: CGSizeMake(244, 188))
            animation?.makeAnimation("cow", animation: "mugir", numberOfFrames: 44, framesFormat: "02")
            animations?.setValue(animation, forKey: "cow")
            animation?.alpha = 0
            addChild(animation!)
            //TODO: Add bg on cow
            
            animation = SKUAnimatedNode(animate: "donkey", animation: "bray", size: CGSizeMake(244, 188))
            animation?.makeAnimation("donkey", animation: "bray", numberOfFrames: 53, framesFormat: "02")
            animations?.setValue(animation, forKey: "donkey")
            animation?.alpha = 0
            addChild(animation!)
            //TODO: Add bg on donkey
            
            break
        case .PIGSTY:
            habitatNameString = "pigsty"
            validAnimals = [.PIG]
            animation = SKUAnimatedNode(animate: "pig", animation: "habitat", size: CGSizeMake(234, 178))
            animation?.makeAnimation("pig", animation: "habitat", numberOfFrames: 34, framesFormat: "04")
            animations?.setValue(animation, forKey: "pig")
            animation?.alpha = 0
            addChild(animation!)
            break
        case .FOREST:
            habitatNameString = "forest"
            validAnimals = [.BEAR, .MONKEY, .WOLF, .SNAKE]
            animation = SKUAnimatedNode(animate: "snake", animation: "habitat", size: CGSizeMake(234, 178))
            animation?.makeAnimation("snake", animation: "habitat", numberOfFrames: 50, framesFormat: "04")
            animations?.setValue(animation, forKey: "snake")
            animation?.alpha = 0
            addChild(animation!)
            
            animation = SKUAnimatedNode(animate: "wolf", animation: "howl", size: CGSizeMake(244, 188))
            animation?.makeAnimation("wolf", animation: "howl", numberOfFrames: 49, framesFormat: "02")
            animations?.setValue(animation, forKey: "wolf")
            animation?.alpha = 0
            addChild(animation!)
            
            animation = SKUAnimatedNode(animate: "monkey", animation: "squeal", size: CGSizeMake(244, 188))
            animation?.makeAnimation("monkey", animation: "squeal", numberOfFrames: 69, framesFormat: "02")
            animations?.setValue(animation, forKey: "monkey")
            animation?.alpha = 0
            addChild(animation!)
            
            animation = SKUAnimatedNode(animate: "bear", animation: "sings", size: CGSizeMake(244, 188))
            animation?.makeAnimation("bear", animation: "sings", numberOfFrames: 64, framesFormat: "02")
            animations?.setValue(animation, forKey: "bear")
            animation?.alpha = 0
            addChild(animation!)
            break
        default:
            habitatNameString = "habitat"
        }
        
        super.texture = SKSpriteNode(imageNamed: habitatNameString as String).texture
    }
    
    func playAnimation(animationType: AnimalAnimation, numberOfTimes: Int) {
        animation?.playAnimation("habitat", delay: 0.1, numberOfTimes: 1)
    }
    
    deinit {
//        super.deinit
        NSLog("Habitat Node deinit")
    }
}
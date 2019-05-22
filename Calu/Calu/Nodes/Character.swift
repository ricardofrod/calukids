//
//  Character.swift
//  calu
//
//  Created by Gonçalo Rodrigues on 14/11/14.
//  Copyright (c) 2014 Funzoi. All rights reserved.
//

import Foundation


class Character: SKUAnimatedNode {
    
    enum CharacterName: Int {
        case CA = 1, LU
    }
    
    enum CharacterAnimation: Int {
        case OK = 1,
        SMILE,
        SAD
    }
    
    var characterName: CharacterName
    var nameString: NSString?
    var animationDefault: NSString?
    
    
    required init(coder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    init(name: CharacterName) {
        characterName = name
        var nameString : NSString
        switch(name) {
            case .CA:
                nameString = "ca"
                animationDefault = "smile"
                break
            case .LU:
                nameString = "lu"
                animationDefault = "smile"
                break
            default:
                nameString = "ca"
                animationDefault = "smile"
                break
        }
        super.init(animate: nameString, animation: animationDefault, size: CGSizeMake(1024, 768))
    }
    
    func makeAnimation(animationType: CharacterAnimation) {
        if (characterName == (CharacterName).CA) {
            if (animationType == .SMILE) {
                makeAnimation("ca", animation: "smile", numberOfFrames: 29, framesFormat: "02")
            }
//            else if (animationType == .NORMAL) {
//                makeAnimation("ca", animation: "walking", numberOfFrames: 15)
//            }
            else if (animationType == .SAD) {
                makeAnimation("ca", animation: "sad", numberOfFrames: 29, framesFormat: "02")
            }
        }
        else if (characterName == (CharacterName).LU) {
            if (animationType == .SMILE) {
                makeAnimation("lu", animation: "smile", numberOfFrames: 28, framesFormat: "02")
            }
            else if (animationType == .OK) {
                makeAnimation("lu", animation: "ok", numberOfFrames: 39, framesFormat: "02")
            }
            else if (animationType == .SAD) {
                makeAnimation("lu", animation: "sad", numberOfFrames: 35, framesFormat: "02")
            }
        }
    }


}
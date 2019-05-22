//
//  Food.swift
//  Calu Basic
//
//  Created by Ricardo Rodrigues on 26/05/17.
//  Copyright © 2017 Ricardo Rodrigues. All rights reserved.
//

import SpriteKit
import GameplayKit


class Food {
    
    var imageNameF : String
    var textureImageF : SKTexture
    
    init (imageNameF: String, textureImageF: SKTexture){
        self.imageNameF = imageNameF
        self.textureImageF = textureImageF
        
    }
    
    func getName() -> String{
        return self.imageNameF
    }
    func getTexture() -> SKTexture{
        return self.textureImageF
    }
    
}

var banana = Food(imageNameF: "banana", textureImageF: SKTexture(imageNamed: "banana"))
var carrot = Food(imageNameF: "carrot", textureImageF: SKTexture(imageNamed: "carrot"))
var corn = Food(imageNameF: "corn", textureImageF: SKTexture(imageNamed: "corn"))

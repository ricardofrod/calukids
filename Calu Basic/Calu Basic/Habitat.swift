//
//  Habitat.swift
//  Calu Basic
//
//  Created by Ricardo Rodrigues on 26/05/17.
//  Copyright © 2017 Ricardo Rodrigues. All rights reserved.
//

import SpriteKit
import GameplayKit


class Habitat {
    
    var imageHabitat : String
    var textureHabitat : SKTexture
    
    init (imageHabitat: String, textureHabitat: SKTexture){
        self.imageHabitat = imageHabitat
        self.textureHabitat = textureHabitat
        
    }
    
    
    func getName() -> String{
        return self.imageHabitat
    }
    func getTexture() -> SKTexture{
        return self.textureHabitat
    }
    
}

var chickenHouse = Habitat(imageHabitat: "chicken_house", textureHabitat: SKTexture(imageNamed: "chicken_house"))
var stable = Habitat(imageHabitat: "stable", textureHabitat: SKTexture(imageNamed: "stable"))
var tree = Habitat(imageHabitat: "tree", textureHabitat: SKTexture(imageNamed: "tree"))

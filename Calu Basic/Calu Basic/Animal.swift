//
//  Animal.swift
//  Calu Basic
//
//  Created by Ricardo Rodrigues on 26/05/17.
//  Copyright © 2017 Ricardo Rodrigues. All rights reserved.
//

import SpriteKit
import GameplayKit
import AVFoundation



class Animal {
    
    var imageName : String
    var textureImage : SKTexture
    var foodAnimal : Food
    var habitatAnimal : Habitat
    var type : String
    
    init (imageName: String, textureImage: SKTexture, foodAnimal: Food, habitatAnimal: Habitat, type: String){
        self.imageName = imageName
        self.textureImage = textureImage
        self.foodAnimal = foodAnimal
        self.habitatAnimal = habitatAnimal
        self.type = type
        
    }
    
    
    func getName() -> String{
        return self.imageName
    }
    func getTexture() -> SKTexture{
        return self.textureImage
    }
    func getFoodAnimal() -> Food{
        return self.foodAnimal
    }
    func gethabitatAnimal() -> Habitat{
        return self.habitatAnimal
    }
    func getType() -> String{
        return self.type
    }
    
    
}


var cock = Animal(imageName: "domestic_cock", textureImage: SKTexture(imageNamed: "domestic_cock"), foodAnimal: corn, habitatAnimal: chickenHouse, type: "domestic")

var horse = Animal(imageName: "domestic_horse", textureImage: SKTexture(imageNamed: "domestic_horse"), foodAnimal: carrot, habitatAnimal: stable, type: "domestic")

var monkey = Animal(imageName: "wild_monkey", textureImage: SKTexture(imageNamed: "wild_monkey"), foodAnimal: banana, habitatAnimal: tree, type: "wild")




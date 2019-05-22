//
//  ForParents.swift
//  Calu Basic
//
//  Created by Ricardo Rodrigues on 26/05/17.
//  Copyright © 2017 Ricardo Rodrigues. All rights reserved.
//

import SpriteKit
import GameplayKit
import AVFoundation
import UIKit
import CoreData


class ForParents: SKScene {
    var backsprite = SKSpriteNode(imageNamed: "backbtn")
    var purchase = SKSpriteNode(imageNamed: "btn_purchase")
    var myLabel:SKLabelNode!
    var Ximage = CGFloat()
    var Yimage = CGFloat()
    
    let finger = UISwipeGestureRecognizer()

    var textView = UITextView()
    
    
    /*var resetbutton = SKSpriteNode(imageNamed: "btn_reset")
     var timerbutton = SKSpriteNode(imageNamed: "btn_timer")*/
    //var ViewForParents = UIView()
    
    
    
    override func didMove(to view: SKView) {
        view.showsFPS = false
        view.showsNodeCount = false
        UIApplication.shared.isIdleTimerDisabled = true
        
        
        purchase.position = CGPoint(x: (view.scene?.size.width)! * (0.43), y: (view.scene?.size.height)! * (0.41))
        purchase.size = CGSize(width: purchase.size.width, height: purchase.size.height)
        purchase.zPosition = 1
        self.addChild(purchase)
        
        let textNode = self.childNode(withName: "TextNode")
        
        let textViewPosition = CGRect(x: (self.frame.size.width / 2) + (textNode?.frame.origin.x)!, y: ((self.frame.size.height / 2) + (textNode?.frame.origin.y)!) + 110, width: (textNode?.frame.size.width)!, height: (textNode?.frame.size.height)! - 20)
        textView = UITextView(frame: textViewPosition)
        textView.font = UIFont(name: "QuicksandBook-Regular", size: 18)
        
        let boldCalu = "CALU KIDS ANIMALS - SOUNDS, FOOD AND HABITATS"
        
        let text1 = "WAS CAREFULLY DEVELOPED, WITH A HIGH LEVEL OF ACCURACY AND ATTENTION TO DETAIL, BY A SPEECH THERAPIST AND A MOTHER, IN ORDER NOT ONLY TO PLAY BUT TO ACQUIRE AND DEVELOP YOUR CHILD’S SPEAKING AND LISTENING SKILLS.\n\n\n"
        
        let boldWhy = "WHY ANIMALS?\n\n\n"
        
        let text2 = "THE SOUND OF ANIMALS IS ONE OF THE CHILD'S FIRST LANGUAGE ACQUISITIONS AND THERE IS ALWAYS A GREAT EMPATHY BETWEEN CHILDREN AND ANIMALS! WITH CALU KIDS ANIMALS - SOUNDS, FOOD AND HABITATS CHILDREN WILL LEARN THE SOUNDS OF ANIMALS, WHERE THEY LIVE AND WHAT THEY EAT! WHILE THEY PLAY AND LEARN, THE ALWAYS CHEERFUL CA AND LU WILL GIVE THEM POSITIVE REINFORCEMENTS AND INCENTIVES!\n\n"
        
        let boldPlay = "HOW TO PLAY\n\n"
        
        let text3 = "\nCALU KIDS APPS ARE ALL KIDS AND PARENTS FRIENDLY. THAT'S WHY WE HAVE CREATED TWO SPECIAL FEATURES. TIMER AND RESET BUTTON.\n"
        
        let boldReset = "\nTHE RESET BUTTON\n\n"
        
        let ImageReset = NSTextAttachment()
        ImageReset.image = UIImage(named: "btn_reset")
        let iconsSize = CGSize(width: ((ImageReset.image?.size.width)! / 3), height: (ImageReset.image?.size.height)! / 3)
        ImageReset.bounds.size = iconsSize
        let image1String = NSAttributedString(attachment: ImageReset)
        
        
        let text4 = "\n\n\nWILL DELETE THE ENTIRE HISTORY OF THE LAST USER OF THE APP, MAKING THE APP READY FOR A NEW PLAYER.\n"
        
        let boldTimer = "\nTHE TIMER BUTTON\n\n"
        
        let ImageTimer = NSTextAttachment()
        ImageTimer.image = UIImage(named: "btn_timer")
        ImageTimer.bounds.size = iconsSize
        let image2String = NSAttributedString(attachment: ImageTimer)
        
        let text5 = "\n\n\nWILL HELP YOU DECIDE HOW MANY TIME YOU WANT YOUR CHILD EXPLORING CA&LU. IT ALLOWS PARENTS TO HAVE BETTER CONTROL OVER USAGE TIME, THUS ENABLING A SAFE USE OF CALUKIDS ANIMALS. THE APP WILL CLOSE WHEN THE TIME RUNS OUT\n\n IN THE MENU OF CALU KIDS - ANIMALS, WE FIND A MONKEY IN THE TREE, A ROOSTER ON TOP OF THE HEN HOUSE AND A MOUSE EATING HIS CHEESE! EACH ANIMAL CORRESPONDS TO A SPECIFIC GAME! THE MONKEY CORRESPONDS TO THE SOUNDS GAME, THE ROOSTER TO THE HABITATS GAME AND THE MOUSE TO THE FOOD GAME.\n\n THE SOUNDS GAME CONSISTS OF 20 ANIMALS, 10 DOMESTIC AND 10 WILD.\n\n"
        
        let ImageDomestic = NSTextAttachment()
        ImageDomestic.image = UIImage(named: "btn_domestic")
        let iconsSizeButton = CGSize(width: ((ImageDomestic.image?.size.width)! / 2), height: (ImageDomestic.image?.size.height)! / 2)
        ImageDomestic.bounds.size = iconsSizeButton
        let image3String = NSAttributedString(attachment: ImageDomestic)
        
        let ImageWild = NSTextAttachment()
        ImageWild.image = UIImage(named: "btn_wild")
        ImageWild.bounds.size = iconsSizeButton
        let image4String = NSAttributedString(attachment: ImageWild)
        
        let text6 = "\n\n\nTHE CHILD CAN DISCOVER ALL REAL ANIMAL SOUNDS WITH A SIMPLE AND EASILY UNDERSTANDABLE ANIMATION.\n\n"
        
        let ImagePDomestic = NSTextAttachment()
        ImagePDomestic.image = UIImage(named: "btn_domestic_photo")
        ImagePDomestic.bounds.size = iconsSizeButton
        let image5String = NSAttributedString(attachment: ImagePDomestic)
        
        let ImagePWild = NSTextAttachment()
        ImagePWild.image = UIImage(named: "btn_wild_photo")
        ImagePWild.bounds.size = iconsSizeButton
        let image6String = NSAttributedString(attachment: ImagePWild)
        
        let text7 = "\n\n\nTHE ANIMAL'S SOUND IS ACCOMPANIED BY ITS REAL IMAGE.\n\n"
        
        let ImageSound = NSTextAttachment()
        ImageSound.image = UIImage(named: "btn_sound")
        ImageSound.bounds.size = iconsSizeButton
        let image7String = NSAttributedString(attachment: ImageSound)
        
        let text8 = "\n\nHERE THE CHILD IS ASKED TO IDENTIFY THE ANIMAL AFTER HEARING THE SOUND.\n\n\n THE HABITATS GAME CONSISTS OF 22 ANIMALS AND 12 HABITATS. THE PURPOSE OF THE GAME IS TO GUIDE EACH ANIMAL TO ITS HABITAT.\n\n\n FINALLY, WE HAVE THE FOOD GAME, CONSISTING OF 21 ANIMALS AND 14 DIFFERENT TYPES OF FOODS. THE CHILD WILL HAVE TO FEED EACH ANIMAL, MATCHING THE CORRECT FOOD.\n\n\n DID YOU LIKE IT? SO, GIVE US A POSITIVE REVIEW ON THE APP STORE! CA AND LU WOULD BE VERY HAPPY!\n"
        
        let boldMiss = "\nDO NOT MISS WHAT CA AND LU ARE PREPARING!"
        
        
        let textBold = (boldCalu as NSString).range(of: boldCalu)
        let textBoldWhy = (boldWhy as NSString).range(of: boldWhy)
        let textBoldPlay = (boldPlay as NSString).range(of: boldPlay)
        let textBoldReset = (boldReset as NSString).range(of: boldReset)
        let textBoldTimer = (boldTimer as NSString).range(of: boldTimer)
        let textBoldMiss = (boldMiss as NSString).range(of: boldMiss)
        
        
        let attribute = NSMutableAttributedString()
        
        
        
        attribute.append(NSAttributedString(string: boldCalu, attributes: [NSFontAttributeName: UIFont(name: "QuicksandBold-Regular", size: 18)!]))
        attribute.append(NSAttributedString(string: text1, attributes: [NSFontAttributeName: UIFont(name: "QuicksandBook-Regular", size: 18)!]))
        attribute.append(NSAttributedString(string: boldWhy, attributes: [NSFontAttributeName: UIFont(name: "QuicksandBold-Regular", size: 18)!]))
        attribute.append(NSAttributedString(string: text2, attributes: [NSFontAttributeName: UIFont(name: "QuicksandBook-Regular", size: 18)!]))
        attribute.append(NSAttributedString(string: boldPlay, attributes: [NSFontAttributeName: UIFont(name: "QuicksandBold-Regular", size: 18)!]))
        attribute.append(NSAttributedString(string: text3, attributes: [NSFontAttributeName: UIFont(name: "QuicksandBook-Regular", size: 18)!]))
        attribute.append(NSAttributedString(string: boldReset, attributes: [NSFontAttributeName: UIFont(name: "QuicksandBold-Regular", size: 18)!]))
        attribute.append(image1String)
        attribute.append(NSAttributedString(string: text4, attributes: [NSFontAttributeName: UIFont(name: "QuicksandBook-Regular", size: 18)!]))
        attribute.append(NSAttributedString(string: boldTimer, attributes: [NSFontAttributeName: UIFont(name: "QuicksandBold-Regular", size: 18)!]))
        attribute.append(image2String)
        attribute.append(NSAttributedString(string: text5, attributes: [NSFontAttributeName: UIFont(name: "QuicksandBook-Regular", size: 18)!]))
        attribute.append(image3String)
        attribute.append(image4String)
        attribute.append(NSAttributedString(string: text6, attributes: [NSFontAttributeName: UIFont(name: "QuicksandBook-Regular", size: 18)!]))
        attribute.append(image5String)
        attribute.append(image6String)
        attribute.append(NSAttributedString(string: text7, attributes: [NSFontAttributeName: UIFont(name: "QuicksandBook-Regular", size: 18)!]))
        attribute.append(image7String)
        attribute.append(NSAttributedString(string: text8, attributes: [NSFontAttributeName: UIFont(name: "QuicksandBook-Regular", size: 18)!]))
        attribute.append(NSAttributedString(string: boldMiss, attributes: [NSFontAttributeName: UIFont(name: "QuicksandBold-Regular", size: 18)!]))
        
        
        
        textView.attributedText = attribute
        textView.isEditable = false
        textView.isSelectable = false
        textView.textAlignment = .center

        textView.textColor = UIColor.white
        textView.backgroundColor = UIColor .clear
        
        
        
        
        
        
        self.scene?.view?.addSubview(textView)
        
        
        
        
        //adicionar back button
        addgoback()
        
    }

    func addgoback(){
        backsprite.position=CGPoint(x: (view?.scene?.size.width)! * (-0.42), y: (view?.scene?.size.height)! * 0.42)
        backsprite.size=CGSize(width: (view?.scene?.size.width)! * 0.09, height: (view?.scene?.size.height)! * 0.11)
        backsprite.zPosition = 1
        self.addChild(backsprite)
    }
    func goBack()
    {
        let changemenu = MenuScene(fileNamed: "MenuScene")
        
        self.scene?.view?.presentScene(changemenu!, transition: SKTransition.reveal(with: SKTransitionDirection.down, duration: 0.5))
    }
    
    func purchaseButton(sender: UISwipeGestureRecognizer){
        
        if(sender.direction == .down) {
            print("Swipe")
            
            // code for buy full version
            
            
        }
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let historybtn = self.childNode(withName: "historybutton")
        let timerbtn = self.childNode(withName: "timerbutton")
        
        
        for touch: AnyObject in touches {
            let location = (touch as! UITouch).location(in: self)
            let touchedNode = self.atPoint(location)
            
            if touchedNode == backsprite {
                goBack()
                textView.removeFromSuperview()
                
                
            } else if (touchedNode == historybtn){
                
                textView.removeFromSuperview()
                
                
            } else if (touchedNode == timerbtn){
                textView.removeFromSuperview()
                
            }else if(touchedNode == purchase){
                
                finger.direction = .down
                finger.addTarget(self, action: #selector(self.purchaseButton(sender:)))
                self.view?.addGestureRecognizer(finger)
                
                
            }
        }
    }
    
}

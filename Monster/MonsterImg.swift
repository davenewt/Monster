//
//  MonsterImg.swift
//  Monster
//
//  Created by David Stroud on 09/02/2016.
//  Copyright © 2016 David Stroud. All rights reserved.
//

import Foundation
import UIKit

class MonsterImg: UIImageView {
    
    //required stuff, don't really understand this yet!
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        playIdleAnimation()
    }
    
    func playIdleAnimation() {
        
        // set default image
        self.image = UIImage(named: "idle1.png")
        // clear out the animationImages first, before appending new ones, to avoid unexpected results
        self.animationImages = nil
        
        // set up animation frames for monster
        var imgArray = [UIImage]()
        for var x = 1; x <= 4; x++ {
            let img = UIImage(named: "idle\(x).png")
            imgArray.append(img!)
        }
        self.animationImages = imgArray
        self.animationDuration = 0.8
        self.animationRepeatCount = 0 // don't stop animating!
        self.startAnimating()
    }
    
    func playDeathAnimation() {
        
        // set default image
        self.image = UIImage(named: "dead5.png")
        // clear out the animationImages first, before appending new ones, to avoid unexpected results
        self.animationImages = nil
        
        var imgArray = [UIImage]()
        for var x = 1; x <= 5; x++ {
            let img = UIImage(named: "dead\(x).png")
            imgArray.append(img!)
        }
        self.animationImages = imgArray
        self.animationDuration = 0.8
        self.animationRepeatCount = 1 // don't stop animating!
        self.startAnimating()
    }
    
    
}
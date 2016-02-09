//
//  ViewController.swift
//  Monster
//
//  Created by David Stroud on 08/02/2016.
//  Copyright © 2016 David Stroud. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var monsterImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set up animation frames for monster
        var imgArray = [UIImage]()
        for var x = 1; x <= 4; x++ {
            let img = UIImage(named: "idle\(x).png")
            imgArray.append(img!)
        }
        monsterImg.animationImages = imgArray
        monsterImg.animationDuration = 0.8
        monsterImg.animationRepeatCount = 0 // don't stop animating!
        monsterImg.startAnimating()
        
    }




}


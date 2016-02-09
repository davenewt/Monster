//
//  ViewController.swift
//  Monster
//
//  Created by David Stroud on 08/02/2016.
//  Copyright © 2016 David Stroud. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var monsterImg: MonsterImg!
    @IBOutlet weak var foodImg: DragImg!
    @IBOutlet weak var heartImg: DragImg!
    
    @IBOutlet weak var penalty1Img: UIImageView!
    @IBOutlet weak var penalty2Img: UIImageView!
    @IBOutlet weak var penalty3Img: UIImageView!
    
    // ALL CAPS names lets us know these are constants
    let DIM_ALPHA: CGFloat = 0.2
    let OPAQUE: CGFloat = 1.0
    let MAX_PENALTIES = 3
    
    var penalties = 0
    var timer: NSTimer! // using ! because we know for sure there will always be a value assigned, otherwise things will crash!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        foodImg.dropTarget = monsterImg
        heartImg.dropTarget = monsterImg
        
        penalty1Img.alpha = DIM_ALPHA
        penalty2Img.alpha = DIM_ALPHA
        penalty3Img.alpha = DIM_ALPHA
        
                                                                         // remember the colon \/ needed in this context, if your function needs parameters. Calls the below defined func
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "itemDroppedOnCharacter:", name: "onTargetDropped", object: nil)
        
        startTimer()
        
        
    }

    func itemDroppedOnCharacter(notif: AnyObject) { // we're not going to use this object, so we don't need to worry about it
        print("Item dropped on character!")
    }
    
    func startTimer() {
        if timer != nil {
            timer.invalidate() // before we start a new timer, stop the existing one. safety measure.
        }
        
        timer = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: "changeGameState", userInfo: nil, repeats: true)
        
    }

    func changeGameState() {
        
        penalties++
        
        if penalties == 1 {
            penalty1Img.alpha = OPAQUE
            penalty2Img.alpha = DIM_ALPHA
        } else if penalties == 2 {
            penalty2Img.alpha = OPAQUE
            penalty3Img.alpha = DIM_ALPHA
        } else if penalties == 3 {
            penalty3Img.alpha = OPAQUE
        } else {
            penalty1Img.alpha = DIM_ALPHA
            penalty2Img.alpha = DIM_ALPHA
            penalty3Img.alpha = DIM_ALPHA
        }
        
        if penalties >= MAX_PENALTIES {
            gameOver()
        }
        
    }
    
    func gameOver() {
        timer.invalidate() // we don't want the timer to go any more!
        monsterImg.playDeathAnimation()
    }

}











//
//  ViewController.swift
//  Monster
//
//  Created by David Stroud on 08/02/2016.
//  Copyright © 2016 David Stroud. All rights reserved.
//

import UIKit
import AVFoundation

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
    var monsterHappy: Bool = false
    var currentItem: UInt32 = 0
    var monsterAlive: Bool = true
    
    var musicPlayer: AVAudioPlayer!
    var sfxBite: AVAudioPlayer!
    var sfxHeart: AVAudioPlayer!
    var sfxDeath: AVAudioPlayer!
    var sfxSkull: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        foodImg.dropTarget = monsterImg
        heartImg.dropTarget = monsterImg
        
        penalty1Img.alpha = DIM_ALPHA
        penalty2Img.alpha = DIM_ALPHA
        penalty3Img.alpha = DIM_ALPHA
        
                                                                         // remember the colon \/ needed in this context, if your function needs parameters. Calls the below defined func
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "itemDroppedOnCharacter:", name: "onTargetDropped", object: nil)
        
        do {
            try musicPlayer = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("cave-music", ofType: "mp3")!))
            try sfxBite = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("bite", ofType: "wav")!))
            try sfxHeart = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("heart", ofType: "wav")!))
            try sfxDeath = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("death", ofType: "wav")!))
            try sfxSkull = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("skull", ofType: "wav")!))
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        musicPlayer.prepareToPlay()
        sfxBite.prepareToPlay()
        sfxHeart.prepareToPlay()
        sfxDeath.prepareToPlay()
        sfxSkull.prepareToPlay()
        
        if monsterAlive {
            startGame()
        } else {
            print("Monster is DEAD. Not gonna do anything!")
        }
        
    }

    func startGame() {
        startTimer()
        musicPlayer.play()
    }
    
    func itemDroppedOnCharacter(notif: AnyObject) { // we're not going to use this object, so we don't need to worry about it
        print("Item dropped...")
        
        // only do stuff if the monster is alive!
        if monsterAlive {
            print("Monster is alive, so now he's happy")
            monsterHappy = true
            startTimer()
            foodImg.alpha = DIM_ALPHA
            heartImg.alpha = DIM_ALPHA
            foodImg.userInteractionEnabled = false
            heartImg.userInteractionEnabled = false
            
            if currentItem == 0 {
                sfxHeart.play()
            } else {
                sfxBite.play()
            }
        } else {
            // monster is dead!
            print("Trying to tend to a dead monster! You're too late!")
            gameOver()
        }
    }
    
    func startTimer() {
        if timer != nil {
            timer.invalidate() // before we start a new timer, stop the existing one. safety measure.
        }
        
        timer = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: "changeGameState", userInfo: nil, repeats: true)
        //print("Timer started")
    }

    func endTimer() {
        if timer != nil {
            timer.invalidate() // before we start a new timer, stop the existing one. safety measure.
            //print("Timer stopped")
        }
    }
    
    func changeGameState() {
        
        if monsterAlive { // we only really want to do stuff if the monster is still alive, right?
            
            if !monsterHappy {
                
                print("Monster is dying...")
                penalties++
                sfxSkull.play()
                
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
            
            let rand = arc4random_uniform(2) // 0 or 1
            
            if rand == 0 {
                // let's say 0 is the heart, so dim the food icon
                foodImg.alpha = DIM_ALPHA
                foodImg.userInteractionEnabled = false
                heartImg.alpha = OPAQUE
                heartImg.userInteractionEnabled = true
            } else {
                heartImg.alpha = DIM_ALPHA
                heartImg.userInteractionEnabled = false
                foodImg.alpha = OPAQUE
                foodImg.userInteractionEnabled = true
            }
            
            currentItem = rand
            monsterHappy = false
            
        } else {
            
            print("Monster is DEAD, Dave") // we should never see this message, because when the monster dies the timer which calls this function is stopped.
            
        }
        
    }
    
    func gameOver() {
        timer.invalidate() // we don't want the timer to go any more!
        if monsterAlive {
            // gameOver can be called when the monster first dies, and AGAIN when you try one last time to revive him, so we don't want the animation and death sfx to repeat.
            monsterAlive = false
            monsterImg.playDeathAnimation()
            sfxDeath.play()
        }
        endTimer()
        musicPlayer.stop()
        foodImg.alpha = DIM_ALPHA
        heartImg.alpha = DIM_ALPHA
        foodImg.userInteractionEnabled = false
        heartImg.userInteractionEnabled = false
        print("GAME OVER!")
    }

}











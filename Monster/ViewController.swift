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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        foodImg.dropTarget = monsterImg
        heartImg.dropTarget = monsterImg
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "itemDroppedOnCharacter:", name: "onTargetDropped", object: nil)


        
        
        
        
    }

    func itemDroppedOnCharacter(notif: AnyObject) { // we're not going to use this object, so we don't need to worry about it
        print("Item dropped on character!")
    }


}


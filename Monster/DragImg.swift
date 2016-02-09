//
//  DragImg.swift
//  Monster
//
//  Created by David Stroud on 09/02/2016.
//  Copyright © 2016 David Stroud. All rights reserved.
//

import Foundation
import UIKit


// in the Identity Inspector for the 'heart' and 'food' img on the storyboard, change the class to this new 'DragImg' subclass, to enable dragging!

// also in the viewcontroller, change the @IBOutlet for heartImg and foodImg to 'DragImg' (no longer 'UIImageView')

// in the attributes inspector for the 'heart' and 'food', enable 'user interaction' checkbox


class DragImg: UIImageView {
    
    // create a var to hold our starting point
    var originalPosition: CGPoint!
    
    // where are things dropped? We know the monster is an image, but what if, later, we drop something on a button? Well, a button and an imageview both inherit from UIView, so let's use that. Smart!
    var dropTarget: UIView!
    
    // need to override a couple of things but still need to call the parent initialiser otherwise we will have problems!
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // now need to intercept certain events and do something with them
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        originalPosition = self.center // grabs the center point when there's a touch
    
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
    
        if let touch = touches.first { // grab the very first object in the touches set. Remember it's optional, hence using 'if let' syntax
            let position = touch.locationInView(self.superview) // grab the location in the superview and store in immutable variable 'position'
            self.center = CGPointMake(position.x, position.y) // move OUR centre to this new position. Wherever your finger is dragging, move the object there.
        }
        
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        // check if we've dropped on top of our target
        if let touch = touches.first, let target = dropTarget { // if there's a value in BOTH places...
            
            let position = touch.locationInView(self.superview)
            
            // is the image we dragged on top of the frame of the character?
            if CGRectContainsPoint(target.frame, position) {
                // we dropped it on the monster!
                // make a notification so the view controller knows what to do next
                NSNotificationCenter.defaultCenter().postNotificationName("onTargetDropped", object: nil)
            }
            
        }
        
        self.center = originalPosition
        
    }
}











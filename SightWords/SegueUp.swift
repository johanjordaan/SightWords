//
//  SegueUp.swift
//  SightWords
//
//  Created by Johan Jordaan on 25/7/19.
//  Copyright © 2019 Johan Jordaan. All rights reserved.
//

import UIKit

class SegueUp: UIStoryboardSegue {
    override func perform() {
        let src = self.source
        let dst = self.destination
        
        let screenWidth = src.view.frame.size.width
        let screenHeight = src.view.frame.size.height
        
        dst.view.frame = CGRect(x:0, y:0, width:screenWidth, height:screenHeight)
        
        src.view.superview?.insertSubview(dst.view, aboveSubview: src.view)

        UIView.animate(withDuration:2, animations: { () -> Void in
            src.view.frame = CGRect.offset(src.view.frame, 0.0, screenHeight)
            dst.view.frame = CGRect.offset(dst.view.frame, 0.0, screenHeight)
            
        }) { (Finished) -> Void in
            self.sourceViewController.presentViewController(self.destinationViewController as! UIViewController,
                                                            animated: false,
                                                            completion: nil)
        }
        
    }
}

//
//  LeftRightViewController.swift
//  SightWords
//
//  Created by Johan Jordaan on 25/7/19.
//  Copyright © 2019 Johan Jordaan. All rights reserved.
//

import UIKit

class LeftRightViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let swipeLeft = UISwipeGestureRecognizer(
            target: self,
            action: #selector(self.swipeLeftAction(swipe:))
        )
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left;
        self.view.addGestureRecognizer(swipeLeft)

        let swipeRight = UISwipeGestureRecognizer(
            target: self,
            action: #selector(self.swipeRightAction(swipe:))
        )
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right;
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeUp = UISwipeGestureRecognizer(
            target: self,
            action: #selector(self.swipeUpAction(swipe:))
        )
        swipeUp.direction = UISwipeGestureRecognizer.Direction.up;
        self.view.addGestureRecognizer(swipeUp)

    }
    
    @objc func swipeLeftAction(swipe:UISwipeGestureRecognizer) {
    }
    @objc func swipeRightAction(swipe:UISwipeGestureRecognizer) {
    }
    @objc func swipeUpAction(swipe:UISwipeGestureRecognizer) {
    }

    
    
}

//
//  ViewController.swift
//  SightWords
//
//  Created by Johan Jordaan on 24/7/19.
//  Copyright © 2019 Johan Jordaan. All rights reserved.
//

import UIKit

class LeftViewController: LeftRightViewController {
   
    @IBOutlet weak var navBar: UINavigationItem!
    @IBOutlet weak var wordButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        navBar.title = "xxx"
        navBar.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(onBack))
        
        wordButton.setTitle(SightWordManager.shared.next().word,for: .normal)
    }
    
    @objc func onBack(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "backL", sender: self)
    }
    
    @objc override func swipeLeftAction(swipe:UISwipeGestureRecognizer) {
        performSegue(withIdentifier: "LR_L", sender: self)
    }

    @objc override func swipeRightAction(swipe:UISwipeGestureRecognizer) {
        performSegue(withIdentifier: "LR_R", sender: self)
    }
    
    @objc override func swipeUpAction(swipe:UISwipeGestureRecognizer) {
        performSegue(withIdentifier: "LR_U", sender: self)
    }


}

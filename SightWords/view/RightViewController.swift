//
//  ViewController2ViewController.swift
//  SightWords
//
//  Created by Johan Jordaan on 24/7/19.
//  Copyright © 2019 Johan Jordaan. All rights reserved.
//

import UIKit

class RightViewController: LeftRightViewController {
    
    @IBOutlet weak var navBar: UINavigationItem!
    @IBOutlet weak var wordButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navBar.title = "xxx2"
        navBar.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(onBack))
        
        wordButton.setTitle(SightWordManager.shared.next().word,for: .normal)
    }
    
    @objc func onBack(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "backR", sender: self)
    }
    
    @objc override func swipeLeftAction(swipe:UISwipeGestureRecognizer) {
        performSegue(withIdentifier: "RL_L", sender: self)
    }

    @objc override func swipeRightAction(swipe:UISwipeGestureRecognizer) {
        performSegue(withIdentifier: "RL_R", sender: self)
    }

    @objc override func swipeUpAction(swipe:UISwipeGestureRecognizer) {
        performSegue(withIdentifier: "RL_U", sender: self)
    }

}

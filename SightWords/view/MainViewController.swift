//
//  MainViewController.swift
//  SightWords
//
//  Created by Johan Jordaan on 25/7/19.
//  Copyright © 2019 Johan Jordaan. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onClick(_ sender: UIButton) {
        performSegue(withIdentifier: "start", sender: self)
    }
}

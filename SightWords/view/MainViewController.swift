//
//  MainViewController.swift
//  SightWords
//
//  Created by Johan Jordaan on 25/7/19.
//  Copyright © 2019 Johan Jordaan. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var navBar: UINavigationItem!
    public var student:Student?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navBar.title = student!.name
        navBar.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(onBack))
        navBar.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(onEdit))

        
    }
    
    @objc func onBack(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "studentToMain", sender: self)
    }
   
    @objc func onEdit(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "EditStudent", sender: self)
    }
    
    @IBAction func onClick(_ sender: UIButton) {
        performSegue(withIdentifier: "start", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        //   let name  = segue.identifier!
        
        if segue.identifier == "EditStudent"
        {
            if let destinationVC = segue.destination as? StudentViewController {
                destinationVC.mode = StudentViewController.Mode.edit
                destinationVC.student = student
            }
        }
    }

}

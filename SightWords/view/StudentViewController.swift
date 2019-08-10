//
//  StudentViewController.swift
//  SightWords
//
//  Created by Johan Jordaan on 9/8/19.
//  Copyright © 2019 Johan Jordaan. All rights reserved.
//

import UIKit

class StudentViewController: UIViewController {

    @IBOutlet weak var navBar: UINavigationItem!
    
    public enum Mode {
        case edit
        case add
    }
    public var mode = Mode.edit;
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var actionButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        navBar.title = "xxx"
        navBar.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(onBack))
        
        if(mode == Mode.edit) {
            actionButton.setTitle("Update",for: .normal)
        } else if(mode == Mode.add) {
            actionButton.setTitle("Add",for: .normal)
        }
        
    }

    func goBack() {
        if(mode==Mode.add) {
            performSegue(withIdentifier: "BackFromAdd", sender: self)
        } else if(mode==Mode.edit) {
            performSegue(withIdentifier: "BackFromEdit", sender: self)
        }
    }
    
    @objc func onBack(_ sender: UIBarButtonItem) {
        self.goBack()
    }

    @IBAction func onClick(_ sender: Any) {
        // Update user
        self.goBack()
    }

    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

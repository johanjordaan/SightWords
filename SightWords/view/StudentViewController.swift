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
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var actionButton: UIButton!
    @IBAction func onClick(_ sender: Any) {
        student!.name = name.text!
        do {
            if(mode==Mode.add) {
                let _ = try Students.shared.add(newStudent: student!)
            } else if(mode==Mode.edit) {
                let _ = try Students.shared.update(student: student!)
            }
        } catch {
        }
        self.goBack()
    }

    
    public enum Mode {
        case edit
        case add
    }
    public var mode = Mode.edit;
    public var student:Student?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navBar.title = student!.name
        navBar.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(onBack))
        
        if(mode == Mode.edit) {
            actionButton.setTitle("Update",for: .normal)
        } else if(mode == Mode.add) {
            actionButton.setTitle("Add",for: .normal)
        }
        
        
        name.text = student!.name
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


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "BackFromEdit"
        {
            if let destinationVC = segue.destination as? MainViewController {
                destinationVC.student = student
            }
        } else if segue.identifier == "BackFromAdd" {
        }
    }
    
}

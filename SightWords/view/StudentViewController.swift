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

    @IBAction func onClickDelete(_ sender: Any) {
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func onClickAction(_ sender: Any) {
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
    public var mode = Mode.edit
    public var student:Student?
    
    let alertController = UIAlertController(title: "Delete?", message: "Are you sure you want to delete this student. This action cannot be reversed.", preferredStyle: .alert)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        student = Students.shared.getSelected()
        mode = Mode.edit
        actionButton.setTitle("Update",for: .normal)
        
        if(student == nil) {
            student = Student(name:"")
            mode = Mode.add
            actionButton.setTitle("Add",for: .normal)
        }
        name.text = student!.name

        
        
        navBar.title = student!.name
        
        navBar.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(onBack))
        
        
        let action1 = UIAlertAction(title: "Delete", style: .default) { (action:UIAlertAction) in
            self.deleteAndGoHome()
        }
        
        let action2 = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction) in
        }
        
        alertController.addAction(action1)
        alertController.addAction(action2)
        
    }

    func deleteAndGoHome() {
        do {
            let _ = try Students.shared.delete(student: self.student!)
            let _ = Students.shared.setSelect(student: nil)
            performSegue(withIdentifier: "BackFromAdd", sender: self)
        } catch {
            
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


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "BackFromEdit" {
        } else if segue.identifier == "BackFromAdd" {
        }
    }
    
}

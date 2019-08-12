//
//  ViewController.swift
//  SightWords
//
//  Created by Johan Jordaan on 2/8/19.
//  Copyright © 2019 Johan Jordaan. All rights reserved.
//

import UIKit

class StudentsViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var navBar: UINavigationItem!
    
    private let reuseIdentifier = "StudentCell"
    private let sectionInsets = UIEdgeInsets(top: 50.0,
                                             left: 50.0,
                                             bottom: 50.0,
                                             right: 50.0)
    private let itemsPerRow: CGFloat = 1

    
    private var students:[Student] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        
        navBar.title = "xxx"
        navBar.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(onAdd))
        
        do {
            students = try Students.shared.getAll()
        } catch {
            students = []
        }
    }
    
    @objc func onAdd(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "AddStudent", sender: self)
    }

    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     //   let name  = segue.identifier!
        
        if segue.identifier == "AddStudent"
        {
            let _ = Students.shared.setSelect(student: nil)
        } else if segue.identifier == "SelectStudent" {
            let s = sender as! StudentCell
            let _ = Students.shared.setSelect(student: s.student)
        }
     }
}


extension StudentsViewController:UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return students.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
        ) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                      for: indexPath) as! StudentCell
        
        cell.backgroundColor = .blue
        cell.Name.text = students[indexPath.row].name
        cell.student = students[indexPath.row]
        
        return cell
    }
}

extension StudentsViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = collectionView.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}

extension StudentsViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item + 1)
    }
}






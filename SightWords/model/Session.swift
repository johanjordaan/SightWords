//
//  Session.swift
//  SightWords
//
//  Created by Johan Jordaan on 31/7/19.
//  Copyright © 2019 Johan Jordaan. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class Session {
    private init() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Word")

        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        do {
            try context.execute(deleteRequest)
        } catch {
            print("Error dropping")
        }
        
        
        let wordEndity = NSEntityDescription.entity(forEntityName: "Word", in: context)
        let newWord = NSManagedObject(entity: wordEndity!, insertInto: context)
        
        newWord.setValue(baseWords[0].word, forKey: "word")
        newWord.setValue(baseWords[0].rank, forKey: "rank")
        
        do {
            try context.save()
        } catch {
            print("Error saving")
        }
        
        request.predicate = NSPredicate(format:"word=%@","the")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                print(data.value(forKey:"word") as! String)
            }
        } catch {
            print("Error fetching")
            
        }
    
    }
    
    
    public func start(count:Int,student:String) {
    }
    
    public func end() {
    }
    
}



//
//  DataManager.swift
//  SightWords
//
//  Created by Johan Jordaan on 1/8/19.
//  Copyright © 2019 Johan Jordaan. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class DataContext {
    private let container:NSPersistentContainer
    public let context:NSManagedObjectContext

    private init() {
        container = NSPersistentContainer(name: "SightWords")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        context = container.viewContext
    }
    static let shared = DataContext()
    
}

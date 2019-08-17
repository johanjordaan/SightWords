//
//  DBStudent.swift
//  SightWords
//
//  Created by Johan Jordaan on 14/8/19.
//  Copyright © 2019 Johan Jordaan. All rights reserved.
//

import Foundation
import CoreData

class DBStudent {
    private static var cache:[DBStudent] = []
    private static var cacheLookup:[String:DBStudent] = [:]


    public static func GetAll(context:NSManagedObjectContext) throws -> [DBStudent] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "DBStudent")
        request.returnsObjectsAsFaults = false
        let items = try context.fetch(request)

        self.cache  = (items as! [NSManagedObject]).map {
            (item:NSManagedObject) -> DBStudent in
                return DBStudent(context:context,managedObject:item)
        }
        self.cacheLookup = Dictionary(uniqueKeysWithValues: self.cache.map { ($0.id,$0)})
        return self.cache
    }
    
    public static func DeleteAll(context:NSManagedObjectContext) throws {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "DBStudent")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        try context.execute(deleteRequest)
    }

  
    public static func Create(context:NSManagedObjectContext,managedObject:NSManagedObject) -> DBStudent {
        guard let retVal = self.cacheLookup[managedObject.value(forKey: "id")  as! String] else {
            let newItem = DBStudent(context:context,managedObject:managedObject)
            cache.append(newItem)
            cacheLookup[newItem.id] = newItem
            return newItem
        }
        return retVal;
    }

    public static func Create(context:NSManagedObjectContext,id:String,name:String,words:[DBStudentWord]) -> DBStudent {
        let newItem = DBStudent(context:context,id:id,name:name,words:words)
        cache.append(newItem)
        cacheLookup[newItem.id] = newItem        
        return newItem
    }

    private var context:NSManagedObjectContext
    private var entityDescription:NSEntityDescription
    private var managedObject:NSManagedObject
    private init(context:NSManagedObjectContext,managedObject:NSManagedObject) {    
        self.context = context
        self.entityDescription = NSEntityDescription.entity(forEntityName: "DBStudent", in: self.context)!
        self.managedObject = managedObject
        self.id = managedObject.value(forKey: "id")  as! String
        self.name = managedObject.value(forKey: "name")  as! String
        self.words = (managedObject.value(forKey: "words") as! [NSManagedObject]).map {
            (managedObject:NSManagedObject) -> DBStudentWord in 
                return DBStudentWord.Create(context:context,managedObject:managedObject)
        }
        
    }

    private init(context:NSManagedObjectContext,id:String,name:String,words:[DBStudentWord]) {
        self.context = context
        self.entityDescription = NSEntityDescription.entity(forEntityName: "DBStudent", in: self.context)!
        self.id = NSUUID().uuidString
        self.name = name
        self.words = words
    
        self.managedObject = NSManagedObject(entity: self.entityDescription, insertInto: self.context)
        self.managedObject.setValue(self.id, forKey: "id")
        self.managedObject.setValue(self.name, forKey: "name")
        self.managedObject.setValue(self.words, forKey: "words")
    }

    private var id:String
    public func set(id:String) throws {
      self.id = id
      self.managedObject.setValue(self.id, forKey: "id")
    }
    public func getId() -> String {
      return self.id
    }

    private var name:String
    public func set(name:String) throws {
      self.name = name
      self.managedObject.setValue(self.name, forKey: "name")
    }
    public func getName() -> String {
      return self.name
    }




    private var words:[DBStudentWord]
    public func add(item:DBStudentWord) throws {
      guard let _ = self.words.firstIndex(where :{
          (i:DBStudentWord) -> Bool in
              return item.getId() == i.getId()
      }) else {
        self.words.append(item)
        return
      }
    }
    public func remove(item:DBStudentWord) throws {
        guard let foundIndex = self.words.firstIndex(where :{
            (i:DBStudentWord) -> Bool in
                return item.getId() == i.getId()
        }) else {
            return
        }
        self.words.remove(at: foundIndex)
    }
    public func getWords() -> [DBStudentWord] {
      return self.words
    }




    public func save() throws {
        try self.context.save()
    }
}
//
//  DBStudentWord.swift
//  SightWords
//
//  Created by Johan Jordaan on 14/8/19.
//  Copyright © 2019 Johan Jordaan. All rights reserved.
//

import Foundation
import CoreData

class DBStudentWord {
    private static var cache:[DBStudentWord] = []
    private static var cacheLookup:[String:DBStudentWord] = [:]


    public static func GetAll(context:NSManagedObjectContext) throws -> [DBStudentWord] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "DBStudentWord")
        request.returnsObjectsAsFaults = false
        let items = try context.fetch(request)

        self.cache  = (items as! [NSManagedObject]).map {
            (item:NSManagedObject) -> DBStudentWord in
                return DBStudentWord(context:context,managedObject:item)
        }
        self.cacheLookup = Dictionary(uniqueKeysWithValues: self.cache.map { ($0.id,$0)})
        return self.cache
    }
    
    public static func DeleteAll(context:NSManagedObjectContext) throws {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "DBStudentWord")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        try context.execute(deleteRequest)
    }

  
    public static func Create(context:NSManagedObjectContext,managedObject:NSManagedObject) -> DBStudentWord {
        guard let retVal = self.cacheLookup[managedObject.value(forKey: "id")  as! String] else {
            let newItem = DBStudentWord(context:context,managedObject:managedObject)
            cache.append(newItem)
            cacheLookup[newItem.id] = newItem
            return newItem
        }
        return retVal;
    }

    public static func Create(context:NSManagedObjectContext,correctCount:Int,incorrectCount:Int,lastReviewed:Date,level:Int,rank:Int,word:String,student:DBStudent) -> DBStudentWord {
        let newItem = DBStudentWord(context:context,correctCount:correctCount,incorrectCount:incorrectCount,lastReviewed:lastReviewed,level:level,rank:rank,word:word,student:student)
        cache.append(newItem)
        cacheLookup[newItem.id] = newItem        
        return newItem
    }

    private var context:NSManagedObjectContext
    private var entityDescription:NSEntityDescription
    private var managedObject:NSManagedObject
    private init(context:NSManagedObjectContext,managedObject:NSManagedObject) {    
        self.context = context
        self.entityDescription = NSEntityDescription.entity(forEntityName: "DBStudentWord", in: self.context)!
        self.managedObject = managedObject
        self.correctCount = managedObject.value(forKey: "correctCount")  as! Int
        self.id = managedObject.value(forKey: "id")  as! String
        self.incorrectCount = managedObject.value(forKey: "incorrectCount")  as! Int
        self.lastReviewed = managedObject.value(forKey: "lastReviewed")  as! Date
        self.level = managedObject.value(forKey: "level")  as! Int
        self.rank = managedObject.value(forKey: "rank")  as! Int
        self.word = managedObject.value(forKey: "word")  as! String
        self.student = DBStudent.Create(context:context,managedObject:managedObject)
        
    }

    private init(context:NSManagedObjectContext,correctCount:Int,incorrectCount:Int,lastReviewed:Date,level:Int,rank:Int,word:String,student:DBStudent) {
        self.context = context
        self.entityDescription = NSEntityDescription.entity(forEntityName: "DBStudentWord", in: self.context)!
        self.id = NSUUID().uuidString
        self.correctCount = correctCount
        self.incorrectCount = incorrectCount
        self.lastReviewed = lastReviewed
        self.level = level
        self.rank = rank
        self.word = word
        self.student = student
    
        self.managedObject = NSManagedObject(entity: self.entityDescription, insertInto: self.context)
        self.managedObject.setValue(self.correctCount, forKey: "correctCount")
        self.managedObject.setValue(self.id, forKey: "id")
        self.managedObject.setValue(self.incorrectCount, forKey: "incorrectCount")
        self.managedObject.setValue(self.lastReviewed, forKey: "lastReviewed")
        self.managedObject.setValue(self.level, forKey: "level")
        self.managedObject.setValue(self.rank, forKey: "rank")
        self.managedObject.setValue(self.word, forKey: "word")
        self.managedObject.setValue(self.student, forKey: "student")
    }

    private var correctCount:Int
    public func set(correctCount:Int) throws {
      self.correctCount = correctCount
      self.managedObject.setValue(self.correctCount, forKey: "correctCount")
    }
    public func getCorrectCount() -> Int {
      return self.correctCount
    }

    private var id:String
    public func set(id:String) throws {
      self.id = id
      self.managedObject.setValue(self.id, forKey: "id")
    }
    public func getId() -> String {
      return self.id
    }

    private var incorrectCount:Int
    public func set(incorrectCount:Int) throws {
      self.incorrectCount = incorrectCount
      self.managedObject.setValue(self.incorrectCount, forKey: "incorrectCount")
    }
    public func getIncorrectCount() -> Int {
      return self.incorrectCount
    }

    private var lastReviewed:Date
    public func set(lastReviewed:Date) throws {
      self.lastReviewed = lastReviewed
      self.managedObject.setValue(self.lastReviewed, forKey: "lastReviewed")
    }
    public func getLastReviewed() -> Date {
      return self.lastReviewed
    }

    private var level:Int
    public func set(level:Int) throws {
      self.level = level
      self.managedObject.setValue(self.level, forKey: "level")
    }
    public func getLevel() -> Int {
      return self.level
    }

    private var rank:Int
    public func set(rank:Int) throws {
      self.rank = rank
      self.managedObject.setValue(self.rank, forKey: "rank")
    }
    public func getRank() -> Int {
      return self.rank
    }

    private var word:String
    public func set(word:String) throws {
      self.word = word
      self.managedObject.setValue(self.word, forKey: "word")
    }
    public func getWord() -> String {
      return self.word
    }



    private var student:DBStudent
    public func set(student:DBStudent) throws {
      self.student = student
      self.managedObject.setValue(self.student, forKey: "student")
    }
    public func getStudent() -> DBStudent {
      return self.student
    }





    public func save() throws {
        try self.context.save()
    }
}
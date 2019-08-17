//
//  Student.swift
//  SightWords
//
//  Created by Johan Jordaan on 1/8/19.
//  Copyright © 2019 Johan Jordaan. All rights reserved.
//

import Foundation
import CoreData
/*
class StudentDOA {
    private static func extractSightWords(dbStudent:DBStudents) -> [SightWord] {
        
        if let dbSightWords = dbStudent.words {
            let sightWords = dbSightWords.map {
                (dbSightWord)->SightWord in do {
                    let x = dbSightWord as! DBStudentWords
                    return SightWord(
                        word: x.word!,
                        rank: Int(x.rank),
                        level: Int(x.level),
                        correctCount: Int(x.correctCount),
                        incorrectCount: Int(x.incorrectCount),
                        lastReviewed: x.lastReviewed!
                    )
                }
            }
            
            return sightWords
            
        } else {
            return []
        }
        
    }
    
    
    public static func GetAll() throws -> [Student] {
        let context = DataContext.shared.context
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "DBStudents")
        request.returnsObjectsAsFaults = false
        let result = try context.fetch(request)
        
        let retVal  = (result as! [DBStudent]).map {
            (dbStudent:DBStudent)->Student in
                return Student(
                    id:dbStudent.id,
                    name:dbStudent.name!,
                    words: StudentDOA.extractSightWords(dbStudent:dbStudent)
                )
        }
        return retVal
    }
    
    public static func Create(student: Student) throws -> Student {
        let context = DataContext.shared.context
        
        let dbStudent = DBStudent(context:context)
        dbStudent.id = student.id
        dbStudent.name = student.name
        
        for word in student.words {
            let dbWord = DBStudentWords(context: context)
            dbWord.word = word.word
            dbWord.rank = Int16(word.rank)
            dbWord.level = Int16(word.level)
            dbWord.correctCount = Int16(word.correctCount)
            dbWord.incorrectCount = Int16(word.incorrectCount)
            dbWord.lastReviewed = word.lastReviewed
            
            dbStudent.addToWords(dbWord)
        }
        
        try context.save()
        return student

        
        
        /*let studentEntity = NSEntityDescription.entity(forEntityName: "DBStudents", in: context)
        let dbStudent = NSManagedObject(entity: studentEntity!, insertInto: context)
        dbStudent.setValue(student.id, forKey: "id")
        dbStudent.setValue(student.name, forKey: "name")
        
        
        let studentWordEntity = NSEntityDescription.entity(forEntityName: "DBStudentWords", in: context)
        let dbStudentWords:[NSManagedObject] = student.words.map {
            (word:SightWord) -> NSManagedObject in do {
                let dbWord = NSManagedObject(entity: studentWordEntity!, insertInto: context)
                dbWord.setValue(word.word,forKey: "word")
                dbWord.setValue(word.rank,forKey: "rank")
                dbWord.setValue(word.level,forKey: "level")
                dbWord.setValue(word.correctCount,forKey: "correctCount")
                dbWord.setValue(word.incorrectCount,forKey: "incorrectCount")
                dbWord.setValue(word.lastReviewed,forKey: "lastReviewed")
                return dbWord
            }
        }

        let dbWords = dbStudent.mutableSetValue(forKey: "words")
        for dbWord in dbStudentWords {
            dbWords.add(dbWord)
        }
        */
    }
    
    public static func DeleteAll() throws {
        let context = DataContext.shared.context
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "DBStudents")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        try context.execute(deleteRequest)
    }
    
    public static func Delete(student: Student) throws -> Student {
        let context = DataContext.shared.context
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "DBStudents")
        request.predicate = NSPredicate(format:"id=%@",student.id)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        try context.execute(deleteRequest)
        return student
    }
    
    public static func Update(student: Student) throws -> Student {
        let context = DataContext.shared.context
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "DBStudents")
        request.returnsObjectsAsFaults = false
        request.predicate = NSPredicate(format:"id=%@",student.id)
        let dbStudents = try context.fetch(request)
        for dbStudent in dbStudents as! [NSManagedObject] {
            dbStudent.setValue(student.name, forKey: "name")
        }
        try context.save()
        return student
    }

}

class Students {

    private var selectedStudent:Student?
    private init() {
    }
    static let shared = Students()
    
    public func getAll() throws -> [Student] {
        return try StudentDOA.GetAll()
    }

    public func add(newStudent:Student) throws -> [Student] {
        let _ = try StudentDOA.Create(student: newStudent)
        return try self.getAll()
    }
    
    public func delete(student:Student) throws -> [Student] {
        let _ = try StudentDOA.Delete(student: student)
        return try self.getAll()
    }
    
    public func deleteAll() throws -> [Student] {
        try StudentDOA.DeleteAll()
        return try self.getAll()
    }

    public func update(student:Student) throws -> [Student] {
        let _ = try StudentDOA.Update(student: student)
        return try self.getAll()
    }
    
    public func setSelect(student:Student?) -> Student? {
        self.selectedStudent = student
        return self.getSelected()
    }
    
    public func getSelected() -> Student? {
        return self.selectedStudent
    }
    
}
*/

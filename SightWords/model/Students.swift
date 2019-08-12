//
//  Student.swift
//  SightWords
//
//  Created by Johan Jordaan on 1/8/19.
//  Copyright © 2019 Johan Jordaan. All rights reserved.
//

import Foundation
import CoreData


class StudentDOA {
    
    public static func GetAll() throws -> [Student] {
        let context = DataContext.shared.context
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "DBStudents")
        request.returnsObjectsAsFaults = false
        let result = try context.fetch(request)
        let retVal  = (result as! [NSManagedObject]).map {(dbStudent:NSManagedObject)->Student in
            return Student(id:dbStudent.value(forKey: "id") as! String, name:dbStudent.value(forKey: "name") as! String)
        }
        return retVal
    }
    
    public static func Create(student: Student) throws -> Student {
        let context = DataContext.shared.context
        let studentEntity = NSEntityDescription.entity(forEntityName: "DBStudents", in: context)
        let dbStudent = NSManagedObject(entity: studentEntity!, insertInto: context)
        dbStudent.setValue(student.id, forKey: "id")
        dbStudent.setValue(student.name, forKey: "name")
        try context.save()
        return student
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

class Student {
    var id:String
    var name:String
    
    
    public init(id:String,name:String) {
        self.id = id
        self.name = name
    }
    
    public init(name:String) {
        self.id = NSUUID().uuidString
        self.name = name
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

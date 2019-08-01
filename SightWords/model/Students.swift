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
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Students")
        request.returnsObjectsAsFaults = false
        let result = try context.fetch(request)
        let retVal  = (result as! [NSManagedObject]).map {(dbStudent:NSManagedObject)->Student in
            return Student(name:dbStudent.value(forKey: "name") as! String)
        }
        return retVal
    }
    
    public static func Create(student: Student) throws -> Student {
        let context = DataContext.shared.context
        let studentEntity = NSEntityDescription.entity(forEntityName: "Students", in: context)
        let dbStudent = NSManagedObject(entity: studentEntity!, insertInto: context)
        dbStudent.setValue(student.id, forKey: "id")
        dbStudent.setValue(student.name, forKey: "name")
        try context.save()
        return student
    }
    
    public static func Delete(student: Student) throws -> Student {
        let context = DataContext.shared.context
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Students")
        request.predicate = NSPredicate(format:"id=%@",student.id)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        try context.execute(deleteRequest)
        return student
    }
    
    public static func Update(student: Student) throws -> Student {
        let context = DataContext.shared.context
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Students")
        request.returnsObjectsAsFaults = false
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
    
    public init(name:String) {
        self.id = NSUUID().uuidString
        self.name = name
    }
}

class Students {

    var students:[Student]?
    
    private init() {
        self.students = nil
    }
    static let shared = Students()
    
    public func getAll() throws -> [Student] {
        if(self.students==nil) {
            self.students = try StudentDOA.GetAll()
        }
        return self.students!
    }

    public func add(newStudent:Student) throws -> [Student] {
        if(self.students==nil) {
            self.students = try self.getAll()
        }
        let _ = try StudentDOA.Create(student: newStudent)
        self.students?.append(newStudent)
        return self.students!
    }
    
    public func delete(student:Student) throws -> [Student] {
        let _ = try StudentDOA.Delete(student: student)
        self.students?.removeAll {$0.id==student.id}
        return self.students!
    }

    public func update(student:Student) throws -> [Student] {
        let _ = try StudentDOA.Update(student: student)
        return self.students!
    }
}

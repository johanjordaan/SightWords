//
//  DBStudentWord.swift
//  SightWordsTests
//
//  Created by Johan Jordaan on 10/8/19.
//  Copyright © 2019 Johan Jordaan. All rights reserved.
//

import XCTest
import Foundation
import CoreData

import SightWords

class DBStudentWordTests: XCTestCase {
    private static func generateString() -> String {
      return "test"
    }
    private static func generateInt() -> Int {
      return 99
    }
    private static func generateDate() -> Date {
      return Date.init()
    }

    public static func CreateTestItem(context:NSManagedObjectContext) throws -> DBStudentWord {
        let correctCount = generateInt()
        let incorrectCount = generateInt()
        let lastReviewed = generateDate()
        let level = generateInt()
        let rank = generateInt()
        let word = generateString()
      
        let student = try DBStudentTests.CreateTestItem(context:context)

      
      return DBStudentWord.Create(context:context,correctCount:correctCount,incorrectCount:incorrectCount,lastReviewed:lastReviewed,level:level,rank:rank,word:word,student:student)       
    }

    override func setUp() {
        do {
            let _ = try DBStudentWord.DeleteAll(context:DataContext.shared.context)
        } catch {
            XCTFail()
        }
    }

    override func tearDown() {
        do {
            let _ = try DBStudentWord.DeleteAll(context:DataContext.shared.context)
        } catch {
            XCTFail()
        }
    }
  
    func testGetAll() {
        do {
            let list = try DBStudentWord.GetAll(context:DataContext.shared.context)
            XCTAssertEqual(list.count,0)
            
            //let newStudent = Student(name:"Abigail")
            //let students2 = try Students.shared.add(newStudent: newStudent)
            //XCTAssertEqual(students2.count,1)
            //let students3 = try Students.shared.getAll()
            //XCTAssertEqual(newStudent.id,students3[0].id)
            //XCTAssertEqual(students2[0].id,students3[0].id)
            //XCTAssertEqual(students2[0].name,students3[0].name)
            
        } catch {
            XCTFail()
        }

    }
/*    
    func testAdd() {
        do {
            let students = try Students.shared.getAll()
            XCTAssertEqual(students.count,0)
            let newStudent = Student(name:"Abigail")
            let students2 = try Students.shared.add(newStudent: newStudent)
            XCTAssertEqual(students2.count,1)
            XCTAssertEqual(students2[0].name,"Abigail")
            XCTAssertEqual(students2[0].words.count,500)
        } catch {
            XCTFail()
        }
    }

    func testUpdate() {
        do {
            let abigail = Student(name:"Abigai")
            let lily = Student(name:"Lily")
            let _ = try Students.shared.add(newStudent: abigail)
            let _ = try Students.shared.add(newStudent: lily)
            abigail.name = "Abigail"
            let _ = try Students.shared.update(student: abigail)

            var students = try Students.shared.getAll()
            XCTAssertEqual(students.count,2)
            XCTAssertEqual(students[0].name,"Abigail")
            XCTAssertEqual(students[1].name,"Lily")
        } catch {
            XCTFail()
        }
    }

    func testDelete() {
        do {
            let newStudent1 = Student(name:"Abigail")
            let newStudent2 = Student(name:"Lily")
            let _ =  try Students.shared.add(newStudent: newStudent1)
            let _ =  try Students.shared.add(newStudent: newStudent2)
            let students = try Students.shared.delete(student: newStudent1)
            XCTAssertEqual(students.count,1)
            XCTAssertEqual(students[0].name,"Lily")
        } catch {
            XCTFail()
        }
    }

    func testGetSetSelected() {
        do {
            let abigail = Student(name:"Abigail")
            let lily = Student(name:"Lily")
            let _ =  try Students.shared.add(newStudent: abigail)
            let _ =  try Students.shared.add(newStudent: lily)
            
            XCTAssertNil(Students.shared.getSelected())
            
            let _ = Students.shared.setSelect(student: lily)
            XCTAssertEqual(Students.shared.getSelected()!.name,"Lily")
            
            let _ = Students.shared.setSelect(student: nil)
            XCTAssertNil(Students.shared.getSelected())
            
        } catch {
            XCTFail()
        }
    }
    

    func testPerformanceExample() {
        self.measure {
        }
    }
*/
}

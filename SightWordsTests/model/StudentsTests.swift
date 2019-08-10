//
//  StudentsTests.swift
//  SightWordsTests
//
//  Created by Johan Jordaan on 10/8/19.
//  Copyright © 2019 Johan Jordaan. All rights reserved.
//

import XCTest

class StudentsTests: XCTestCase {

    override func setUp() {
        do {
            let _ = try Students.shared.deleteAll()
        } catch {
            XCTFail()
        }
    }

    override func tearDown() {
        do {
            let _ = try Students.shared.deleteAll()
        } catch {
            XCTFail()
        }
    }
    
    func testGetAll() {
        do {
            let students = try Students.shared.getAll()
            XCTAssertEqual(students.count,0)
        } catch {
            XCTFail()
        }

    }
    
    func testAdd() {
        do {
            let students = try Students.shared.getAll()
            XCTAssertEqual(students.count,0)
            let newStudent = Student(name:"Abigail")
            let students2 = try Students.shared.add(newStudent: newStudent)
            XCTAssertEqual(students2.count,1)
            XCTAssertEqual(students2[0].name,"Abigail")
        } catch {
            XCTFail()
        }
    }

    func testUpdate() {
        do {
            let students = try Students.shared.getAll()
            XCTAssertEqual(students.count,0)
            let newStudent = Student(name:"Abigail")
            let students2 = try Students.shared.add(newStudent: newStudent)
            XCTAssertEqual(students2.count,1)
            XCTAssertEqual(students2[0].name,"Abigail")
            newStudent.name = "Lily"
            let students3 = try Students.shared.update(student: newStudent)
            XCTAssertEqual(students3.count,1)
            XCTAssertEqual(students3[0].name,"Lily")
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

    
    

    func testPerformanceExample() {
        self.measure {
        }
    }

}

//
//  SeededGeneratorTests.swift
//  SightWordsTests
//
//  Created by Johan Jordaan on 30/7/19.
//  Copyright © 2019 Johan Jordaan. All rights reserved.
//

import XCTest

class SeededGeneratorTests: XCTestCase {

    override func setUp() {
    }

    override func tearDown() {
    }

    func testUnSeededInit() {
        let generator1 = SeededGenerator()
        XCTAssertTrue(generator1.seed == 0)
    }

    func testSeededInit() {
        let generator1 = SeededGenerator(seed:123)
        XCTAssertTrue(generator1.seed == 123)
    }
    
    func testNext() {
        let generator1 = SeededGenerator(seed:123)
        let a:UInt = generator1.next()
        
        let generator2 = SeededGenerator(seed:123)
        let b:UInt = generator2.next()
        
        XCTAssertTrue(a == b)
    }

    func testNextWithUpperBound() {
        let generator1 = SeededGenerator(seed:123)
        let a:UInt = generator1.next(upperBound: 5)
        
        XCTAssertTrue(a < 5)
    }
    
    
    
    func testPerformanceExample() {
        self.measure {
        }
    }

}

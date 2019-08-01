//
//  SightWordTests.swift
//  SightWordsTests
//
//  Created by Johan Jordaan on 30/7/19.
//  Copyright © 2019 Johan Jordaan. All rights reserved.
//

import XCTest

class SightWordTests: XCTestCase {

    override func setUp() {
    }

    override func tearDown() {
    }

    func testInit() {
        let sw1 = SightWord(word:"the",rank:1)
        XCTAssertTrue(sw1.word == "the")
        XCTAssertTrue(sw1.rank == 1)
    }

    func testPerformanceExample() {
        self.measure {
        }
    }

}

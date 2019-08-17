//
//  DataManagerTests.swift
//  SightWordsTests
//
//  Created by Johan Jordaan on 30/7/19.
//  Copyright © 2019 Johan Jordaan. All rights reserved.
//

import XCTest

class SiteWordManagerTests: XCTestCase {

    override func setUp() {
    }

    override func tearDown() {
    }

    func testgetCurrentIndex() {
        let swm = SightWordManager.shared
        XCTAssertEqual(swm.getCurrentIndex(),0)
        let _ = swm.next()
        XCTAssertEqual(swm.getCurrentIndex(),1)
    }
    
    func testReset() {
        let swm = SightWordManager.shared
        let _ = swm.next()
        swm.reset()
        XCTAssertEqual(swm.getCurrentIndex(),0)
    }

    func testShuffle() {
        let swm = SightWordManager.shared
        swm.reset()
        swm.shuffle()
        XCTAssertEqual(swm.next().word,baseWords[0].word)
    }
    
    func testNext() {
        let swm = SightWordManager.shared
        swm.reset()
        let next = swm.next()
        XCTAssertEqual(next.word,"the")
    }

    func testNextRollover() {
        let swm = SightWordManager.shared
        swm.reset()

        var next = swm.next()
        for _ in 1...baseWords.count {
         next = swm.next()
        }
        
        XCTAssertEqual(next.word,baseWords[0].word)
    }

    
    func testPerformanceExample() {
        self.measure {
        }
    }

}

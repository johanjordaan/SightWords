//
//  DataManager.swift
//  SightWords
//
//  Created by Johan Jordaan on 29/7/19.
//  Copyright © 2019 Johan Jordaan. All rights reserved.
//
import Foundation

class SightWordManager {
    private static var currentIndex = 0
    private static let semphore = DispatchSemaphore(value: 1)
    
    private init() {
    }
    
    static let shared = SightWordManager()

    public func reset() {
        SightWordManager.semphore.wait()
        SightWordManager.currentIndex = 0
        SightWordManager.semphore.signal()
    }

    public func getCurrentIndex() -> Int {
        SightWordManager.semphore.wait()
        let retVal = SightWordManager.currentIndex
        SightWordManager.semphore.signal()
        return retVal;
    }
    
    public func shuffle() {
    }
    
    public func next() -> SightWord {
        SightWordManager.semphore.wait()
        let retVal = baseWords[SightWordManager.currentIndex]
        SightWordManager.currentIndex += 1
        if(SightWordManager.currentIndex>=baseWords.count) {
            SightWordManager.currentIndex = 0
        }
        SightWordManager.semphore.signal()
        return retVal
    }
    
}

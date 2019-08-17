//
//  SightWord.swift
//  SightWords
//
//  Created by Johan Jordaan on 30/7/19.
//  Copyright © 2019 Johan Jordaan. All rights reserved.
//
import Foundation

class SightWord {
    var word:String
    var rank:Int
    var level:Int = 0
    var correctCount:Int = 0
    var incorrectCount:Int = 0
    var lastReviewed:Date = Date()
    
    public init(word:String,rank:Int) {
        self.word = word
        self.rank = rank
    }
    
    public init(word:String,rank:Int,level:Int,correctCount:Int,incorrectCount:Int,lastReviewed:Date) {
        self.word = word
        self.rank = rank
        self.level = level
        self.correctCount = correctCount
        self.incorrectCount = incorrectCount
        self.lastReviewed = lastReviewed
    }

}


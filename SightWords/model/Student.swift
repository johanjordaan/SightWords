//
//  Student.swift
//  SightWords
//
//  Created by Johan Jordaan on 13/8/19.
//  Copyright © 2019 Johan Jordaan. All rights reserved.
//

import Foundation

class Student {
    var id:String
    var name:String
    var words:[SightWord]
    
    
    public init(id:String,name:String,words:[SightWord]) {
        self.id = id
        self.name = name
        self.words = words
    }
    
    public init(name:String) {
        self.id = NSUUID().uuidString
        self.name = name
        self.words = baseWords
    }
}

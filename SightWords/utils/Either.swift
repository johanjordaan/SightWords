//
//  Either.swift
//  SightWords
//
//  Created by Johan Jordaan on 1/8/19.
//  Copyright © 2019 Johan Jordaan. All rights reserved.
//

import Foundation

enum Either<T1, T2> {
    case Left(T1)
    case Right(T2)
}

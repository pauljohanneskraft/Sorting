//
//  Operators.swift
//  Sort
//
//  Created by Paul Kraft on 15.02.16.
//  Copyright © 2016 kraft. All rights reserved.
//

import Cocoa

// retain/release traffic here
infix operator <-> { associativity left precedence 140 }
func <-> <T>(inout left: T, inout right: T) {
    (left, right) = (right, left)
}

/*
infix operator += { associativity left precedence 140 }
func += <T>(inout left: [T], inout right: T) {
    left.append(right)
}
*/
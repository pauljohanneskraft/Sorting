//
//  Operators.swift
//  Sort
//
//  Created by Paul Kraft on 15.02.16.
//  Copyright © 2016 kraft. All rights reserved.
//

import Cocoa

infix operator <-> { associativity left precedence 140 }
func <-> <T>( left: inout T, right: inout T) {
    swap(&left, &right)
}

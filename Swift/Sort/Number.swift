import Cocoa

//
//  Number.swift
//  Sort
//
//  Created by Paul Kraft on 13.12.15.
//  Copyright © 2015 Paul Kraft. All rights reserved.
//

class Number : Comparable, CustomStringConvertible
{
    private let value : Int
    var description : String {
        return "\(value)"
    }
    init(){
        value = Int(arc4random_uniform(UInt32.max))
    }
    init(_ value : Int){
        self.value = value
    }
    func getValue() -> Int {
        return value
    }
}

func ==(x: Number, y: Number) -> Bool {
    if x.value == y.value { return true }
    return false
}

func <(x: Number, y: Number) -> Bool {
    if x.value < y.value { return true }
    return false
}
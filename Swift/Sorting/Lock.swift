//
//  Lock.swift
//  Sort
//
//  Created by Paul Kraft on 15.02.16.
//  Copyright © 2016 kraft. All rights reserved.
//

import Cocoa

class Lock {
    private static let lock = NSLock()
    
    static func lockIt() {
        lock.lock()
    }
    
    static func unlockIt() {
        lock.unlock()
    }
}

//from https://gist.github.com/kristopherjohnson/d12877ee9a901867f599
func synchronized<T>(criticalSection: () -> T) -> T { //with return type
    Lock.lockIt()
    let a = criticalSection()
    Lock.unlockIt()
    return a
}

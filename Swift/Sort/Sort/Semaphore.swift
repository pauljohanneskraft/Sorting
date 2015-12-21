import Cocoa

//
//  Semaphor.swift
//  Sort
//
//  Created by Paul Kraft on 13.12.15.
//  Copyright © 2015 Paul Kraft. All rights reserved.
//

class Semaphore {
    private static let MAX = 13
    private static var count = 1
    private static let lock = NSLock()
    
    class func add(new: Int) -> Bool {
        return synchronized(lock) {
            if count + new <= MAX {
                count += new
                return true
            }
            return false
        }
    }
    
    class func delete(old: Int) {
        synchronized(lock) {
            count -= old
            if count < 0 {
                count = 0
                print("There are less threads actually running")
            }
        }
    }
}

//from https://gist.github.com/kristopherjohnson/d12877ee9a901867f599
func synchronized<L : NSLocking, T>(lock: L, criticalSection: () -> T) -> T { //with return type
    lock.lock()
    let a = criticalSection()
    lock.unlock()
    return a
}

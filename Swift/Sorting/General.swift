//
//  General.swift
//  Sorting
//
//  Created by Paul Kraft on 02.08.16.
//  Copyright © 2016 pauljohanneskraft. All rights reserved.
//

import Foundation

public extension Array {
    public func isSorted(by order: (Element, Element) throws -> Bool) rethrows -> Bool {
        for i in self.indices.dropLast() {
            if try order(self[i + 1], self[i]) {
                print(self[i + 1], "at", i + 1)
                print("\t<")
                print(self[i], "at", i)
                return false
            }
        }
        return true
    }
}

public extension Array where Element : Comparable {
    public var isSorted : Bool {
        return isSorted(by: { $0 < $1 })
    }
}

public extension ArraySlice {
    public func isSorted(by order: (Element, Element) throws -> Bool) rethrows -> Bool {
        for i in self.indices.dropLast() {
            if try order(self[i + 1], self[i]) {
                print(self[i + 1], "at", i + 1)
                print("\t<")
                print(self[i], "at", i)
                return false
            }
        }
        return true
    }
}

public extension ArraySlice where Element : Comparable {
    public var isSorted : Bool {
        return isSorted(by: { $0 < $1 })
    }
}

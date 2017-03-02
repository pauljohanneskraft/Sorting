//
//  General.swift
//  Sorting
//
//  Created by Paul Kraft on 02.08.16.
//  Copyright © 2016 pauljohanneskraft. All rights reserved.
//

import Foundation

infix operator <-> : AssignmentPrecedence
func <-> <T>( left: inout T, right: inout T) { swap(&left, &right) }

public extension SortableCollection {
    public func isSorted(by order: (Element, Element) throws -> Bool) rethrows -> Bool {
        for i in self.indices.dropLast() {
            if try order(self[i + 1], self[i]) { return false }
        }
        return true
    }
}

public extension SortableCollection where Element : Comparable {
    public var isSorted : Bool { return isSorted(by: <) }
}



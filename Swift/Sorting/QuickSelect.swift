//
//  QuickSelect.swift
//  Sorting
//
//  Created by Paul Kraft on 04.08.16.
//  Copyright © 2016 pauljohanneskraft. All rights reserved.
//

import Foundation

extension Array {
    
    public mutating func quickSelect(k: Int, by order: (Element, Element) throws -> Bool) rethrows -> Element {
        return try quickSelect(k: k, selectingIn: self.range, searchingIn: self.range, by: order)
    }
    
    public mutating func quickSelect(k: Int, in range: CountableRange<Int>, by order: (Element, Element) throws -> Bool) rethrows -> Element {
        return try quickSelect(k: k, selectingIn: range, searchingIn: range, by: order)
    }
    
    private mutating func quickSelect(k: Int, selectingIn selectionRange: CountableRange<Int>, searchingIn searchRange: CountableRange<Int>, by order: (Element, Element) throws -> Bool) rethrows -> Element {
        assert(searchRange.contains(k + searchRange.startIndex))
        // assert(selectionRange.contains(k + selectionRange.startIndex))
        let p = try partition(in: selectionRange, by: order)
        let kIndex = k - 1 + searchRange.startIndex
        if p > kIndex {
            let sRange = selectionRange.startIndex ..< p
            print(searchRange, selectionRange, sRange, p, self[selectionRange])
            return try quickSelect(k: k, selectingIn: sRange, searchingIn: searchRange, by: order)
        }
        if p < kIndex {
            let sRange = p + 1 ..< selectionRange.endIndex
            print(searchRange, selectionRange, sRange, p, self[selectionRange])
            return try quickSelect(k: k, selectingIn: sRange, searchingIn: searchRange, by: order)
        }
        return self[p]
    }
    
}

public extension Array where Element : Comparable {
    public mutating func quickSelect(_ k: Int) -> Element {
        return self.quickSelect(k: k, in: self.range, by: { $0 < $1 })
    }
    public mutating func quickSelect(_ k: Int, in range: CountableRange<Int>) -> Element {
        return self.quickSelect(k: k, in: range, by: { $0 < $1 })
    }
}

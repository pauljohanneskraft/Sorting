//
//  QuickSelect.swift
//  Sorting
//
//  Created by Paul Kraft on 04.08.16.
//  Copyright © 2016 pauljohanneskraft. All rights reserved.
//

import Foundation

extension SortableCollection {
    
    public func quickSelect(k: Int, by order: (Element, Element) throws -> Bool) rethrows -> Element {
        return try quickSelect(k: k, in: self.indices, by: order)
    }
    
    public func quickSelect(k: Int, in range: CountableRange<Int>, by order: (Element, Element) throws -> Bool) rethrows -> Element {
        var this = self
        return try this.quickSelect(k: k - 1 + range.startIndex, selectingIn: range, searchingIn: range, by: order)
    }
    
    private mutating func quickSelect(k: Int, selectingIn selectionRange: CountableRange<Int>, searchingIn searchRange: CountableRange<Int>, by order: (Element, Element) throws -> Bool) rethrows -> Element {
        assert(k > 0)
        assert(searchRange.count >= k)
        assert(searchRange.contains(selectionRange))
        
        // partition (like in QuickSort)
        let p = try partition(in: selectionRange, by: order)

        // unlike QuickSort, QuickSelect only recursively calls itself on half of the array
        if p > k {
            return try quickSelect(k: k, selectingIn: selectionRange.startIndex ..< p, searchingIn: searchRange, by: order)
        }
        if p < k {
            return try quickSelect(k: k, selectingIn: p + 1 ..< selectionRange.endIndex, searchingIn: searchRange, by: order)
        }
        return self[p]
    }
    
}

public extension SortableCollection where Element : Comparable {
    public func quickSelect(_ k: Int) -> Element {
        return self.quickSelect(k: k, in: self.indices, by: { $0 < $1 })
    }
    
    public func quickSelect(_ k: Int, in range: CountableRange<Int>) -> Element {
        return self.quickSelect(k: k, in: range, by: { $0 < $1 })
    }
}

public extension CountableRange {
    public func contains(_ range: CountableRange<Bound>) -> Bool {
        return self.startIndex <= range.startIndex && self.endIndex >= range.endIndex
    }
}

public extension SortableCollection where Element : Comparable {
    public func binarySearch(_ elem: Element) -> Int? {
        return binarySearch(elem, in: indices, orderedBy: { $0 < $1 })
    }
}

public extension SortableCollection where Element : Equatable {
    public func binarySearch(_ elem: Element, orderedBy order: (Element, Element) throws -> Bool) rethrows -> Int? {
        return try binarySearch(elem, in: self.indices, orderedBy: order)
    }
    
    /// needs a sorted array
    public func binarySearch(_ elem: Element, in range: CountableRange<Int>, orderedBy order: (Element, Element) throws -> Bool) rethrows -> Int? {
        
        // pivotIndex is in the middle --> (start + end) / 2
        let pivotIndex = (range.startIndex + range.endIndex) >> 1
        
        // pivot is element at pivotIndex
        let pivot = self[pivotIndex]
        
        // if they equal --> return index
        if pivot == elem { return pivotIndex }
        
        // if they don't equal and range <= 1 --> there is no such element
        guard range.count > 1 else { return nil }
        
        // elem < pivot
        if try order(elem, pivot) {
            // search in first half
            return try binarySearch(elem, in: range.startIndex ..< pivotIndex, orderedBy: order)
        } else { // pivot < elem
            // search in second half
            return try binarySearch(elem, in: pivotIndex ..< range.endIndex, orderedBy: order)
        }
    }
    
}



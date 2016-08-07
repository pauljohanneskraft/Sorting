//
//  RadixSort.swift
//  Sorting
//
//  Created by Paul Kraft on 02.08.16.
//  Copyright © 2016 pauljohanneskraft. All rights reserved.
//

import Foundation

public extension Sortable where Self.Iterator.Element == Self.Element {
    public mutating func radixSort(by order: (Element) throws -> Int) rethrows {
        // ...
        let digitsAtOnce = 8
        let buckets = (1 << digitsAtOnce)
        let hash = {
            (element: Int, digit: Int) -> Int in
            return (element >> (digit * digitsAtOnce)) % buckets
        }
        
        func kSort(digit: Int) throws {
            var buckets = [[Element]](repeating: [Element](), count: buckets)
            for e in self {
                buckets[hash(try order(e), digit)].append(e)
            }
            var i = 0
            for b in buckets {
                for v in b {
                    self[i] = v
                    i += 1
                }
            }
        }
        
        for d in 0..<((sizeof(Int.self) * 8) / digitsAtOnce) {
            try kSort(digit: d)
        }
    }
    
    /// needs O(n) space --> works on copy of itself and then copies back
    public mutating func radixSortInPlace(by order: (Element) throws -> Int) rethrows {
        // ...
        try self.radixSortInPlace(in: self.indices, by: order)
    }
    
    /// needs O(n) space --> works on copy of itself and then copies back
    public mutating func radixSortInPlace(in range: CountableRange<Int>, by order: (Element) throws -> Int) rethrows {
        // ...
        let digitsAtOnce = (range.count > 70_000 ? 16 : (range.count > 400 ? 8 : 4))
        let buckets = (1 << digitsAtOnce)
        let mask = buckets - 1
        let hash = {
            (element: Int, digit: Int) -> Int in
            return (element >> (digit * digitsAtOnce)) & mask
        }
        var this = self
        var counts = [Int](repeating: 0, count: buckets)
        var marker = [Int](repeating: range.startIndex, count: buckets)
        
        func kSort(digit: Int) throws {
            for c in counts.indices { counts[c] = 0 }
            for i in range {
                let h = hash(try order(self[i]), digit)
                counts[h] += 1
            }
            if counts[0] == range.count { return }
            marker[0] = range.startIndex
            for i in counts.indices.dropFirst() {
                marker[i] = counts[i - 1] + marker[i - 1]
            }
            for i in range {
                let h = hash(try order(self[i]), digit)
                let indexInArray = marker[h]
                swap(&self[i], &this[indexInArray])
                marker[h] += 1
            }
            self = this
        }
        
        for d in 0..<((sizeof(Int.self) * 8) / digitsAtOnce) {
            try kSort(digit: d)
        }
    }
}

public extension Array where Element : Hashable {
    public mutating func radixSort() {
        self.radixSort(by: { $0.hashValue })
    }
    public mutating func radixSortInPlace() {
        self.radixSortInPlace(in: self.indices, by: { $0.hashValue })
    }
    public mutating func radixSortInPlace(in range: CountableRange<Int>) {
        self.radixSortInPlace(in: range, by: { $0.hashValue })
    }
}




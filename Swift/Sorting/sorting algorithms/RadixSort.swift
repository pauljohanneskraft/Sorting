//
//  RadixSort.swift
//  Sorting
//
//  Created by Paul Kraft on 02.08.16.
//  Copyright © 2016 pauljohanneskraft. All rights reserved.
//

import Foundation

public extension Array {
    public mutating func radixSort(by order: (Element) throws -> Int) rethrows {
        let digitsAtOnce = 4
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
            // print(d, ",", terminator: "")
        }
    }
    
    // needs O(n) space --> works on copy of itself and the copies back
    public mutating func radixSortInPlace(by order: (Element) throws -> Int) rethrows {
        // ...
        let digitsAtOnce = 4
        let buckets = (1 << digitsAtOnce)
        let mask = buckets - 1
        let hash = {
            (element: Int, digit: Int) -> Int in
            return (element >> (digit * digitsAtOnce)) & mask
        }
        var this = self
        
        func kSort(digit: Int) throws {
            var counts = [Int](repeating: 0, count: buckets)
            for i in self.indices {
                let h = hash(try order(self[i]), digit)
                counts[h] += 1
            }
            if counts[0] == count { return }
            var marker = [Int](repeating: 0, count: buckets)
            marker[0] = 0
            for i in counts.indices.dropFirst() {
                marker[i] = counts[i - 1] + marker[i - 1]
            }
            for i in self.indices {
                let h = hash(try order(self[i]), digit)
                let indexInArray = marker[h]
                swap(&self[i], &this[indexInArray])
                marker[h] += 1
            }
            swap(&self, &this)
        }
        
        for d in 0..<((sizeof(Int.self) * 8) / digitsAtOnce) {
            try kSort(digit: d)
        }
    }
}

public extension Array where Element : Hashable {
    public mutating func radixSort() {
        radixSort(by: { $0.hashValue })
    }
    public mutating func radixSortInPlace() {
        radixSortInPlace(by: { $0.hashValue })
    }
}




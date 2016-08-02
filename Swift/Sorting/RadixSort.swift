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
    
    public mutating func radixSortInPlace(by order: (Element) throws -> Int) rethrows {
        
        let digitsAtOnce = 4
        let buckets = (1 << digitsAtOnce)
        let hash = {
            (element: Int, digit: Int) -> Int in
            return (element >> (digit * digitsAtOnce)) % buckets
        }
        
        func kSort(digit: Int) throws {
            var counts = [Int](repeating: 0, count: buckets)
            for e in self {
                let h = hash(try order(e), digit)
                print("\(e) hashed to \(h)")
                counts[h] += 1
            }
            var marker = [Int](repeating: 0, count: buckets)
            marker[0] = 0
            for i in counts.indices.dropFirst() {
                marker[i] = counts[i - 1] + marker[i - 1]
            }
            print(self)
            print(count, counts, "~>", marker)
            for i in self.indices {
                let h = hash(try order(self[i]), digit)
                print(self[i], "hashed to bucket:", h)
                let indexInArray = marker[h]
                print("hit marker", h, "resulting in index", indexInArray)
                if indexInArray != i && ( h < buckets - 1 ? indexInArray < marker[h + 1] : indexInArray < count) {
                    swap(&self[i], &self[indexInArray])
                    marker[h] += 1
                }
                
                print("incremented marker", h, "to value", marker[h])
                print(marker)
            }
        }
        
        for d in 0..<((sizeof(Int.self) * 8) / digitsAtOnce) {
            try kSort(digit: d)
            // print(d, ",", terminator: "")
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




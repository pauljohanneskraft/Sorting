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
            return (element >> (digit * digitsAtOnce)) % (2 * digitsAtOnce)
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
}

extension Array where Element : Hashable {
    public mutating func radixSort() {
        radixSort(by: { $0.hashValue })
    }
}




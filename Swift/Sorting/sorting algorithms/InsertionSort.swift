//
//  InsertionSort.swift
//  Sort
//
//  Created by Paul Kraft on 21.12.15.
//  Copyright © 2015 Paul Kraft. All rights reserved.
//

extension Array {
    
    public mutating func insertionSort(by order: (Element, Element) throws -> Bool) rethrows {
        try self.insertionSort(in: 0..<count, by: order)
    }
    
    mutating func insertionSort(in range: CountableRange<Int>, by order: (Element, Element) throws -> Bool) rethrows {
        for i in range {
            var k = range.startIndex
            while try k < i && order(self[k], self[i]) { k += 1 }
            self.insert(self.remove(at: i), at: k)
        }
    }
    
}

extension Array where Element : Comparable {
    public mutating func insertionSort() {
        self.insertionSort(by: { $0 < $1 })
    }
}

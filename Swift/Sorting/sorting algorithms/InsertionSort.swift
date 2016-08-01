//
//  InsertionSort.swift
//  Sort
//
//  Created by Paul Kraft on 21.12.15.
//  Copyright © 2015 Paul Kraft. All rights reserved.
//

extension Array where Element : Comparable {
    mutating func insertionSort(by order: (Element, Element) throws -> Bool = { $0 < $1 }) rethrows {
        for i in indices {
            var k = 0
            while try k < i && order(self[k], self[i]) { k += 1 }
            self.insert(self.remove(at: i), at: k)
        }
    }
}

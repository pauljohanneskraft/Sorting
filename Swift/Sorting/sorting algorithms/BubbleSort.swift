//
//  BubbleSort.swift
//  Sort
//
//  Created by Paul Kraft on 21.12.15.
//  Copyright © 2015 Paul Kraft. All rights reserved.
//

extension Array {
    public mutating func bubbleSort(by order: (Element, Element) throws -> Bool) rethrows {
        // ...
        try self.bubbleSort(in: self.indices, by: order)
    }
    
    public mutating func bubbleSort(in range: CountableRange<Int>, by order: (Element, Element) throws -> Bool) rethrows {
        // ...
        guard range.count > 1 else { return }
        var didChange = false
        repeat {
            didChange = false
            for i in range.dropLast() {
                if try order(self[i+1], self[i]) {
                    didChange = true
                    swap(&self[i], &self[i+1])
                }
            }
        } while didChange
    }
}

extension Array where Element : Comparable {
    public mutating func bubbleSort() {
        self.bubbleSort(by: { $0 < $1 })
    }
}

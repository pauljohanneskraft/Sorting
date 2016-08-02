//
//  SelectionSort.swift
//  Sort
//
//  Created by Paul Kraft on 21.12.15.
//  Copyright © 2015 Paul Kraft. All rights reserved.
//

extension Array {
    public mutating func selectionSort(by order: (Element, Element) throws -> Bool) rethrows {
        for l in indices {
            var min = l
            for i in l+1..<count {
                if try order(self[i], self[min]) { min = i }
            }
            if l != min { swap(&self[l], &self[min]) }
        }
    }
}

extension Array where Element : Comparable {
    public mutating func selectionSort() {
        self.selectionSort(by: { $0 < $1 })
    }
}

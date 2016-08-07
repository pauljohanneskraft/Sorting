//
//  SelectionSort.swift
//  Sort
//
//  Created by Paul Kraft on 21.12.15.
//  Copyright © 2015 Paul Kraft. All rights reserved.
//

extension SortableCollection {
    public mutating func selectionSort(by order: (Element, Element) throws -> Bool) rethrows {
        // ...
        try self.selectionSort(in: self.indices, by: order)
    }
    
    public mutating func selectionSort(in range: CountableRange<Int>, by order: (Element, Element) throws -> Bool) rethrows {
        // ...
        // an array with 1 element doesn't need to be sorted
        guard range.count > 1 else { return }
        
        for l in range {
            var min = l
            for i in l+1..<range.endIndex {
                if try order(self[i], self[min]) { min = i }
            }
            if l != min { swap(&self[l], &self[min]) }
        }
    }
}

extension SortableCollection where Element : Comparable {
    public mutating func selectionSort() {
        self.selectionSort(by: { $0 < $1 })
    }
}

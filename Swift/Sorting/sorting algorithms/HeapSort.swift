//
//  HeapSort.swift
//  Sort
//
//  Created by Paul Kraft on 21.12.15.
//  Copyright © 2015 Paul Kraft. All rights reserved.
//

extension SortableCollection {
    
    mutating func heapSort(by order: (Element, Element) throws -> Bool) rethrows {
        // ...
        try self.heapSort(in: self.indices, by: order)
    }
    
    // O(n log n)
    mutating func heapSort(in range: CountableRange<Int>, by order: (Element, Element) throws -> Bool) rethrows {
        // ...
        guard range.count > 1 else { return }
        
        try generateMaxHeap(in: range, by: order) // O(n log n)
        
        for i in range.reversed() { // O(n)
            
            swap(&self[i], &self[range.startIndex]) // O(1)
            
            // siftDown to ensure invariant
            try siftDown(index: range.startIndex, in: range.startIndex..<i, by: order) // O(log n)
			
        } // loop: O(n log n)
    }
    
    // O(n log n)
    private mutating func generateMaxHeap(in range: CountableRange<Int>, by order: (Element, Element) throws -> Bool) rethrows {
        // ...
        
        // r = 0 ..< (n/2) but in a specific range (n is count)
        let r = ((range.startIndex)..<((range.count >> 1) + range.startIndex)).reversed() // O(n)
        
        for i in r {
            try siftDown(index: i, in: range, by: order) // O(log n)
        }
    }
    
    // O(log n)
    private mutating func siftDown(index: Int, in range: CountableRange<Int>, by order: (Element, Element) throws -> Bool) rethrows {
        // ...
        var i = index
        while true {
            // Index of left child
            var child = ((i+1-range.startIndex) << 1) - 1 + range.startIndex
            
            // is left child in range? / is there a left child?
            guard range.contains(child) else { return }
            
            // right child exists
            if range.contains(child + 1) {
                
                // left child < right child
                if try order(self[child], self[child + 1]) {
                    child += 1 // right child
                }
            }
            
            // self[i] < self[child]
            if try order(self[i], self[child]) {
                swap(&self[i], &self[child])
                i = child // sifting down child then
            } else { return }
        }
    }
}

extension SortableCollection where Element : Comparable {
    public mutating func heapSort() {
        self.heapSort(in: self.indices, by: { $0 < $1 })
    }
}


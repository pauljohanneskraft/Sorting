//
//  ShellSort.swift
//  Sort
//
//  Created by Paul Kraft on 21.12.15.
//  Copyright © 2015 Paul Kraft. All rights reserved.
//

extension SortableCollection {
    public mutating func shellSort
        (by order: (Element, Element) throws -> Bool) rethrows {
        try shellSort(in: self.indices, by: order)
    }
    
    public mutating func shellSort(in range: CountableRange<Int>, by order: (Element, Element) throws -> Bool) rethrows {
        // ...
        guard range.count > 1 else { return }
        
        // f_{k} = 2^k-1, but in reverse
        let columns = [8388607, 4194303, 2097151, 1048575, 524287, 262143, 131071, 65535, 32767, 16383, 8191, 4095, 2047, 1023, 511, 255, 127, 63, 31, 15, 7, 3, 1]
        
        var s = 0
        while columns[s] > range.count { s += 1 }
        
        for k in s..<columns.count {
            let gap = columns[k]
            
            for i in (range.startIndex + gap)..<range.endIndex {
                let t = self[i]
                var j = i
                while try j >= gap && order(t, self[j-gap]) {
                    self[j] = self[j-gap]
                    j = j - gap
                }
                self[j] = t
            }
        }
    }
}

extension SortableCollection where Element : Comparable {
    public mutating func shellSort() {
        self.shellSort { $0 < $1 }
    }
}


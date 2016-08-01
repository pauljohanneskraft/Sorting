//
//  ShellSort.swift
//  Sort
//
//  Created by Paul Kraft on 21.12.15.
//  Copyright © 2015 Paul Kraft. All rights reserved.
//

extension Array where Element : Comparable {
    mutating func shellSort(by order: (Element, Element) throws -> Bool = { $0 < $1 }) rethrows {
        // f_{k} = 2^k-1, but in reverse
        let columns = [8388607, 4194303, 2097151, 1048575, 524287, 262143, 131071, 65535, 32767, 16383, 8191, 4095, 2047, 1023, 511, 255, 127, 63, 31, 15, 7, 3, 1]
        var s = 0
        while columns[s] > count { s += 1 }
        
        for k in s..<columns.count {
            let h = columns[k]
            
            for i in h..<count - 1 {
                let t = self[i];
                var j = i;
                while try j >= h && order(t, self[j-h]) {
                    self[j] = self[j-h];
                    j = j - h;
                }
                self[j] = t;
            }
        }
    }
}


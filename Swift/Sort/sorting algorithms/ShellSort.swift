//
//  ShellSort.swift
//  Sort
//
//  Created by Paul Kraft on 21.12.15.
//  Copyright © 2015 Paul Kraft. All rights reserved.
//

// f_{k} = 2^k-1, but in reverse
private let columns = [8388607, 4194303, 2097151, 1048575, 524287, 262143, 131071, 65535, 32767, 16383, 8191, 4095, 2047, 1023, 511, 255, 127, 63, 31, 15, 7, 3, 1]

func shellSort<T: Comparable>(array: [T]) -> (name:String, array:[T]) {
    var sorted = array
    shellSort(&sorted)
    return ("ShellSort", sorted)
}

func shellSort<T: Comparable>(inout array: [T]) {
    shellSort(&array, 0..<array.count)
}

func shellSort<T: Comparable>(inout array: [T], _ range: Range<Int>) {
    var s = 0
    while columns[s] > range.count { s++ }
    
    for k in s..<columns.count {
        let h = columns[k] + range.minElement()!;
        
        // Sortiere die "Spalten" mit Insertionsort
        for i in h..<range.endIndex {
            let t = array[i];
            var j = i;
            while j >= h && array[j-h] > t {
                array[j] = array[j-h];
                j = j - h;
            }
            array[j] = t;
        }
    }}

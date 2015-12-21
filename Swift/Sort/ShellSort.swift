//
//  ShellSort.swift
//  Sort
//
//  Created by Paul Kraft on 21.12.15.
//  Copyright © 2015 Paul Kraft. All rights reserved.
//

func shellSort<T: Comparable>(var unsorted: [T]) -> (name:String, array:[T]) {
    // f_{k} = 2^k-1, but in reverse
    var spalten = [8388607, 4194303, 2097151, 1048575, 524287, 262143, 131071, 65535, 32767, 16383, 8191, 4095, 2047, 1023, 511, 255, 127, 63, 31, 15, 7, 3, 1]
    var s = 0
    while spalten[s] > unsorted.count { s++ }
    for k in s..<spalten.count {
        let h = spalten[k];
        // Sortiere die "Spalten" mit Insertionsort
        for i in h..<unsorted.count {
            let t = unsorted[i];
            var j = i;
            while (j >= h && unsorted[j-h] > t)
            {
                unsorted[j] = unsorted[j-h];
                j = j - h;
            }
            unsorted[j] = t;
        }
    }
    return ("ShellSort",unsorted)
}
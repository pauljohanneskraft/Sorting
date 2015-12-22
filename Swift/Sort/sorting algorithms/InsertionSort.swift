//
//  InsertionSort.swift
//  Sort
//
//  Created by Paul Kraft on 21.12.15.
//  Copyright © 2015 Paul Kraft. All rights reserved.
//

func insertionSort<T: Comparable>(unsorted: [T]) -> (String, [T]) {
    var sorted : [T] = []
    for i in 0..<unsorted.count {
        sorted.append(unsorted[i]);
    }
    for i in 0..<sorted.count {
        var k = 0
        while(k < i && sorted[k] < sorted[i]) { k++ }
        sorted.insert(sorted.removeAtIndex(i), atIndex: k)
    }
    return ("InsertionSort", sorted)
}

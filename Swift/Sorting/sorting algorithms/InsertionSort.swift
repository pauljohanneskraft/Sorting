//
//  InsertionSort.swift
//  Sort
//
//  Created by Paul Kraft on 21.12.15.
//  Copyright © 2015 Paul Kraft. All rights reserved.
//

func insertionSort<T: Comparable>(array: [T]) -> (name: String, array: [T]) {
    var sorted = array
    insertionSort(&sorted)
    return ("InsertionSort", sorted)
}

func insertionSort<T: Comparable>(inout array: [T]) {
    insertionSort(&array, 0..<array.count)
}

func insertionSort<T: Comparable>(inout array: [T], _ range: Range<Int>) {
    for i in range {
        var k = range.startIndex
        while(k < i && array[k] < array[i]) { k += 1 }
        array.insert(array.removeAtIndex(i), atIndex: k)
    }
}


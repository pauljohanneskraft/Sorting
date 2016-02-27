//
//  SelectionSort.swift
//  Sort
//
//  Created by Paul Kraft on 21.12.15.
//  Copyright © 2015 Paul Kraft. All rights reserved.
//

func selectionSort<T: Comparable>(array: [T]) -> (name: String, array: [T]) {
    var sorted = array
    selectionSort(&sorted)
    return ("SelectionSort", sorted)
}

func selectionSort<T: Comparable>(inout array: [T]) {
    selectionSort(&array, 0..<array.count)
}

func selectionSort<T: Comparable>(inout array: [T], _ range: Range<Int>) {
    for left in range {
        var min = left
        for i in left+1..<array.count {
            if(array[i] < array[min]) { min = i }
        }
        array[left] <-> array[min]
    }
}
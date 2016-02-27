//
//  BubbleSort.swift
//  Sort
//
//  Created by Paul Kraft on 21.12.15.
//  Copyright © 2015 Paul Kraft. All rights reserved.
//

// out-of-place variant, just copies array and then calls the in-place variant
func bubbleSort<T: Comparable>(unsorted: [T]) -> (name: String, array: [T]) {
    var array = unsorted
    bubbleSort(&array)
    return ("BubbleSort", array)
}

// in-place-variant
func bubbleSort<T: Comparable>(inout unsorted: [T]) {
    bubbleSort(&unsorted, 0..<unsorted.count)
}

// in-place-variant for a specific range
func bubbleSort<T: Comparable>(inout unsorted: [T], _ range: Range<Int>) {
    var didChange = false
    repeat {
        didChange = false
        for i in range.dropLast() {
            if unsorted[i+1] < unsorted[i] {
                didChange = true
                unsorted[i] <-> unsorted[i+1]
            }
        }
    } while(didChange)
}
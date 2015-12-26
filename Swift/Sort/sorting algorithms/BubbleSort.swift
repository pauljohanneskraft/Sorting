//
//  BubbleSort.swift
//  Sort
//
//  Created by Paul Kraft on 21.12.15.
//  Copyright © 2015 Paul Kraft. All rights reserved.
//

func bubbleSort<T: Comparable>(var unsorted: [T]) -> (name: String, array: [T]) {
    var didChange = false
    repeat
    {
        didChange = false
        for i in 0..<unsorted.count - 1 {
            if unsorted[i+1] < unsorted[i] {
                didChange = true
                (unsorted[i], unsorted[i+1]) = (unsorted[i+1], unsorted[i])
            }
        }
    }
    while(didChange)
    return ("BubbleSort", unsorted)
}

func bubbleSortInPlace<T: Comparable>(inout unsorted: [T]) -> (name: String, array: [T]) {
    var didChange = false
    repeat
    {
        didChange = false
        for i in 0..<unsorted.count - 1 {
            if unsorted[i+1] < unsorted[i] {
                didChange = true
                (unsorted[i], unsorted[i+1]) = (unsorted[i+1], unsorted[i])
            }
        }
    }
        while(didChange)
    return ("BubbleSort", unsorted)
}
//
//  BubbleSort.swift
//  Sort
//
//  Created by Paul Kraft on 21.12.15.
//  Copyright © 2015 Paul Kraft. All rights reserved.
//

func bubbleSort<T: Comparable>(unsorted: [T]) -> (name: String, array: [T]) {
    var sorted : [T] = []
    for i in 0..<unsorted.count{
        sorted.append(unsorted[i]);
    }
    var didChange = false
    repeat
    {
        didChange = false
        for i in 0..<sorted.count - 1 {
            if sorted[i+1] < sorted[i] {
                didChange = true
                sorted.insert(sorted.removeAtIndex(i+1), atIndex: i);
            }
        }
    }
    while(didChange)
    return ("BubbleSort", sorted)
}

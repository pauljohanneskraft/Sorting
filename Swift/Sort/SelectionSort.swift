//
//  SelectionSort.swift
//  Sort
//
//  Created by Paul Kraft on 21.12.15.
//  Copyright © 2015 Paul Kraft. All rights reserved.
//

import Cocoa

func selectionSort<T: Comparable>(var unsorted: [T]) -> (name: String, array: [T]) {
    var links = 0
    repeat {
        var min = links
        for i in links+1..<unsorted.count {
            if(unsorted[i] < unsorted[min]) { min = i }
        }
        (unsorted[links], unsorted[min]) = (unsorted[min], unsorted[links])
        links = links + 1
    }
        while (links < unsorted.count);
    return ("SelectionSort", unsorted)
}

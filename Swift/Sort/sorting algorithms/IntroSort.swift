//
//  IntroSort.swift
//  Sort
//
//  Created by Paul Kraft on 21.12.15.
//  Copyright © 2015 Paul Kraft. All rights reserved.
//

import Cocoa
import Foundation

func introSortMedianThreaded<T: Comparable>(unsorted: [T]) -> (String, [T]) {
    return ("IntroSortMedianThreaded", introSortMedianThreadedRecursive(unsorted, Int(floor(log(Double(unsorted.count))))))
}

private func introSortMedianThreadedRecursive<T: Comparable>(unsorted: [T], _ maxDepth: Int) -> [T] {
    if unsorted.count <  2 { return unsorted } //empty or one element
    if unsorted.count < 17 { return shellSort(unsorted).array }
    if maxDepth == 0       { return heapSort(unsorted).array }
    var l : [T] = []
    var r : [T] = []
    let pivotIndex = unsorted.count/2
    let pivot = unsorted[pivotIndex]
    for i in 0..<pivotIndex {
        if unsorted[i] < pivot { l.append(unsorted[i]) }
        else { r.append(unsorted[i]) }
    }
    for i in pivotIndex+1..<unsorted.count {
        if unsorted[i] < pivot { l.append(unsorted[i]) }
        else { r.append(unsorted[i]) }
    }
    if unsorted.count > 100 && Semaphore.add(2) {
        let group = dispatch_group_create();
        dispatch_group_async(group,dispatch_get_global_queue(QOS_CLASS_USER_INTERACTIVE, 0), {
            r = introSortMedianThreadedRecursive(r, maxDepth - 1)
        });
        dispatch_group_async(group,dispatch_get_global_queue(QOS_CLASS_USER_INTERACTIVE, 0), {
            l = introSortMedianThreadedRecursive(l, maxDepth - 1)
        });
        dispatch_group_wait(group, DISPATCH_TIME_FOREVER)
        Semaphore.delete(2)
    }
    else {
        r = introSortMedianThreadedRecursive(r, maxDepth - 1)
        l = introSortMedianThreadedRecursive(l, maxDepth - 1)
    }
    l.append(pivot)
    return l + r
}

func introSortMedian<T: Comparable>(unsorted: [T]) -> (String, [T]) {
    return ("IntroSortMedian", introSortMedianRecursive(unsorted, Int(floor(log(Double(unsorted.count))))))
}

private func introSortMedianRecursive<T: Comparable>(unsorted: [T], _ maxDepth: Int) -> [T] {
    if unsorted.count <  2 { return unsorted } //empty or one element
    if unsorted.count < 17 { return selectionSort(unsorted).array }
    if maxDepth == 0       { return heapSort(unsorted).array }
    var l : [T] = []
    var r : [T] = []
    let pivotIndex = unsorted.count/2
    let pivot = unsorted[pivotIndex]
    for i in 0..<pivotIndex {
        if unsorted[i] < pivot { l.append(unsorted[i]) }
        else { r.append(unsorted[i]) }
    }
    for i in pivotIndex+1..<unsorted.count {
        if unsorted[i] < pivot { l.append(unsorted[i]) }
        else { r.append(unsorted[i]) }
    }
    r = introSortMedianRecursive(r, maxDepth - 1)
    l = introSortMedianRecursive(l, maxDepth - 1)
    l.append(pivot)
    return l + r
}


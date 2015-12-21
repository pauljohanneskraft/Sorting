//
//  MergeSort.swift
//  Sort
//
//  Created by Paul Kraft on 21.12.15.
//  Copyright © 2015 Paul Kraft. All rights reserved.
//

import Cocoa

func mergeSort<T: Comparable>(unsorted: [T]) -> (String, [T]) {
    return ("MergeSort", mergeSortRecursive(unsorted))
}

private func mergeSortRecursive<T: Comparable>(unsorted: [T]) -> [T] {
    if unsorted.count < 2 { return unsorted }
    let one = mergeSortRecursive(unsorted[0..<unsorted.count/2] + [])
    let two = mergeSortRecursive(unsorted[unsorted.count/2..<unsorted.count] + [])
    return merge(one, two)
}

private func merge<T: Comparable>(var one: [T], var _ two: [T]) -> [T] {
    var res : [T] = []
    while one.count > 0 && two.count > 0 {
        if one[0] <= two[0] { res.append(one.removeAtIndex(0)) }
        else                { res.append(two.removeAtIndex(0)) }
    }
    while one.count > 0     { res.append(one.removeAtIndex(0)) }
    while two.count > 0     { res.append(two.removeAtIndex(0)) }
    return res
}

func mergeSortThreaded<T: Comparable>(unsorted: [T]) -> (String, [T]) {
    return ("MergeSortThreaded", mergeSortThreadedRecursive(unsorted))
}

private func mergeSortThreadedRecursive<T: Comparable>(unsorted: [T]) -> [T] {
    if unsorted.count < 2 { return unsorted }
    var l : [T] = []
    var r : [T] = []
    if Semaphore.add(2) {
        let group = dispatch_group_create();
        dispatch_group_async(group,dispatch_get_global_queue(QOS_CLASS_USER_INTERACTIVE, 0), {
            l = mergeSortThreadedRecursive(unsorted[0..<unsorted.count/2] + [])
        });
        dispatch_group_async(group,dispatch_get_global_queue(QOS_CLASS_USER_INTERACTIVE, 0), {
            r = mergeSortThreadedRecursive(unsorted[unsorted.count/2..<unsorted.count] + [])
        });
        dispatch_group_wait(group, DISPATCH_TIME_FOREVER)
        Semaphore.delete(2)
    }
    else {
        l = mergeSortThreadedRecursive(unsorted[0..<unsorted.count/2] + [])
        r = mergeSortThreadedRecursive(unsorted[unsorted.count/2..<unsorted.count] + [])
    }
    return merge(l, r)
}
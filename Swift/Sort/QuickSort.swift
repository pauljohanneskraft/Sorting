//
//  QuickSort.swift
//  Sort
//
//  Created by Paul Kraft on 21.12.15.
//  Copyright © 2015 Paul Kraft. All rights reserved.
//

import Cocoa

func quickSortFirst<T: Comparable>(unsorted: [T]) -> (name: String, array: [T]) {
    if unsorted.count < 2 { return ("QuickSortFirst", unsorted) }
    var l : [T] = []
    var r : [T] = []
    let pivot = unsorted[0]
    for i in 1..<unsorted.count {
        if unsorted[i] < pivot { l.append(unsorted[i]) }
        else { r.append(unsorted[i]) }
    }
    r = quickSortFirst(r).array
    l = quickSortFirst(l).array
    l.append(pivot)
    return ("QuickSortFirst", l + r)
}

func quickSortFirstThreaded<T: Comparable>(unsorted: [T]) -> (name: String, array: [T]) {
    return ("QuickSortFirstThreaded", quickSortFirstThreadedRecursive(unsorted))
}

private func quickSortFirstThreadedRecursive<T: Comparable>(unsorted: [T]) -> [T]
{
    if unsorted.count < 2 { return unsorted }
    var l : [T] = []
    var r : [T] = []
    let pivot = unsorted[0]
    for i in 1..<unsorted.count {
        if unsorted[i] < pivot { l.append(unsorted[i]) }
        else { r.append(unsorted[i]) }
    }
    
    if Semaphore.add(2) {
        let group = dispatch_group_create();
        dispatch_group_async(group,dispatch_get_global_queue(QOS_CLASS_USER_INTERACTIVE, 0), {
            r = quickSortFirstThreadedRecursive(r)
        });
        dispatch_group_async(group,dispatch_get_global_queue(QOS_CLASS_USER_INTERACTIVE, 0), {
            l = quickSortFirstThreadedRecursive(l)
        });
        dispatch_group_wait(group, DISPATCH_TIME_FOREVER)
        Semaphore.delete(2)
    }
    else {
        r = quickSortFirstThreadedRecursive(r)
        l = quickSortFirstThreadedRecursive(l)
    }
    l.append(pivot)
    return l + r
}


func quickSortRandom<T: Comparable>(unsorted: [T]) -> (name: String, array: [T]) {
    return ("QuickSortRandom", quickSortRandomRecursive(unsorted))
}

private func quickSortRandomRecursive<T: Comparable>(unsorted: [T]) -> [T]
{
    if unsorted.count < 2 { return unsorted } //empty or one element
    var l : [T] = []
    var r : [T] = []
    if unsorted.count > 0 {
        let pivotIndex = Int(arc4random_uniform(UInt32(unsorted.count)))
        let pivot = unsorted[pivotIndex]
        for i in 0..<pivotIndex {
            if unsorted[i] < pivot { l.append(unsorted[i]) }
            else { r.append(unsorted[i]) }
        }
        for i in pivotIndex+1..<unsorted.count {
            if unsorted[i] < pivot { l.append(unsorted[i]) }
            else { r.append(unsorted[i]) }
        }
        r = quickSortRandomRecursive(r)
        l = quickSortRandomRecursive(l)
        l.append(pivot)
    }
    return l + r
}

func quickSortMedian<T: Comparable>(unsorted: [T]) -> (name: String, array: [T]) {
    return ("QuickSortMedian", quickSortMedianRecursive(unsorted))
}

private func quickSortMedianRecursive<T: Comparable>(unsorted: [T]) -> [T] {
    if unsorted.count < 2 { return unsorted } //empty or one element
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
    r = quickSortMedianRecursive(r)
    l = quickSortMedianRecursive(l)
    l.append(pivot)
    return l + r
}

func quickSortRandomThreaded<T: Comparable>(unsorted: [T]) -> (name: String, array: [T]) {
    return ("QuickSortRandomThreaded", quickSortRandomThreadedRecursive(unsorted))
}

private func quickSortRandomThreadedRecursive<T: Comparable>(unsorted: [T]) -> [T] {
    if unsorted.count < 2 { return unsorted }
    var l : [T] = []
    var r : [T] = []
    let pivotIndex = Int(arc4random_uniform(UInt32(unsorted.count)))
    let pivot = unsorted[pivotIndex]
    for i in 0..<unsorted.count {
        if (i != pivotIndex) {
            if unsorted[i] < pivot { l.append(unsorted[i]) }
            else                   { r.append(unsorted[i]) }
        }
    }
    if Semaphore.add(2) {
        let group = dispatch_group_create();
        dispatch_group_async(group,dispatch_get_global_queue(QOS_CLASS_USER_INTERACTIVE, 0), {
            r = quickSortRandomThreadedRecursive(r)
        });
        
        dispatch_group_async(group,dispatch_get_global_queue(QOS_CLASS_USER_INTERACTIVE, 0), {
            l = quickSortRandomThreadedRecursive(l)
        });
        dispatch_group_wait(group, DISPATCH_TIME_FOREVER)
        Semaphore.delete(2)
    }
    else
    {
        r = quickSortRandomThreadedRecursive(r)
        l = quickSortRandomThreadedRecursive(l)
    }
    l.append(pivot)
    return l + r
}

func quickSortMedianThreaded<T: Comparable>(unsorted: [T]) -> (name: String, array: [T]) {
    return ("QuickSortMedianThreaded", quickSortMedianThreadedRecursive(unsorted))
}

private func quickSortMedianThreadedRecursive<T: Comparable>(unsorted: [T]) -> [T] {
    if unsorted.count < 2 { return unsorted }
    var l : [T] = []
    var r : [T] = []
    let pivotIndex = unsorted.count/2
    let pivot = unsorted[pivotIndex]
    for i in 0..<unsorted.count {
        if (i != pivotIndex) {
            if unsorted[i] < pivot { l.append(unsorted[i]) }
            else                   { r.append(unsorted[i]) }
        }
    }
    if Semaphore.add(2) {
        let group = dispatch_group_create();
        dispatch_group_async(group,dispatch_get_global_queue(QOS_CLASS_USER_INTERACTIVE, 0), {
            r = quickSortMedianThreadedRecursive(r)
        });
        
        dispatch_group_async(group,dispatch_get_global_queue(QOS_CLASS_USER_INTERACTIVE, 0), {
            l = quickSortMedianThreadedRecursive(l)
        });
        dispatch_group_wait(group, DISPATCH_TIME_FOREVER)
        Semaphore.delete(2)
    }
    else
    {
        r = quickSortMedianThreadedRecursive(r)
        l = quickSortMedianThreadedRecursive(l)
    }
    l.append(pivot)
    return l + r
}

func quickSortInPlace<T: Comparable>(unsorted: [T]) -> (name: String, array: [T]) {
    var sorted : [T] = []
    for i in 0..<unsorted.count {
        sorted.append(unsorted[i])
    }
    quickSortInPlaceRecursive(&sorted, 0, sorted.count - 1)
    return ("quickSortInPlace", sorted)
}

private func quickSortInPlaceRecursive<T: Comparable>(inout sorted: [T], _ start : Int, _ end: Int)
{
    if end > start {
        let pivot : Int
        pivot = quickSortInPlacePartition(&sorted, start, end)
        quickSortInPlaceRecursive(&sorted, start, pivot - 1)
        quickSortInPlaceRecursive(&sorted, pivot + 1, end)
    }
}

private func quickSortInPlacePartition<T: Comparable>(inout sorted: [T], _ start : Int, _ end: Int) -> Int
{
    var i = start
    for j in (start + 1)...end {
        if sorted[j] < sorted[start] {
            i++
            (sorted[i], sorted[j]) = (sorted[j], sorted[i])
        }
    }
    (sorted[i], sorted[start]) = (sorted[start], sorted[i])
    return i
}

func quickSortInPlaceThreaded<T: Comparable>(unsorted: [T]) -> (name: String, array: [T]) {
    var sorted : [T] = []
    for i in 0..<unsorted.count {
        sorted.append(unsorted[i])
    }
    return ("quickSortInPlaceThreaded", quickSortInPlaceThreadedRecursive(sorted))
}

private func quickSortInPlaceThreadedRecursive<T: Comparable>(var sorted: [T]) -> [T]
{
    if sorted.count < 2 { return sorted }
    let pivot = quickSortInPlaceThreadedPartition(&sorted)
    var sortedleft:[T] = [], sortedright:[T] = []
    if Semaphore.add(2) {
        let group = dispatch_group_create();
        dispatch_group_async(group,dispatch_get_global_queue(QOS_CLASS_USER_INTERACTIVE, 0), {
            sortedleft  = quickSortInPlaceThreadedRecursive(sorted[0..<pivot] + [])
        });
        
        dispatch_group_async(group,dispatch_get_global_queue(QOS_CLASS_USER_INTERACTIVE, 0), {
            sortedright = quickSortInPlaceThreadedRecursive(sorted[pivot+1..<sorted.count] + [])
        });
        dispatch_group_wait(group, DISPATCH_TIME_FOREVER)
        Semaphore.delete(2)
    }
    else
    {
        sortedleft  = quickSortInPlaceThreadedRecursive(sorted[0..<pivot] + [])
        sortedright = quickSortInPlaceThreadedRecursive(sorted[pivot+1..<sorted.count] + [])
    }
    return sortedleft + sorted[pivot...pivot] + sortedright
}

private func quickSortInPlaceThreadedPartition<T: Comparable>(inout sorted: [T]) -> (Int)
{
    var i = 0
    for j in 1...(sorted.count-1) {
        if sorted[j] < sorted[0] {
            i++
            (sorted[i], sorted[j]) = (sorted[j], sorted[i])
        }
    }
    (sorted[i], sorted[0]) = (sorted[0], sorted[i])
    return i
}


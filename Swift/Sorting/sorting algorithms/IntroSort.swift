
//
//  IntroSort.swift
//  Sort
//
//  Created by Paul Kraft on 21.12.15.
//  Copyright © 2015 Paul Kraft. All rights reserved.
//

import Cocoa
import Foundation

func introSortInPlace<T: Comparable>(inout unsorted: [T]) -> (String, [T]) {
    let maxDepth = Int(log2(Double(unsorted.count)))
    introSortInPlaceRecursive(&unsorted, 0..<unsorted.count, maxDepth)
    return ("IntroSortInPlace", unsorted)
}

func introSortInPlace<T: Comparable>(unsorted: [T]) -> (String, [T]) {
    var sorted = unsorted
    return introSortInPlace(&sorted)
}

private func introSortInPlaceRecursive<T: Comparable>(inout unsorted: [T], _ range : Range<Int>, _ depthLimit: Int){
    if range.count < 20 {
        insertionSort(&unsorted, range)
        return
    }
    if depthLimit == 0 {
        shellSort(&unsorted, range)
        //heapSort(&unsorted, range)
        //quickSortInPlace(&unsorted)
        return
    }
    print("did run")
    let pivot:Int = partition(&unsorted, range)
    introSortInPlaceRecursive(&unsorted, range.startIndex..<pivot, depthLimit - 1)
    introSortInPlaceRecursive(&unsorted, (pivot+1)..<range.endIndex, depthLimit - 1)
}

/*
private func partitionInPlace<T: Comparable>(inout unsorted : [T], _ range: Range<Int>) -> Int {
    var low :Int = range.startIndex
    var high:Int = range.endIndex-1
    
    if low == high {
        return low
    }
    
    let pivot = unsorted[range.startIndex]
    
    while low < high {
        while unsorted[low] < pivot {
            low++
            if low == high {
                (unsorted[low], unsorted[high]) = (unsorted[high], unsorted[low])
                return low
            }
        }
        
        while unsorted[high] > pivot {
            high--
            if low == high {
                (unsorted[low], unsorted[high]) = (unsorted[high], unsorted[low])
                return low
            }
        }
        (unsorted[low], unsorted[high]) = (unsorted[high], unsorted[low])
    }
    return low
}
*/
/*
private func insertionSort<T:Comparable>(inout unsorted: [T], _ left: Int, _ right: Int) {
    for i in left..<right {
        var k = left
        while(k < i && unsorted[k] < unsorted[i]) { k++ }
        unsorted[i] <-> unsorted[k]
    }
}*/

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
    if unsorted.count > 100 && Semaphore.tryThreaded(2, {
        let group = dispatch_group_create();
        dispatch_group_async(group,dispatch_get_global_queue(QOS_CLASS_USER_INTERACTIVE, 0), {
            r = introSortMedianThreadedRecursive(r, maxDepth - 1)
        });
        dispatch_group_async(group,dispatch_get_global_queue(QOS_CLASS_USER_INTERACTIVE, 0), {
            l = introSortMedianThreadedRecursive(l, maxDepth - 1)
        });
        dispatch_group_wait(group, DISPATCH_TIME_FOREVER)
    }){}
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
    if unsorted.count < 20 { return selectionSort(unsorted).array }
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


func introSortInPlaceNew<T: Comparable>(array: [T]) -> (String, [T]) {
    var sorted = array
    introSortInPlaceRecursiveNew(&sorted, 0, sorted.count - 1, 10)
    return ("introSortInPlace", sorted)
}

private func introSortInPlaceRecursiveNew<T: Comparable>(inout array: [T], _ left: Int, _ right: Int, _ depthlimit: Int){
    if right < left { return }
    if right - left < 20 {
        //insertionSort(&array, left, right)
        //return
    }
    
    if depthlimit <= 0 {
        //heapSort(&array, left..<right)
        //return
    }
    /*
    let pivot = partitionInPlace(&array, left, right)
    introSortInPlaceRecursiveNew(&array, left, pivot - 1, depthlimit - 1)
    introSortInPlaceRecursiveNew(&array, pivot + 1, right, depthlimit - 1)
    */
}

/*
private func partitionInPlace<T:Comparable>(inout array: [T], _ left: Int, _ right: Int) -> Int {
    var i = left
    var j = right - 1
    let pivot = right
    
    repeat {
        while array[i] < array[pivot] && i < right { i++ }
        while array[j] > array[pivot] && j > left  { j-- }
        if i < j { array[i] <-> array[j] }
    } while i < j
    
    if array[i] > array[pivot] { array[pivot] <-> array[i] }
    
    return i
}
*/


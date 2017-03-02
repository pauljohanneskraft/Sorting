
//
//  IntroSort.swift
//  Sort
//
//  Created by Paul Kraft on 21.12.15.
//  Copyright © 2015 Paul Kraft. All rights reserved.
//

extension SortableCollection {
    public mutating func introSort(by order: (Element, Element) throws -> Bool) rethrows {
        // ...
        if count < 25 { try self.selectionSort(by: order); return }
        let depth = Int(log2(Double(indices.count)))
        try self.introSort(in: self.indices, maxDepth: depth, by: order)
    }
    
    mutating func introSort(in range: CountableRange<Int>, maxDepth depth: Int, by order: (Element, Element) throws -> Bool) rethrows {
        // ...
        
        guard range.count > 20  else { try self.selectionSort(in: range, by: order); return }
        guard depth > 0         else { try self.heapSort     (in: range, by: order); return }
        let pivot = try partition(in: range, by: order)
        try introSort(in: range.startIndex ..< pivot    , maxDepth: depth - 1, by: order)
        try introSort(in: (pivot+1) ..< range.endIndex  , maxDepth: depth - 1, by: order)
    }
}

public extension SortableCollection where Element : Comparable {
    public mutating func introSort() { self.introSort(by: <) }
}



/*

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
*/


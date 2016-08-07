//
//  MergeSort.swift
//  Sort
//
//  Created by Paul Kraft on 21.12.15.
//  Copyright © 2015 Paul Kraft. All rights reserved.
//

extension Sortable {
    public mutating func mergeSort(by order: (Element, Element) throws -> Bool) rethrows {
        guard count > 1 else { return }
        try self.mergeSort(in: self.indices, by: order)
    }
    
    public mutating func mergeSort(in range: CountableRange<Int>, by order: (Element, Element) throws -> Bool) rethrows {
        // ...
        guard range.count > 1 else { return }
        
        let mid = (range.startIndex + range.endIndex) / 2
        try self.mergeSort(in: range.startIndex..<mid, by: order)
        try self.mergeSort(in: mid..<range.endIndex, by: order)
        try self.merge(range: range, mid: mid, by: order)
    }
    
    /// in-place merging
    private mutating func merge(range: CountableRange<Int>, mid: Int, by order: (Element, Element) throws -> Bool) rethrows {
        // ...
        var mid = mid
        for left in range {
            
            if left >= mid || range.endIndex <= mid { return }
            
            if try order(self[mid], self[left]) {
                insert(remove(at: mid), at: left)
                mid += 1
            }
        }
    }
}

public extension Array where Element : Comparable {
    public mutating func mergeSort() {
        self.mergeSort(by: { $0 < $1 })
    }
}


/*

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

private func merge<T: Comparable>(one: [T], _ two: [T]) -> [T] {
    var one = one, two = two
    var res : [T] = []
    while one.count > 0 && two.count > 0 {
        if one[0] <= two[0] { res.append(one.removeAtIndex(0)) }
        else                { res.append(two.removeAtIndex(0)) }
    }
    while one.count > 0     { res.append(one.removeAtIndex(0)) }
    while two.count > 0     { res.append(two.removeAtIndex(0)) }
    return res
}
*/

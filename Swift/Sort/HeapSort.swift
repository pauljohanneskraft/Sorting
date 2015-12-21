//
//  HeapSort.swift
//  Sort
//
//  Created by Paul Kraft on 21.12.15.
//  Copyright © 2015 Paul Kraft. All rights reserved.
//

private func leftLeaf(root:Int) -> Int {
    return ( root + 1 ) * 2 - 1
}

private func rightLeaf(root:Int) -> Int {
    return ( root + 1 ) * 2
}

private func maxHeapify<T: Comparable>(inout array: [T], rootIndex:Int){
    if leftLeaf(rootIndex) > array.count - 1 { return }
    let rootValue = array[rootIndex]
    var largestIndex = rootIndex
    var largestValue = rootValue
    if array[leftLeaf(rootIndex)] > largestValue {
        largestValue = array[leftLeaf(rootIndex)]
        largestIndex = leftLeaf(rootIndex)
    }
    if rightLeaf(rootIndex) <= array.count - 1 {
        if array[rightLeaf(rootIndex)] > largestValue {
            largestValue = array[rightLeaf(rootIndex)]
            largestIndex = rightLeaf(rootIndex)
        }
    }
    if largestIndex != rootIndex {
        (array[rootIndex], array[largestIndex]) = (array[largestIndex], array[rootIndex])
        maxHeapify(&array, rootIndex: largestIndex)
    }
}

private func buildMaxHeap<T: Comparable> (inout array: [T]) {
    if array.count < 2 { return }
    var mid: Int = array.count/2
    while mid >= 0 {
        maxHeapify(&array, rootIndex: mid)
        mid--;
    }
}

func heapSort<T: Comparable> (var unsorted: [T]) -> (name: String, array: [T]) {
    if unsorted.count < 2 { return ("HeapSort", unsorted) }
    buildMaxHeap(&unsorted)
    var sorted: [T] = []
    while unsorted.count > 1 {
        sorted.insert(unsorted[0], atIndex: 0)
        (unsorted[0], unsorted[unsorted.count-1]) = (unsorted[unsorted.count-1], unsorted[0])
        unsorted.removeLast()
        maxHeapify(&unsorted, rootIndex: 0)
    }
    sorted.insert(unsorted[0], atIndex: 0)
    return ("HeapSort", sorted)
}

//
//  HeapSort.swift
//  Sort
//
//  Created by Paul Kraft on 21.12.15.
//  Copyright © 2015 Paul Kraft. All rights reserved.
//

extension Array {
    mutating func heapSort(by order: (Element, Element) throws -> Bool) rethrows {
        // ...
        try self.heapSort(in: self.indices, by: order)
    }
    
    mutating func heapSort(in range: CountableRange<Int>, by order: (Element, Element) throws -> Bool) rethrows {
        // ...
        guard range.count > 1 else { return }
        try generateMaxHeap(in: range, by: order)
        
        //hier wird sortiert
        for i in range.reversed() {
            // print(range, "did swap", i, range.startIndex)
            swap(&self[i], &self[range.startIndex])
            try siftDown(index: range.startIndex, in: range.startIndex..<i, by: order)
        }
        // print(self[range])
    }
    
    private mutating func generateMaxHeap(in range: CountableRange<Int>, by order: (Element, Element) throws -> Bool) rethrows {
        // ...
        // print("generating max Heap")
        let r = ((range.startIndex)..<((range.count >> 1) + range.startIndex)).reversed()
        // print("reversed range", range, "->", r)
        for i in r {
            try siftDown(index: i, in: range, by: order)
        }
        // print("max Heap is built")
        // print("max heap", self[range])
    }
    
    private mutating func siftDown(index: Int, in range: CountableRange<Int>, by order: (Element, Element) throws -> Bool) rethrows {
        // ...
        // print("sifting down", index, range)
        var i = index
        // assert(range.contains(i))
        // print("checking if", i, "< ((", range.endIndex, ">>", 1, ") +", startIndex))
        while true {
            var child = ((i+1-range.startIndex) << 1) - 1 + range.startIndex // berechnet den Index des linken kind
            guard range.contains(child) else { return }
            //bestimme ob ein rechtes Kind existiert
            if range.contains(child + 1) {
                //rechtes kind existiert
                // print("checking if right child is higher", self[child], self[child + 1])
                if try order(self[child], self[child + 1]) {
                    // print("child+1 \(child + 1) was higher:", self[child + 1], ">", self[child])
                    child += 1 // wenn rechtes kind größer ist nimm das
                }
            }
            
            // print("does", self[i], "have to sink? child is", self[child])
            //teste ob element sinken muss
            if try order(self[i], self[child]) { // self[i] < self[child]
                // print("did swap", i, child, "because", self[i], "<", self[child])
                // assert(range.contains(i) && range.contains(child))
                swap(&self[i], &self[child]) //element versenken
                i = child // wiederhole den vorgang mit der neuen position
            } else { break }
        }
    }
}

extension Array where Element : Comparable {
    public mutating func heapSort() {
        self.heapSort(in: self.indices, by: { $0 < $1 })
    }
}

/*
private func leftLeaf(_ root:Int) -> Int {
    return ( root + 1 ) * 2 - 1
}

private func rightLeaf(_ root:Int) -> Int {
    return ( root + 1 ) * 2
}

private func maxHeapify<T: Comparable>(_ array: inout [T], rootIndex:Int){
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

private func buildMaxHeap<T: Comparable> (_ array: inout [T]) {
    if array.count < 2 { return }
    var mid: Int = array.count/2
    while mid >= 0 {
        maxHeapify(&array, rootIndex: mid)
        mid -= 1;
    }
}

func heapSort<T: Comparable> (_ unsorted: [T]) -> (name: String, array: [T]) {
    }

func heapSort<T: Comparable> ( sorted: inout [T], _ range: Range<Int>) {
    var unsorted: [T] = sorted[range] + []
    unsorted = heapSort(unsorted).array
    sorted = sorted[0..<range.startIndex] + unsorted + sorted[range.endIndex..<sorted.count]
}
*/

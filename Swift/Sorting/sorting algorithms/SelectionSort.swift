//
//  SelectionSort.swift
//  Sort
//
//  Created by Paul Kraft on 21.12.15.
//  Copyright © 2015 Paul Kraft. All rights reserved.
//

extension Array where Element : Comparable {
    mutating func selectionSort(by order: (Element, Element) throws -> Bool = { $0 < $1 }) rethrows {
        for l in indices {
            var min = l
            for i in l+1..<count {
                if try order(self[i], self[min]) { min = i }
            }
            swap(&self[l], &self[min])
        }
    }
}

//
//  BubbleSort.swift
//  Sort
//
//  Created by Paul Kraft on 21.12.15.
//  Copyright © 2015 Paul Kraft. All rights reserved.
//

extension Array where Element : Comparable {
    mutating func bubbleSort(by order: (Element, Element) throws -> Bool = { $0 < $1 }) rethrows {
        var didChange = false
        repeat {
            didChange = false
            for i in indices.dropLast() {
                if try order(self[i+1], self[i]) {
                    didChange = true
                    swap(&self[i], &self[i+1])
                }
            }
        } while didChange
    }
}

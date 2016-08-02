//
//  RadixSortTests.swift
//  Sorting
//
//  Created by Paul Kraft on 02.08.16.
//  Copyright © 2016 pauljohanneskraft. All rights reserved.
//

import XCTest
@testable import Sorting

class RadixSortTests: XCTestCase {
    
    override func setUp() {
        for _ in 0..<300 {
            let count = arc4random() % 10 + 5
            var array = [Int]()
            for _ in 0..<count {
                array.append(Int(arc4random()))
            }
            elements.append(array)
        }
    }
    
    var elements = [[Int]]()

    func testAll() {
        for es in elements {
            var sorted = es
            sorted.radixSort()
            // print(es, "~>", sorted)
            assert(sorted.isSorted)
        }
        print("all", elements.count, "tests were succesfull")
    }

}

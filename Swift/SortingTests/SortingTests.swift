//
//  SortingTests.swift
//  SortingTests
//
//  Created by Paul Kraft on 02.08.16.
//  Copyright © 2016 pauljohanneskraft. All rights reserved.
//

import XCTest
import Sorting

class SortingTest : XCTestCase {
    typealias N = Int
    
    var elements : [[N]] = []
    
    let arrayCount              = 20
    let elementCount : UInt32   = 20_000
    
    override func setUp() {
        for _ in 0..<arrayCount {
            let count = arc4random() % elementCount + 5
            var array = [Int]()
            for _ in 0..<count {
                array.append(Int(arc4random() % UInt32(elementCount * 10)))
            }
            elements.append(array)
        }
    }
    
    func testRadixSort()        { forAll("RadixSort"        ) { $0.radixSort()          } }
    // func testRadixSortInPlace() { forAll("RadixSortInPlace" ) { $0.radixSortInPlace()   } }
    func testSelectionSort()    { forAll("SelectionSort"    ) { $0.selectionSort()      } }
    func testInsertionSort()    { forAll("InsertionSort"    ) { $0.insertionSort()      } }
    func testShellSort()        { forAll("ShellSort"        ) { $0.shellSort()          } }
    func testMergeSort()        { forAll("MergeSort"        ) { $0.mergeSort()          } }
    func testQuickSort()        { forAll("QuickSort"        ) { $0.quickSort()          } }

    
    func testFastOnes()         {
        testRadixSort()
        testQuickSort()
        testShellSort()
    }
    
    func forAll(_ desc: String = "Test", _ f: (inout [N]) -> ()) {
        var time = 0.0
        print()
        for es in elements {
            var sorted = es
            let start = NSDate()
            f(&sorted)
            let _time = -start.timeIntervalSinceNow
            if !sorted.isSorted {
                print(sorted)
                assert(false)
            }
            time += _time
            print(".", terminator: "")
        }
        print("\n", desc, ":", elements.count, "tests successful.", "total time:", time, "per test:", time / Double(elements.count), "\n")
    }

}

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
    
    override func setUp() {
        self.setUp(arrayCount: 200, elementCount: 100)
    }
    
    func setUp(arrayCount: Int, elementCount: UInt32) {
        elements = []
        for _ in 0..<arrayCount {
            let count = (arc4random() % (elementCount)) + (elementCount / 2)
            var array = [Int]()
            for _ in 0..<count {
                array.append(Int(arc4random() % UInt32(elementCount * 10)))
            }
            elements.append(array)
        }
    }

    
    func testBubbleSort()       { forAll("BubbleSort       ") { $0.bubbleSort()         } }
    func testRadixSort()        { forAll("RadixSort        ") { $0.radixSort()          } }
    func testRadixSortInPlace() { forAll("RadixSortInPlace ") { $0.radixSortInPlace()   } }
    func testSelectionSort()    { forAll("SelectionSort    ") { $0.selectionSort()      } }
    func testInsertionSort()    { forAll("InsertionSort    ") { $0.insertionSort()      } }
    func testIntroSort()        { forAll("IntroSort        ") { $0.introSort()          } }
    func testShellSort()        { forAll("ShellSort        ") { $0.shellSort()          } }
    func testMergeSort()        { forAll("MergeSort        ") { $0.mergeSort()          } }
    func testQuickSort()        { forAll("QuickSort        ") { $0.quickSort()          } }
    func testSwiftSort()        { forAll("Swift            ") { $0.sort()               } }
    func testBinaryTreeSort()   { forAll("BinaryTreeSort   ") { $0.binaryTreeSort()     } }
    
    func testSlowOnes()         {
        let arrayCount = 10
        let elementCount : UInt32 = 500
        setUp(arrayCount: arrayCount, elementCount: elementCount)
        testBubbleSort()
        testInsertionSort()
        testSelectionSort()
        print("." * arrayCount)
    }
    
    func testMediumOnes() {
        let arrayCount = 10
        let elementCount : UInt32 = 5_000
        setUp(arrayCount: arrayCount, elementCount: elementCount)
        testRadixSort()
        testShellSort()
        testMergeSort()
        print("." * arrayCount)
    }
    
    func testFastOnes()         {
        let arrayCount = 10
        let elementCount : UInt32 = 10_000
        setUp(arrayCount: arrayCount, elementCount: elementCount)
        // testRadixSort()
        testRadixSortInPlace()
        testQuickSort()
        testIntroSort()
        testBinaryTreeSort()
        // testShellSort()
        testSwiftSort()
        print("." * arrayCount)
    }
    
    func testAll() {
        testSlowOnes()
        testMediumOnes()
        testFastOnes()
    }
    
    func forAll(_ desc: String = "Test", _ f: (inout [N]) -> ()) {
        var time = 0.0
        var elementCount = 0
        // print()
        for es in elements {
            var sorted = es
            let start = NSDate()
            f(&sorted)
            let _time = -start.timeIntervalSinceNow
            elementCount += sorted.count
            if !sorted.isSorted || sorted.count != es.count {
                print(sorted)
                let ess = es.sorted()
                print(ess)
                for i in 0..<min(es.count, sorted.count) {
                    if ess[i] != sorted[i] { print(i, ":", ess[i], "!=", sorted[i]) }
                }
                assert(false)
            }
            time += _time
            print(".", terminator: "")
        }
        print("\n")
        print(
            "\(desc):",
            elements.count, "tests with an average of", elementCount / elements.count, "elements were successful.",
            "total time:", String(format:"%.5f", time),
            "-> per test:", String(format:"%.5f", time / Double(elements.count)))
        print()
    }
}

func * (lhs: String, rhs: Int) -> String {
    var result = ""
    for _ in 0..<rhs { result += lhs }
    return result
}

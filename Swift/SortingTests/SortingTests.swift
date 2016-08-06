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
        self.setUp(arrayCount: 20, elementCount: 10)
    }
    
    func setUp(arrayCount: Int, elementCount: UInt32) {
        elements = []
        for _ in 0..<arrayCount {
            let count = (arc4random() % (elementCount)) + (elementCount / 2) + 5
            var array = [Int]()
            for _ in 0..<count {
                array.append(Int(arc4random() % UInt32(elementCount * 10)))
            }
            elements.append(array)
        }
    }

    func testHeapSort()         { forAll("HeapSort         ") { $0.heapSort()           } }
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
        let elementCount : UInt32 = 30
        setUp(arrayCount: arrayCount, elementCount: elementCount)
        testBubbleSort()
        testInsertionSort()
        testSelectionSort()
        testRadixSortInPlace()
        print("." * arrayCount)
    }
    
    func testMediumOnes() {
        let arrayCount = 10
        let elementCount : UInt32 = 50
        setUp(arrayCount: arrayCount, elementCount: elementCount)
        testRadixSort()
        testShellSort()
        testMergeSort()
        testRadixSortInPlace()
        print("." * arrayCount)
    }
    
    func testFastOnes()         {
        let arrayCount = 2
        let elementCount : UInt32 = 100
        setUp(arrayCount: arrayCount, elementCount: elementCount)
        // testRadixSort()
        testRadixSortInPlace()
        // testHeapSort()
        // testQuickSort()
        // testIntroSort()
        // testBinaryTreeSort()
        // testShellSort()
        testSwiftSort()
        print("." * arrayCount)
    }
    
    func testAll() {
        testSlowOnes()
        testMediumOnes()
        testFastOnes()
    }
    
    func testDoubles() {
        var e = [0,1,200,3,5,-252436,9342,52.0,4524353,325,54,543,7,65,46,867,568,56,9, 1e50, 2e-20]
        e.radixSortInPlace()
        print(e)
    }
    
    func testQuickSelect() {
        let e = [0,1,200,3,5,252436,9342,52,4524353,325,54,543,7,65,46,867,568,56,9]
        let r = 3..<14
        var es = e
        es.quickSort(in: r, by: { $0 < $1 })
        print(e)
        print(es)
        print(es[r])
        print("[", terminator: "")
        for k in 0..<r.count {
            let qs = e.quickSelect(k + 1, in: r)
            print(qs, terminator: "")
            assert(qs == es[k + r.startIndex])
            if k != r.count - 1 { print(", ", terminator: "") }
        }
        print("]")
    }
    
    func testBinarySearch() {
        let e = [0,1,200,3,5,252436,9342,52,4524353,325,54,543,7,65,46,867,568,56,9].sorted()
        print(e.binarySearch(3))
    }
    
    func testRadixSortInPlaceInRange() {
        var e = [0,1,200,3,5,252436,9342,52,4524353,325,54,543,7,65,46,867,568,56,9]
        let range = 2..<5
        e.radixSortInPlace(in: range, by: { $0 })
        //print(e[range])
        if !e[range].isSorted { fatalError() }
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
                print("\(desc) failed after", time, "s.")
                XCTAssert(false)
                return
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

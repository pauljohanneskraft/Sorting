//
//  main.swift
//  Sorting
//
//  Created by Paul Kraft on 06.04.16.
//  Copyright © 2016 pauljohanneskraft. All rights reserved.
//

import Foundation

let              times = 1
let             rounds = 5
let           elements = 500
let showResultsOfRound = true
let      showAllArrays = false

let sortingAlgorithms : [[Number] -> (String, [Number])] = [
    //avlBinaryTreeCompositeSort,
    //avlBinaryTreeSort,
    //binaryTreeCompositeSort,
    //binaryTreeSort,
    //
    bubbleSort,
    //heapSort,
    //insertionSort,
    //introSortInPlace,
    //introSortMedian,
    //introSortMedianThreaded,
    //
    mergeSort,
    //
    mergeSortThreaded,
    //selectionSort,
    //shellSort,
    //quickSortFirst,
    //quickSortFirstThreaded,
    //quickSort,
    //quickSortInPlaceThreaded,
    //quickSortMedian,
    //quickSortMedianThreaded,
    //quickSortRandom,
    //quickSortRandomThreaded,
]

for i in 0..<times {
        var s = Test(
            rounds:rounds,
            elements:elements,
            showResultsOfRound:showResultsOfRound,
            showAllArrays:showAllArrays,
            sortingAlgorithms: sortingAlgorithms)
    }
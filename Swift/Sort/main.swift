
//
//  main.swift
//  Sort
//
//  Created by Paul Kraft on 13.12.15.
//  Copyright © 2015 Paul Kraft. All rights reserved.
//

let              times = 1
let             rounds = 1
let           elements = 100000
let showResultsOfRound = true
let      showAllArrays = false

let sortingAlgorithms : [[Number] -> (String, [Number])] = [
    //avlBinaryTreeCompositeSort,
    //avlBinaryTreeSort,
    //binaryTreeCompositeSort,
    //
    binaryTreeSort,
    //bubbleSort,
    //heapSort,
    //insertionSort,
    //introSortMedian,
    //
    introSortMedianThreaded,
    //mergeSort,
    //mergeSortThreaded,
    //selectionSort,
    //
    shellSort,
    //quickSortFirst,
    //quickSortFirstThreaded,
    //quickSortInPlace,
    //quickSortInPlaceThreaded,
    //quickSortMedian,
    //
    quickSortMedianThreaded,
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

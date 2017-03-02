//
//  IntroSort.cpp
//  Sorting
//
//  Created by Paul Kraft on 10.04.16.
//  Copyright © 2016 pauljohanneskraft. All rights reserved.
//

#include "IntroSort.hpp"
#include "InsertionSort.hpp"
#include "ShellSort.hpp"
#include "BinaryTreeSort.hpp"
#include <cmath>

IntroSort::IntroSort() : QuickSort("IntroSort\t\t\t") {}

void IntroSort::sort(Comparable *array[], int length) {
    sort(array, 0, length - 1);
}

void IntroSort::sort(Comparable *array[], int left, int right) {
    sort(array, left, right, log(right-left));
}

void IntroSort::sort(Comparable *array[], int left, int right, int depth) {
    if(right - left < 20) {
        InsertionSort ins = *new InsertionSort();
        ins.sort(array, left, right);
        return;
    }
    if(depth == 0) {
        Sort *s = new BinaryTreeSort();
        s->sort(array, left, right);
        return;
    }
    
    int pivot = partition(array, left, right);
    sort(array, left, pivot - 1);
    sort(array, pivot, right);
}
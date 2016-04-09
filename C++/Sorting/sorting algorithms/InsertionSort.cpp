//
//  InsertionSort.cpp
//  Sorting
//
//  Created by Paul Kraft on 08.04.16.
//  Copyright © 2016 pauljohanneskraft. All rights reserved.
//

#include "InsertionSort.hpp"

InsertionSort::InsertionSort() : Sort("InsertionSort") {}

void InsertionSort::sort(Comparable *array[], const int length) {
    sort(array, 0, length - 1);
}

void InsertionSort::sort(Comparable *array[], int left, int right) {
    int j;
    for(int i = left; i <= right; i++) {
        j = i;
        while((j > left) && (*array[j] < array[j-1])) {
            swap(array, j, j - 1);
            j--;
        }
    }
}
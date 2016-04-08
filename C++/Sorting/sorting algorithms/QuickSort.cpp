//
//  QuickSort.cpp
//  Sorting
//
//  Created by Paul Kraft on 08.04.16.
//  Copyright © 2016 pauljohanneskraft. All rights reserved.
//

#include "QuickSort.hpp"
#include <iostream>

QuickSort::QuickSort() : Sort("QuickSort") {}

void QuickSort::sort(Comparable *array[], int length) {
    sort(array, 0, length - 1);
}

void QuickSort::sort(Comparable *array[], int left, int right) {
    if(left < right) {
        int pivot = partition(array, left, right);
        sort(array, left, pivot - 1);
        sort(array, pivot, right);
    }
}

int QuickSort::partition(Comparable *array[], int left, int right) {
    int i = left, j = right;
    Comparable *tmp;
    Comparable *pivot = array[(left + right) / 2];
    
    while (i <= j) {
        while (*array[i] < pivot) i++;
        while (*array[j] > pivot) j--;
        if (i <= j) {
            tmp = array[i];
            array[i] = array[j];
            array[j] = tmp;
            i++;
            j--;
        }
    }
    
    return i;
}

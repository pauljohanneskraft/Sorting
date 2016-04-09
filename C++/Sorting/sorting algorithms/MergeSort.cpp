//
//  MergeSort.cpp
//  Sorting
//
//  Created by Paul Kraft on 08.04.16.
//  Copyright © 2016 pauljohanneskraft. All rights reserved.
//

#include "MergeSort.hpp"

MergeSort::MergeSort() : Sort("MergeSort    ") {}

void MergeSort::sort(Comparable *array[], int length) {
    sort(array, 0, length - 1);
}

void MergeSort::sort(Comparable *array[], int left, int right) {
    if(left >= right) return;
    int mid = (left + right) / 2;
    sort(array, left, mid);
    sort(array, mid + 1, right);
    merge(array, left, mid, right);
}

void MergeSort::merge(Comparable *array[], int left, int mid, int right) {
    int i = left, j = mid + 1, k = left;
    Comparable *c[right - left + 1];
    while (i <= mid && j <= right) {
        if (*array[i] < array[j]) {
            c[k-left] = array[i];
            k++;
            i++;
        } else {
            c[k-left] = array[j];
            k++;
            j++;
        }
    }
    while (i <= mid) {
        c[k-left] = array[i];
        k++;
        i++;
    }
    while (j <= right) {
        c[k-left] = array[j];
        k++;
        j++;
    }
    for (i = left; i < k; i++) {
        array[i] = c[i-left];
    }
}
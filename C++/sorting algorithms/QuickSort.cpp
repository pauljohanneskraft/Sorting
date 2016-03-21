//
// Created by Paul Kraft on 16.03.16.
//

#include "QuickSort.h"

void QuickSort::sort(Comparable* array[]) {
    sortPart(array, 0, (sizeof(array)/sizeof(array[0])) - 1);
}

void QuickSort::sortPart(Comparable* array[], int left, int right) {
    if(left < right) {
        int pivot = partition(array, left, right);
        sortPart(array, left, pivot - 1);
        sortPart(array, pivot + 1, right);
    }
}

int QuickSort::partition(Comparable* array[], int left, int right) {
    int i = left;
    int j = right;
    Comparable* tmp;
    Comparable* pivot = array[(left + right) / 2];

    /* partition */
    while (i <= j) {
        while (array[i] < pivot)
            i++;
        while (array[j] > pivot)
            j--;
        if (i <= j) {
            tmp = array[i];
            array[i] = array[j];
            array[j] = tmp;
            i++;
            j--;
        }
    };
    return i;
}
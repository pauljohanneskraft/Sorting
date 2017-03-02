//
//  SelectionSort.cpp
//  Sorting
//
//  Created by Paul Kraft on 08.04.16.
//  Copyright © 2016 pauljohanneskraft. All rights reserved.
//

#include "SelectionSort.hpp"

SelectionSort::SelectionSort() : Sort("SelectionSort\t\t") {}

void SelectionSort::sort(Comparable *array[], int length) {
    sort(array, 0, length -1);
}

void SelectionSort::sort(Comparable *array[], int left, int right) {
    for(int i = left; i <=right; i++) {
        int min = i;
        for(int j = i+1; j <= right; j++) {
            if(*array[j] < array[min]) { min = j; }
        }
        Comparable *tmp = array[i];
        array[i] = array[min];
        array[min] = tmp;
    }
}
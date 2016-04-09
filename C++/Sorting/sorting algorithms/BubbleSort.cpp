//
//  BubbleSort.cpp
//  Sorting
//
//  Created by Paul Kraft on 08.04.16.
//  Copyright © 2016 pauljohanneskraft. All rights reserved.
//

#include "BubbleSort.hpp"

BubbleSort::BubbleSort() : Sort("BubbleSort\t\t\t") {}

void BubbleSort::sort(Comparable *array[], int length) {
    sort(array, 0, length - 1);
}

void BubbleSort::sort(Comparable *array[], int left, int right) {
    bool didChange;
    do {
        didChange = false;
        for(int i = left; i < right; i++) {
            if(*array[i+1] < array[i]) {
                didChange = true;
                Comparable *tmp = array[i];
                array[i] = array[i+1];
                array[i+1] = tmp;
            }
        }
    } while(didChange);
}

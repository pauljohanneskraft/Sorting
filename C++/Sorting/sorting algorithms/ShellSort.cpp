//
//  ShellSort.cpp
//  Sorting
//
//  Created by Paul Kraft on 09.04.16.
//  Copyright © 2016 pauljohanneskraft. All rights reserved.
//

#include "ShellSort.hpp"


ShellSort::ShellSort() : Sort("ShellSort    ") {}

void ShellSort::sort(Comparable *array[], int length) {
    sort(array, 0, length - 1);
}

void ShellSort::sort(Comparable *array[], int left, int right) {
    int columns[] = {8388607, 4194303, 2097151, 1048575, 524287, 262143, 131071, 65535, 32767, 16383, 8191, 4095, 2047, 1023, 511, 255, 127, 63, 31, 15, 7, 3, 1};
    
    int s = 0;
    int range = right - left;
    while(columns[s] > range) s++;
    
    for(int k = s; k < sizeof(columns)/sizeof(int); k++) {
        int h = columns[k] + left;
        
        for(int i = h; i <= right; i++) {
            Comparable *t = array[i];
            int j = i;
            while(j >= h && *array[j-h] > t) {
                array[j] = array[j-h];
                j = j - h;
            }
            array[j] = t;
        }
    }
}
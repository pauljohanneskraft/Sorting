//
// Created by Paul Kraft on 16.03.16.
//

#ifndef SORT_QUICKSORT_H
#define SORT_QUICKSORT_H
#include "Sort.h"

class QuickSort : public Sort {
public:
    void sort(Comparable* array[]);
private:
    void sortPart(Comparable* array[], int left, int right);
    int partition(Comparable* array[], int left, int right);
};


#endif //SORT_QUICKSORT_H

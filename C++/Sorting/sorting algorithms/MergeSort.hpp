//
//  MergeSort.hpp
//  Sorting
//
//  Created by Paul Kraft on 08.04.16.
//  Copyright © 2016 pauljohanneskraft. All rights reserved.
//

#ifndef MergeSort_hpp
#define MergeSort_hpp

#include <stdio.h>
#include "Sort.hpp"

class MergeSort : public Sort {
public:
    MergeSort();
    void sort(Comparable *array[], int length);
protected:
    void sort(Comparable *array[], int left, int right);
private:
    void merge(Comparable *array[], int left, int mid, int right);
};


#endif /* MergeSort_hpp */

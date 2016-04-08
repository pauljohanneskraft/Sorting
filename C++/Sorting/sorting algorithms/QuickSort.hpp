//
//  QuickSort.hpp
//  Sorting
//
//  Created by Paul Kraft on 08.04.16.
//  Copyright © 2016 pauljohanneskraft. All rights reserved.
//

#ifndef QuickSort_hpp
#define QuickSort_hpp

#include <stdio.h>
#include "Sort.hpp"

class QuickSort : public Sort {
public:
    QuickSort();
    virtual void sort(Comparable *array[], int length);
protected:
    virtual void sort(Comparable *array[], int left, int right);
    int partition(Comparable *array[], int left, int right);
};

#endif /* QuickSort_hpp */

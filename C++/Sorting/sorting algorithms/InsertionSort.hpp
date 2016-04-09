//
//  InsertionSort.hpp
//  Sorting
//
//  Created by Paul Kraft on 08.04.16.
//  Copyright © 2016 pauljohanneskraft. All rights reserved.
//

#ifndef InsertionSort_hpp
#define InsertionSort_hpp

#include <stdio.h>
#include "Sort.hpp"

class InsertionSort : public Sort {
public:
    InsertionSort();
    virtual void sort(Comparable *array[], int length);
protected:
    virtual void sort(Comparable *array[], int left, int right);
};

#endif /* InsertionSort_hpp */

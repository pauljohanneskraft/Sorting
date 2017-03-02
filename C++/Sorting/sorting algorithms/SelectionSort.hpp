//
//  SelectionSort.hpp
//  Sorting
//
//  Created by Paul Kraft on 08.04.16.
//  Copyright © 2016 pauljohanneskraft. All rights reserved.
//

#ifndef SelectionSort_hpp
#define SelectionSort_hpp

#include <stdio.h>
#include "Sort.hpp"

class SelectionSort : public Sort {
public:
    SelectionSort();
    void sort(Comparable *array[], int length);
protected:
    void sort(Comparable *array[], int left, int right);
};

#endif /* SelectionSort_hpp */

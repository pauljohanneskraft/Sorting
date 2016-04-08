//
//  BubbleSort.hpp
//  Sorting
//
//  Created by Paul Kraft on 08.04.16.
//  Copyright © 2016 pauljohanneskraft. All rights reserved.
//

#ifndef BubbleSort_hpp
#define BubbleSort_hpp

#include <stdio.h>
#include "Sort.hpp"

class BubbleSort : public Sort {
public:
    BubbleSort();
    virtual void sort(Comparable *array[], int length);
protected:
    virtual void sort(Comparable *array[], int left, int right);
};


#endif /* BubbleSort_hpp */

//
//  IntroSort.hpp
//  Sorting
//
//  Created by Paul Kraft on 10.04.16.
//  Copyright © 2016 pauljohanneskraft. All rights reserved.
//

#ifndef IntroSort_hpp
#define IntroSort_hpp

#include <stdio.h>
#include "QuickSort.hpp"

class IntroSort : public QuickSort {
public:
    IntroSort();
    void sort(Comparable *array[], int length);
protected:
    void sort(Comparable *array[], int left, int right);
private:
    void sort(Comparable *array[], int left, int right, int depth);
};

#endif /* IntroSort_hpp */

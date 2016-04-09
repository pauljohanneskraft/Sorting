//
//  ShellSort.hpp
//  Sorting
//
//  Created by Paul Kraft on 09.04.16.
//  Copyright © 2016 pauljohanneskraft. All rights reserved.
//

#ifndef ShellSort_hpp
#define ShellSort_hpp

#include <stdio.h>
#include "Sort.hpp"

class ShellSort : public Sort {
public:
    ShellSort();
    void sort(Comparable *array[], int length);
protected:
    void sort(Comparable *array[], int left, int right);
};

#endif /* ShellSort_hpp */

//
//  Sort.hpp
//  Sorting
//
//  Created by Paul Kraft on 08.04.16.
//  Copyright © 2016 pauljohanneskraft. All rights reserved.
//

#ifndef Sort_hpp
#define Sort_hpp

#include <stdio.h>
#include "Comparable.hpp"

class Sort {
public:
    Sort(string name);
    string getName();
    virtual void sort(Comparable *array[], int length) = 0;
protected:
    const string name;
    virtual void sort(Comparable *array[], int left, int right) = 0;
};

#endif /* Sort_hpp */

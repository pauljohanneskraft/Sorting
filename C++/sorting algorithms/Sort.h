//
// Created by Paul Kraft on 16.03.16.
//

#ifndef SORT_SORT_H
#define SORT_SORT_H

#include "../Comparable/Comparable.h"

class Sort {
    public:
        virtual void sort(Comparable* array[]) = 0;
};


#endif //SORT_SORT_H

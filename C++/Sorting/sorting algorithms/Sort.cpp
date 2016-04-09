//
//  Sort.cpp
//  Sorting
//
//  Created by Paul Kraft on 08.04.16.
//  Copyright © 2016 pauljohanneskraft. All rights reserved.
//

#include "Sort.hpp"

Sort::Sort(string name) : name(name) {}

string Sort::getName() { return name; }

void Sort::swap(Comparable *array[], int c1, int c2) {
    Comparable *tmp = array[c1];
    array[c1] = array[c2];
    array[c2] = tmp;
}
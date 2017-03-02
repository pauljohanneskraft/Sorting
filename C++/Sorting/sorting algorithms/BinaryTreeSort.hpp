//
//  BinaryTreeSort.hpp
//  Sorting
//
//  Created by Paul Kraft on 08.04.16.
//  Copyright © 2016 pauljohanneskraft. All rights reserved.
//

#ifndef BinaryTreeSort_hpp
#define BinaryTreeSort_hpp

#include <stdio.h>
#include "Sort.hpp"

class Node {
public:
    Node *left;
    Node *right;
    Comparable *info;
    Node(Comparable *info);
    ~Node();
    virtual void insert(Comparable *info);
    void getArray(Comparable *array[], const int length);
    int getArray(Comparable *array[], const int length, int index);
    string dot();
private:
};

class BinaryTreeSort : public Sort {
public:
    BinaryTreeSort();
    void sort(Comparable* array[], int length);
protected:
    void sort(Comparable* array[], int left, int right);
    Node *root;
    string dot();
    void insert(Comparable *info);
};


#endif /* BinaryTreeSort_hpp */

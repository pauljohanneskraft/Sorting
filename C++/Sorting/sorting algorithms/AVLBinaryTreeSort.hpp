//
//  AVLBinaryTreeSort.hpp
//  Sorting
//
//  Created by Paul Kraft on 09.04.16.
//  Copyright © 2016 pauljohanneskraft. All rights reserved.
//

#ifndef AVLBinaryTreeSort_hpp
#define AVLBinaryTreeSort_hpp

#include <stdio.h>
#include "Sort.hpp"

class AVLNode {
public:
    AVLNode *left;
    AVLNode *right;
    int weights;
    Comparable *info;
    AVLNode(Comparable *info);
    ~AVLNode();
    void getArray(Comparable *array[], const int length);
    int getArray(Comparable *array[], const int length, int index);
    string dot();
    AVLNode* insert(Comparable *info);
    AVLNode* balance();
};


class AVLBinaryTreeSort : public Sort {
public:
    AVLBinaryTreeSort();
    void sort(Comparable *array[], int length);
protected:
    AVLNode *root;
    void sort(Comparable *array[], int left, int right);
};



#endif /* AVLBinaryTreeSort_hpp */

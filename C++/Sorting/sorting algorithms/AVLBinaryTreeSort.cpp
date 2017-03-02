//
//  AVLBinaryTreeSort.cpp
//  Sorting
//
//  Created by Paul Kraft on 09.04.16.
//  Copyright © 2016 pauljohanneskraft. All rights reserved.
//

#include "AVLBinaryTreeSort.hpp"



AVLNode::AVLNode(Comparable *info) : info(info), right(nullptr), left(nullptr) {}

AVLNode::~AVLNode() {
    if(left  != nullptr) delete left;
    if(right != nullptr) delete right;
}

string AVLNode::dot() {
    string a = "";
    if (left  != nullptr) { a += "\t\t" + info->getValue() + " -> " +  left->info->getValue() + " [label=left ] \n"; }
    if (right != nullptr) { a += "\t\t" + info->getValue() + " -> " + right->info->getValue() + " [label=right] \n"; }
    
    if (left  != nullptr) { a +=  left->dot(); }
    if (right != nullptr) { a += right->dot(); }
    return a;
}

AVLNode* AVLNode::insert(Comparable *info) {
    if(*info < this->info) {
        if(left  == nullptr) {
            left = new AVLNode(info);
        } else {
            left = left->insert(info);
        }
    } else {
        if(right == nullptr) {
            right = new AVLNode(info);
        } else {
            right = right->insert(info);
        }
    }
    return balance();
}

int AVLNode::getArray(Comparable *array[], const int length, int index) {
    if(left  != nullptr) index = left->getArray(array, length, index);
    array[index++] = info;
    if(right != nullptr) index = right->getArray(array, length, index);
    return index;
}

AVLNode* AVLNode::balance() {
    int lb = -1, rb = -1;
    if( left != nullptr) { lb =  left->weights; }
    if(right != nullptr) { rb = right->weights; }
    weights = (lb > rb ? lb : rb) + 1;
    int difference = 20;
    if (lb - rb > difference) {
        //print("rotate right")
        AVLNode *tmp = left;
        left = left->right;
        tmp->right = this;
        return tmp;
    }
    else if (lb - rb < -difference) {
        //print("rotate left")
        AVLNode *tmp = right;
        right = right->left;
        tmp->left = this;
        return tmp;
    }
    return this;
}

AVLBinaryTreeSort::AVLBinaryTreeSort() : Sort("AVLBinaryTreeSort\t") {}

void AVLBinaryTreeSort::sort(Comparable* array[], int length) {
    sort(array, 0, length - 1);
}

void AVLBinaryTreeSort::sort(Comparable* array[], int left, int right) {
    root = new AVLNode(array[left]);
    for(int i = left + 1; i <= right; i++) {
        root = root->insert(array[i]);
    }
    //cout << dot();
    root->getArray(array, right-left, left);
    delete root;
}

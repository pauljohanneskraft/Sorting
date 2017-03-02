//
//  BinaryTreeSort.cpp
//  Sorting
//
//  Created by Paul Kraft on 08.04.16.
//  Copyright © 2016 pauljohanneskraft. All rights reserved.
//

#include "BinaryTreeSort.hpp"
#include <iostream>
#include <string>

BinaryTreeSort::BinaryTreeSort() : Sort("BinaryTreeSort\t\t") {}

void BinaryTreeSort::sort(Comparable* array[], int length) {
    sort(array, 0, length - 1);
}

void BinaryTreeSort::sort(Comparable* array[], int left, int right) {
    root = new Node(array[left]);
    for(int i = left + 1; i <= right; i++) {
        root->insert(array[i]);
    }
    //cout << dot();
    root->getArray(array, right-left, left);
    delete root;
}

void BinaryTreeSort::insert(Comparable* info) {
    if(root == nullptr) root = new Node(info);
    else root->insert(info);
}

string BinaryTreeSort::dot() {
    string res = "\tdigraph g { \n\t\tgraph [ordering = out] \n";
    if (root != nullptr) { res += root->dot(); }
    return  res + "\t}\n";
}


Node::Node(Comparable *info) : info(info), right(nullptr), left(nullptr) {}

Node::~Node() {
    if(left  != nullptr) delete left;
    if(right != nullptr) delete right;
}

string Node::dot() {
    string a = "";
    if (left  != nullptr) { a += "\t\t" + info->getValue() + " -> " +  left->info->getValue() + " [label=left ] \n"; }
    if (right != nullptr) { a += "\t\t" + info->getValue() + " -> " + right->info->getValue() + " [label=right] \n"; }
    
    if (left  != nullptr) { a +=  left->dot(); }
    if (right != nullptr) { a += right->dot(); }
    return a;
}

void Node::insert(Comparable *info) {
    if(*info < this->info) {
        if(left  == nullptr) {
            left = new Node(info);
        } else {
           left->insert(info);
        }
    } else {
        if(right == nullptr) {
            right = new Node(info);
        } else {
            right->insert(info);
        }
    }
}

int Node::getArray(Comparable *array[], const int length, int index) {
    if(left  != nullptr) index = left->getArray(array, length, index);
    array[index++] = info;
    if(right != nullptr) index = right->getArray(array, length, index);
    return index;
}
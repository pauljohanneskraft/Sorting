//
// Created by Paul Kraft on 16.03.16.
//

#ifndef SORT_NUMBER_H
#define SORT_NUMBER_H

#include <iostream>
#include <string>
#include "Comparable.h"
using namespace std;

class Number : public Comparable {
private:
public:
    const int number;

    Number(int num) : number(num){};
        int const getNumber() { return number; }
        string getValue() {
            return to_string(number);
        }
        bool operator > (Comparable* op2) {
            if(dynamic_cast<Number*>(op2)) {
                return number > ((Number *)op2)->getNumber();
            } else {
                return false;
            }
        }
        bool operator < (Comparable* op2) {
            if(dynamic_cast<Number*>(op2)) {
                return number < ((Number *)op2)->getNumber();
            } else {
                return false;
            }
        }
        bool operator == (Comparable* op2) {
            if(dynamic_cast<Number*>(op2)) {
                return number == ((Number *)op2)->getNumber();
            } else {
                return false;
            }
        }
};

std::ostream& operator<<(std::ostream& os, const Number& a);


#endif //SORT_NUMBER_H

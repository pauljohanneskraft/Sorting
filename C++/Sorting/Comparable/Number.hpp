//
// Created by Paul Kraft on 16.03.16.
//

#ifndef SORT_NUMBER_H
#define SORT_NUMBER_H

#include <iostream>
#include <string>
#include "Comparable.hpp"

using namespace std;

class Number : public Comparable {
public:
    const int number;
    Number(int num);
    int const getNumber();
    string getValue() const;
    virtual bool operator >  (Comparable* op2);
    virtual bool operator <  (Comparable* op2);
    virtual bool operator == (Comparable* op2);
    virtual bool operator >  (Number* op2);
    virtual bool operator <  (Number* op2);
    virtual bool operator == (Number* op2);
};

std::ostream& operator<<(std::ostream& os, const Number& a);


#endif //SORT_NUMBER_H

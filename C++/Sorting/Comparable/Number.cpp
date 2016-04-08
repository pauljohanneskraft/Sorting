//
// Created by Paul Kraft on 16.03.16.
//

#include "Number.hpp"
#include <climits>

Number::Number(int num) : number(num) {}

int const Number::getNumber() { return number; }

string Number::getValue() const {
    string val = to_string(number);
    while(val.size() < to_string(INT_MAX).size()) {
        val = " " + val;
    }
    return val;
}

bool Number::operator >  (Comparable* op2) {
    if(dynamic_cast<Number*>(op2)) return number > ((Number*)op2)->getNumber();
    else return this->getValue() > op2->getValue();
}

bool Number::operator <  (Comparable* op2) {
    if(dynamic_cast<Number*>(op2)) return number < ((Number*)op2)->getNumber();
    else return this->getValue() < op2->getValue();

}

bool Number::operator == (Comparable* op2) {
    if(dynamic_cast<Number*>(op2)) return number == ((Number*)op2)->getNumber();
    else return this->getValue() == op2->getValue();

}

bool Number::operator >  (Number* op2) {
    return number > op2->getNumber();
}

bool Number::operator <  (Number* op2) {
    return number < op2->getNumber();
}

bool Number::operator == (Number* op2) {
    return number == op2->getNumber();
}

std::ostream& operator<<(std::ostream& os, const Number& a){
    return os << a.number;
}


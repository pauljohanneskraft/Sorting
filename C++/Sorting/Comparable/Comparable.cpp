//
// Created by Paul Kraft on 16.03.16.
//

#include "Comparable.hpp"

bool Comparable::operator >  (Comparable* op2) {
    return getValue() > op2->getValue();
}

bool Comparable::operator <  (Comparable* op2) {
    return getValue() < op2->getValue();
}

bool Comparable::operator == (Comparable* op2) {
    return getValue() == op2->getValue();
}
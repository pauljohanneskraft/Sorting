//
// Created by Paul Kraft on 16.03.16.
//

#include "Number.h"

std::ostream& operator<<(std::ostream& os, const Number& a){
    return os << a.number;
}


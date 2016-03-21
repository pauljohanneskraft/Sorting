//
// Created by Paul Kraft on 16.03.16.
//

#ifndef SORT_COMPARABLE_H
#define SORT_COMPARABLE_H

#include <string>
using namespace std;


class Comparable {
    public:
        virtual bool operator > (Comparable* op2)=0;
        virtual bool operator < (Comparable* op2)=0;
        virtual bool operator == (Comparable* op2)=0;
        virtual string getValue();
};


#endif //SORT_COMPARABLE_H

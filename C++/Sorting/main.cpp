//
//  main.cpp
//  Sorting
//
//  Created by Paul Kraft on 08.04.16.
//  Copyright © 2016 pauljohanneskraft. All rights reserved.
//

#include <iostream>
#include "Number.hpp"
#include "QuickSort.hpp"
#include "BubbleSort.hpp"
#include "BinaryTreeSort.hpp"
#include "SelectionSort.hpp"
#include "MergeSort.hpp"
#include "InsertionSort.hpp"
#include "ShellSort.hpp"
#include "AVLBinaryTreeSort.hpp"
#include "IntroSort.hpp"
#include <ctime>
#include <sstream>
#include <locale>
#include <climits>

using namespace std;

void printComparableArray(Comparable* array[], const int length) {
    for(int i = 0; i < length; i++) {
        cout << array[i]->getValue() << endl;
    }
}

bool isSorted(Comparable* array[], const int length) {
    for(int i = 0; i < length - 1; i++) {
        if(*array[i] > array[i+1]) return false;
    }
    return true;
}

string convertToLocaleNumber(long number) {
    ostringstream s;
    s.imbue(locale(""));
    s << number;
    return s.str();
}

long* testOneRound(int round, int length, int lengthOfAlgs, Sort *algorithms[]) {
    cout << endl << "round " << round + 1  << " : " << length << " elements."<< endl;
    
    long times[lengthOfAlgs];
    
    // test sorting algorithms
    Comparable *array[length];
    
    for(int i = 0; i < length; i++) {
        array[i] = new Number(rand() & 0xFFFF);
    }
    
    //printComparableArray(array, length);
    
    for(int i = 0; i < lengthOfAlgs; i++) {
        if(algorithms[i] != nullptr) {
            long start = clock();
            Comparable *array1[length];
            
            for(int j = 0; j < length; j++) {
                array1[j] = array[j];
            }
            
            algorithms[i]->sort(array1, length);
            
            times[i] = (long)((clock() - start)/double(CLOCKS_PER_SEC)*1000);
            
            cout << "\t" << algorithms[i]->getName() << " " << (isSorted(array1, length) ? "sorted" : "didn't sort") << " in " << convertToLocaleNumber(times[i]) << " ms." << endl;
            
            //printComparableArray(array1, length);
        }
    }
    return times;
}

int main(int argc, const char * argv[]) {
    srand((int)(time(0)));
    
    const int length = 100000;
    const int rounds = 10;
    const int lengthOfAlgs = 9;
    long times[rounds][lengthOfAlgs];
    
    Sort *algorithms[lengthOfAlgs];
    
    algorithms[0] = new QuickSort;
    algorithms[1] = new ShellSort;
    //algorithms[2] = new SelectionSort;
    //algorithms[3] = new InsertionSort;
    algorithms[4] = new IntroSort;
    algorithms[5] = new AVLBinaryTreeSort;
    algorithms[6] = new BinaryTreeSort;
    //algorithms[7] = new BubbleSort;
    algorithms[8] = new MergeSort;
    
    for(int round = 0; round < rounds; round++) {
        long *t = testOneRound(round, length, lengthOfAlgs, algorithms);
        for(int i = 0; i < lengthOfAlgs; i++) {
            times[round][i] = t[i];
        }
    }
    
    double time[lengthOfAlgs];
    
    for(int i = 0; i < lengthOfAlgs; i++) {
        time[i] = 0;
    }
    
    for(int round = 0; round < rounds; round++) {
        for(int i = 0; i < lengthOfAlgs; i++) {
            time[i] += times[round][i];
        }
    }
    
    cout << endl << "|-----------------------------------------------|" << endl;
    
    for(int i = 0; i < lengthOfAlgs; i++) {
        if(algorithms[i] != nullptr) {
            string a = to_string((int)(time[i]/rounds));
            while(a.size() < to_string(INT_MAX).size()) { a = " " + a; }
            cout << "|\t" << algorithms[i]->getName() << "\t\t" << a << " ms.\t|" << endl;
            cout << "|-----------------------------------------------|" << endl;
        }
    }
    
    cout << endl;
}

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
#include <ctime>
#include <sstream>
#include <locale>

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

int main(int argc, const char * argv[]) {
    srand((int)(time(0)));
    
    const int length = 10000;
    const int rounds = 10;
    const int lengthOfAlgs = 5;
    long times[rounds][lengthOfAlgs];
    
    Sort *algorithms[lengthOfAlgs];
    
    algorithms[0] = new QuickSort;
    algorithms[1] = new ShellSort;
    algorithms[2] = new InsertionSort;
    algorithms[3] = new SelectionSort;
    algorithms[4] = new MergeSort;
    
    for(int round = 0; round < rounds; round++) {
        cout << endl << "round " << round+1  << " : " << length << " elements."<< endl;
        
        // test sorting algorithms
        Comparable *array[length];
        
        for(int i = 0; i < length; i++) {
            array[i] = new Number(rand());
        }
        
        //printComparableArray(array, length);
        
        for(int i = 0; i < lengthOfAlgs; i++) {
            long start = clock();
            Comparable *array1[length];
            
            for(int i = 0; i < length; i++) {
                array1[i] = array[i];
            }
            
            algorithms[i]->sort(array1, length);
            
            times[round][i] = (long)((clock() - start)/double(CLOCKS_PER_SEC)*1000);
            
            cout << "\t" << algorithms[i]->getName() << " " << (isSorted(array1, length) ? "sorted" : "didn't sort") << " in " << convertToLocaleNumber(times[round][i]) << " ms." << endl;
            
            //printComparableArray(array1, length);
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
    
    cout << endl;
    
    for(int i = 0; i < lengthOfAlgs; i++) {
        cout << algorithms[i]->getName() << "\t\t" << (double)(time[i])/rounds << " ms." << endl;
    }
    
    cout << endl;
}

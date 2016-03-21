
#include <iostream>
#include "sorting algorithms/QuickSort.h"
#include "Comparable/Number.h"

using namespace std;

bool isSorted(Comparable* array[]) {
    for(int i = 0; i < sizeof(array); i++) {
        if(array[i] > array[i + 1]) {
            return false;
        }
    }
    return true;
}

void printArray(Comparable* array[]) {
    printf("array: [");
    for(int i = 0; i < sizeof(array); i++) {
        cout << array[i]->getValue();
        if(i != sizeof(array) - 1) {
            printf(", ");
        }
    }
    printf("]\n");
}

int main() {
    Comparable *array[1000];
    cout << sizeof(array);
    for(int i = 0; i < (sizeof(array)/sizeof(array[0])); i++) {
        array[i] = new Number((int)random());
    }
    QuickSort* q = new QuickSort();
    q->sort(array);
    printArray(array);
    printf("sorted? ");
    printf((isSorted(array) ? "true" : "false"));
    return 0;
}


#include <iostream>

using namespace std;

void quickSort(int arr[], int left, int right) {
    int i = left, j = right;
    int tmp;
    int pivot = arr[(left + right) / 2];

    /* partition */
    while (i <= j) {
        while (arr[i] < pivot)
            i++;
        while (arr[j] > pivot)
            j--;
        if (i <= j) {
            tmp = arr[i];
            arr[i] = arr[j];
            arr[j] = tmp;
            i++;
            j--;
        }
    };

    /* recursion */
    if (left < j)
        quickSort(arr, left, j);
    if (i < right)
        quickSort(arr, i, right);
}

bool isSorted(int array[]) {
    for(int i = 0; i < sizeof(array); i++) {
        if(array[i] > array[i + 1]) {
            return false;
        }
    }
    return true;
}

void printArray(int array[]) {
    printf("array: [");
    for(int i = 0; i < sizeof(array); i++) {
        cout << array[i];
        if(i != sizeof(array) - 1) {
            printf(", ");
        }
    }
    printf("]\n");
}

int main() {
    int array[1000];
    cout << sizeof(array);
    for(int i = 0; i < sizeof(array); i++) {
        array[i] = (int)random();
    }
    quickSort(array, 0, sizeof(array));
    printArray(array);
    printf("sorted? ");
    printf((isSorted(array) ? "true" : "false"));
    return 0;
}


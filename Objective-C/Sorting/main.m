//
//  main.m
//  Sorting
//
//  Created by Paul Kraft on 10.04.16.
//  Copyright © 2016 pauljohanneskraft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Sort.h"
#import "QuickSort.h"
#import "BubbleSort.h"
#import "InsertionSort.h"
#import "SelectionSort.h"
#import "MergeSort.h"
#import "IntroSort.h"

bool isSorted(NSMutableArray *array) {
    for( long i = 0; i < array.count - 1; i++ ) {
        if( [array objectAtIndex:i] > [array objectAtIndex:i + 1]) {
            return false;
        }
    }
    return true;
}

bool equals(NSMutableArray *array1, NSMutableArray *array2) {
    if( array1.count != array2.count ) return false;
    for( long i = 0; i < array1.count; i++ ) {
        if( [array1 objectAtIndex:i] != [array2 objectAtIndex:i]) {
            return false;
        }
    }
    return true;
}

void printArray(NSMutableArray *array) {
    for(int i = 0; i < array.count; i++) {
        NSLog(@"%@", [array objectAtIndex:i]);
    }
}

double testalg(Class algorithm, NSMutableArray *array) {
    double start = CFAbsoluteTimeGetCurrent();
    [algorithm sort:array];
    double end = CFAbsoluteTimeGetCurrent();
    return (end-start)*1000;
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        const int length = 30000;
        NSMutableArray *array = [NSMutableArray array];
        for (int i = 0; i < length; i++) {
            [array addObject: [NSNumber numberWithInt: arc4random()%20000]];
        }
        NSArray *algorithms = @[
                                //[BubbleSort class],
                                [QuickSort class],
                                //[InsertionSort class],
                                //[SelectionSort class],
                                [MergeSort class],
                                [IntroSort class]
                                ];
        for(int i = 0; i < algorithms.count; i++) {
            id algo = [algorithms objectAtIndex:i];
            NSMutableArray *copy = [array mutableCopy];
            double time = testalg(algo, copy);
            if( !isSorted(copy) ) {
                NSLog(@"%@ didn't sort in %f ms.", NSStringFromClass(algo), time);
                printArray(copy);
            } else {
                NSLog(@"%@ sorted in %f ms.", NSStringFromClass(algo), time);
            }
        }
    }
    return 0;
}

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

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        const int length = 3;
        NSMutableArray *array = [NSMutableArray array];
        for (int i = 0; i < length; i++) {
            [array addObject: [NSNumber numberWithInt: arc4random()%20000]];
        }
        NSMutableArray *copy = [array mutableCopy];
        [QuickSort sort:copy];
        if( equals(array, copy) ) {
            NSLog(@"equals");
        } else {
            NSLog(@"doesn't equal");
        }
        for(int i = 0; i < length; i++) {
            NSLog(@"%@", array[i]);
        }
        if( isSorted(copy) ) {
            NSLog(@"sorted");
        } else {
            NSLog(@"not sorted");
        }
        /*
        for(int i = 0; i < 1; i++) {
            NSMutableArray *nums;
            NSNumber *num1 = [NSNumber numberWithInteger:10];
            NSNumber *num2 = [NSNumber numberWithInteger:20];
            [nums addObject:num1];
            [nums addObject:num2];
         
            if(nums[0] < nums[1]) NSLog(@"%@ < %@", num1, num2);
            else if( nums[0] > nums[1]) NSLog(@"%@ > %@", num1, num2);
            else NSLog(@"%@ == %@", num1, num2);
         
        }
         */
    }
    return 0;
}

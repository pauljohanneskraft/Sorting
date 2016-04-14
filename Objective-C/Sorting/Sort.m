//
//  Sort.m
//  Sorting
//
//  Created by Paul Kraft on 10.04.16.
//  Copyright © 2016 pauljohanneskraft. All rights reserved.
//

#import "Sort.h"

@implementation Sort

+ (void) sort:(NSMutableArray *)array {
    [self doesNotRecognizeSelector:_cmd];
}

+ (void) sort:(NSMutableArray *)array withStart:(long)start end:(long)end {
    [self doesNotRecognizeSelector:_cmd];
}

+ (void) swap:(NSMutableArray *)array index1:(long)index1 index2:(long)index2 {
    id a = [array objectAtIndex:index1];
    [array replaceObjectAtIndex:index1 withObject:[array objectAtIndex:index2]];
    [array replaceObjectAtIndex:index2 withObject:a];
    if( array[index1] > array[index2] ) {
        NSLog(@"swapped %li and %li, values: i: %@, j: %@ -> WRONG!!", index1, index2, array[index1], array[index2]);
    }
}

@end

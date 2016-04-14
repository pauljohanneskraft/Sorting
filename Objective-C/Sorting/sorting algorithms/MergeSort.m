//
//  MergeSort.m
//  Sorting
//
//  Created by Paul Kraft on 14.04.16.
//  Copyright © 2016 pauljohanneskraft. All rights reserved.
//

#import "MergeSort.h"

@implementation MergeSort

+ (void) sort:(NSMutableArray *)array fromLeft:(long)start toRight:(long)end {
    if( start >= end ) return;
    long mid = (long)((start + end + 1) / 2);
    [self sort:array fromLeft:start toRight:mid - 1];
    [self sort:array fromLeft:mid toRight:end];
    [self merge:array fromLeft:start separatedBy:mid toRight:end];
}

+ (void) merge:(NSMutableArray *)array fromLeft:(long)start separatedBy:(long)mid toRight:(long)end {
    long i = start;
    while( i <= end && i < mid && mid <= end ) {
        if( [array objectAtIndex:mid] < [array objectAtIndex:i] ) {
            [self move:array from:mid downTo:i];
            mid++;
        }
        i++;
    }
}

@end

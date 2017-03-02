//
//  QuickSort.m
//  Sorting
//
//  Created by Paul Kraft on 12.04.16.
//  Copyright © 2016 pauljohanneskraft. All rights reserved.
//

#import "QuickSort.h"

@implementation QuickSort

+ (void) sort: (NSMutableArray *)array fromLeft: (long)start toRight: (long)end {
    if( start >= end ) return;
    long pivot = [QuickSort partition:array fromLeft:start toRight:end];
    [self sort:array fromLeft:start toRight:pivot - 1];
    [self sort:array fromLeft:pivot toRight:end];
}

+ (long) partition: (NSMutableArray *)array fromLeft:(long)start toRight:(long)end {
        //print("partition running, count: ", range.count)
    long i = start;
    long j = end;
    const long pivotIndex = end;
    do {
        while( [array objectAtIndex:i] <= [array objectAtIndex:pivotIndex] && i < end ) { i++; }
        while( [array objectAtIndex:j] >= [array objectAtIndex:pivotIndex] && start < j ) { j--; }
        if( i < j ) { [Sort swap:array index1:i index2:j]; }
    } while( i < j );
    
    if( [array objectAtIndex:i] > [array objectAtIndex:pivotIndex] ){ [Sort swap:array index1:i index2:pivotIndex]; }
    
    return i;
}

@end

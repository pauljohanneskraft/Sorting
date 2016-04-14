//
//  QuickSort.m
//  Sorting
//
//  Created by Paul Kraft on 12.04.16.
//  Copyright © 2016 pauljohanneskraft. All rights reserved.
//

#import "QuickSort.h"

@implementation QuickSort

+ (void) sort: (NSMutableArray *)array {
    [QuickSort sort:array withStart:0 end:array.count - 1];
}

+ (void) sort: (NSMutableArray *)array withStart: (long)start end: (long)end {
    if( start >= end ) return;
    long pivot = [QuickSort partition:array withStart:start end:end];
    [QuickSort sort:array withStart:start end:pivot - 1];
    [QuickSort sort:array withStart:pivot + 1 end:end];
}

+ (long) partition: (NSMutableArray *)array withStart: (long)start end: (long)end {
        //print("partition running, count: ", range.count)
    long i = start;
    long j = end - 1;
    const long pivotIndex = end;
    do {
        while( [array objectAtIndex:i] <= [array objectAtIndex:pivotIndex] && i < end ) { i++; }
        while( [array objectAtIndex:j] >= [array objectAtIndex:pivotIndex] && start < j ) { j--; }
        if( i < j ) { [Sort swap:array index1:i index2:j]; }
        
    } while( i < j );
    
    if( [array objectAtIndex:i] < [array objectAtIndex:pivotIndex] ){ [Sort swap:array index1:i index2:j]; }
    
    return i;
}

@end

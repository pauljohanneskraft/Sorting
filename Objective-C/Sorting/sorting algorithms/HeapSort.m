//
//  HeapSort.m
//  Sorting
//
//  Created by Paul Kraft on 14.04.16.
//  Copyright © 2016 pauljohanneskraft. All rights reserved.
//

#import "HeapSort.h"

@implementation HeapSort

+ (void) sort:(NSMutableArray *)array fromLeft:(long)start toRight:(long)end {
    if( end - start < 2) return;
    [self buildMaxHeap:array];
    NSMutableArray *sorted = [NSMutableArray array];
    while( array.count > 1 ) {
        [sorted insertObject:[array objectAtIndex:start] atIndex:0];
        [self swap:array index1:0 index2:array.count - 1];
        [array removeLastObject];
        [self maxHeapify:array root: 0];
    }
    [sorted insertObject:[array objectAtIndex:0] atIndex:0];
    for( long i = start; i <= end; i++) {
        [array insertObject:[sorted objectAtIndex:i] atIndex:i];
    }
}

+ (void) maxHeapify:(NSMutableArray *)array root:(long)rootIndex {
    long leftLeaf = ( rootIndex + 1 ) * 2 - 1;
    long rightLeaf = ( rootIndex + 1 ) * 2;
    if( leftLeaf > array.count - 1 ) return;
    id rootValue = array[rootIndex];
    long largestIndex = rootIndex;
    id largestValue = rootValue;
    
    if( array[leftLeaf] > largestValue ) {
        largestValue = array[leftLeaf];
        largestIndex = leftLeaf;
    }
    if( rightLeaf <= array.count - 1 ) {
        if( array[rightLeaf] > largestValue ) {
            largestValue = array[rightLeaf];
            largestIndex = rightLeaf;
        }
    }
    if( largestIndex != rootIndex ) {
        [self swap:array index1:rootIndex index2:largestIndex];
        [self maxHeapify:array root:largestIndex];
    }
}

+ (void) buildMaxHeap:(NSMutableArray *)array {
    if( array.count < 2 ) return;
    long mid = array.count/2;
    while( mid >= 0 ) {
        [self maxHeapify:array root:mid];
        mid--;
    }
}

@end

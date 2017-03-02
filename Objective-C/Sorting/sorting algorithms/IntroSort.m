//
//  IntroSort.m
//  Sorting
//
//  Created by Paul Kraft on 14.04.16.
//  Copyright © 2016 pauljohanneskraft. All rights reserved.
//

#import "IntroSort.h"
#import "SelectionSort.h"
#import "HeapSort.h"
#import "BinaryTreeSort.h"

@implementation IntroSort

+ (void) sort: (NSMutableArray *)array fromLeft: (long)start toRight: (long)end {
    [self sort:array fromLeft:start toRight:end withDepth:log(array.count)];
}

+ (void) sort: (NSMutableArray *)array fromLeft: (long)start toRight: (long)end withDepth:(long)depth {
    if( start >= end ) return;
    if( end - start < 20 ) {
        [SelectionSort sort:array fromLeft:start toRight:end];
        return;
    }
    if( depth < 0 ) {
        [BinaryTreeSort sort:array fromLeft:start toRight:end];
        //[HeapSort sort:array fromLeft:start toRight:end];
        return;
    }
    long pivot = [QuickSort partition:array fromLeft:start toRight:end];
    [self sort:array fromLeft:start toRight:pivot - 1 withDepth: depth - 1];
    [self sort:array fromLeft:pivot toRight:end withDepth:depth - 1];
}

@end

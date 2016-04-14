//
//  SelectionSort.m
//  Sorting
//
//  Created by Paul Kraft on 14.04.16.
//  Copyright © 2016 pauljohanneskraft. All rights reserved.
//

#import "SelectionSort.h"

@implementation SelectionSort

+ (void) sort:(NSMutableArray *)array fromLeft:(long)start toRight:(long)end {
    for( long i = start; i <= end; i++) {
        long min = i;
        for( long j = i + 1; j <= end; j++ ) {
            if( [array objectAtIndex:j] < [array objectAtIndex:min])
                min = j;
        }
        [self swap:array index1:i index2:min];
    }
}

@end

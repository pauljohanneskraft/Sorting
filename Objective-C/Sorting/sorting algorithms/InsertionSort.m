//
//  InsertionSort.m
//  Sorting
//
//  Created by Paul Kraft on 14.04.16.
//  Copyright © 2016 pauljohanneskraft. All rights reserved.
//

#import "InsertionSort.h"

@implementation InsertionSort

+ (void) sort:(NSMutableArray *)array fromLeft:(long)start toRight:(long)end {
    for( long i = start; i <= end; i++ ) {
        long k = start;
        while(k < i && [array objectAtIndex:k] < [array objectAtIndex:i]) {
            
            k++;
        }
        [self move:array from:i downTo:k];
    }
}

@end

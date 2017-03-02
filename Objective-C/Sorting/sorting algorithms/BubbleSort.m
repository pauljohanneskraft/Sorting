//
//  BubbleSort.m
//  Sorting
//
//  Created by Paul Kraft on 14.04.16.
//  Copyright © 2016 pauljohanneskraft. All rights reserved.
//

#import "BubbleSort.h"

@implementation BubbleSort

+ (void) sort:(NSMutableArray *)array fromLeft:(long)start toRight:(long)end {
    bool didChange;
    do {
        didChange = false;
        for(long i = start; i < end; i++) {
            if( [array objectAtIndex:i] > [array objectAtIndex:i+1] ) {
                [self swap:array index1:i index2:i+1];
                didChange = true;
            }
        }
    } while( didChange );
}

@end

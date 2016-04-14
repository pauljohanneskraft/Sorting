//
//  QuickSort.h
//  Sorting
//
//  Created by Paul Kraft on 12.04.16.
//  Copyright © 2016 pauljohanneskraft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Sort.h"

@interface QuickSort : Sort

//+ (void) sort: (NSMutableArray *)array;

//+ (void) sort: (NSMutableArray *)array withStart: (long)start end: (long)end;

+ (long) partition: (NSMutableArray *)array withStart: (long)start end: (long)end;

@end

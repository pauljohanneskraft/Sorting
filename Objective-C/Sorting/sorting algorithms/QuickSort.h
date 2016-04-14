//
//  QuickSort.h
//  Sorting
//
//  Created by Paul Kraft on 12.04.16.
//  Copyright © 2016 pauljohanneskraft. All rights reserved.
//

#import "Sort.h"

@interface QuickSort : Sort

+ (long) partition: (NSMutableArray *)array fromLeft:(long)start toRight:(long)end;

@end

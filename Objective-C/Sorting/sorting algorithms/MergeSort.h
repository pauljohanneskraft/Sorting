//
//  MergeSort.h
//  Sorting
//
//  Created by Paul Kraft on 14.04.16.
//  Copyright © 2016 pauljohanneskraft. All rights reserved.
//

#import "Sort.h"

@interface MergeSort : Sort

+ (void) merge:(NSMutableArray *)array fromLeft:(long)start separatedBy:(long)mid toRight:(long)end;

@end

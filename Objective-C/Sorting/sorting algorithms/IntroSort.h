//
//  IntroSort.h
//  Sorting
//
//  Created by Paul Kraft on 14.04.16.
//  Copyright © 2016 pauljohanneskraft. All rights reserved.
//

#import "QuickSort.h"

@interface IntroSort : QuickSort

+ (void) sort: (NSMutableArray *)array fromLeft: (long)start toRight: (long)end withDepth:(long)depth;

@end

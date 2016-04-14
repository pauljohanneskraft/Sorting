//
//  Sort.h
//  Sorting
//
//  Created by Paul Kraft on 10.04.16.
//  Copyright © 2016 pauljohanneskraft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Sort : NSObject

+ (void) sort:(NSMutableArray *)array;

+ (void) sort:(NSMutableArray *)array withStart:(long)start end:(long)end;

+ (void) swap:(NSMutableArray *)array index1:(long)index1 index2:(long)index2;

@end

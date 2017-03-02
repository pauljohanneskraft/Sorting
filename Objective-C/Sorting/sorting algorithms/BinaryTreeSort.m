//
//  BinaryTreeSort.m
//  Sorting
//
//  Created by Paul Kraft on 14.04.16.
//  Copyright © 2016 pauljohanneskraft. All rights reserved.
//

#import "BinaryTreeSort.h"

@interface Node : NSObject {
    Node *left;
    Node *right;
    id info;
}

- (Node *) initWithInfo:(id)newInfo;

- (void) insert:(id)newInfo;

- (NSMutableArray *) getArray;


@end

@implementation Node

- (Node *) initWithInfo:(id)newInfo {
    right = nil;
    left = nil;
    info = newInfo;
    return self;
}

- (void) insert:(id)newInfo {
    if(newInfo < info ) {
        if( left == nil ) left = [[Node alloc] initWithInfo:newInfo];
        else [left insert:newInfo];
    } else {
        if( right == nil ) right = [[Node alloc] initWithInfo:newInfo];
        else [right insert:newInfo];
    }
}

- (NSMutableArray *) getArray {
    NSMutableArray *array = [NSMutableArray array];
    if( left != nil ) [array addObjectsFromArray:[left getArray]];
    [array addObject:info];
    if( right != nil) [array addObjectsFromArray:[right getArray]];
    return array;
}

@end

@implementation BinaryTreeSort

+ (void) sort:(NSMutableArray *)array fromLeft:(long)start toRight:(long)end {
    if( start >= end ) return;
    Node *root = [[Node alloc] initWithInfo:[array objectAtIndex:start]];
    for( long i = start + 1; i <= end; i++ ) {
        [root insert:[array objectAtIndex:i]];
    }
    NSMutableArray *interimArray = [root getArray];
    for( long i = 0; i <= end - start; i++ ) {
        [array replaceObjectAtIndex:i+start withObject:[interimArray objectAtIndex:i]];
    }
}

@end


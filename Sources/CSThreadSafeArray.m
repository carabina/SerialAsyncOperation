//
//  CSThreadSafeArray.m
//  SerialAsyncOperation
//
//  Created by Chris Hu on 03/05/2018.
//  Copyright © 2018 com.icetime. All rights reserved.
//

#import "CSThreadSafeArray.h"

@implementation CSThreadSafeArray {
    NSMutableArray *array;
    dispatch_queue_t queue;
}

#pragma mark - init

- (instancetype)init
{
    self = [super init];
    if (self) {
        array = [[NSMutableArray alloc] init];
        queue = dispatch_queue_create("com.icetime.CSThreadSafeArray", DISPATCH_QUEUE_CONCURRENT);
    }
    return self;
}

#pragma mark - method

- (NSUInteger)count {
    __block NSUInteger count = -1;
    dispatch_sync(queue, ^{
        count = array.count;
    });
    return count;
}

- (id)objectAtIndex:(NSUInteger)index {
    __block id obj = nil;
    dispatch_sync(queue, ^{
        obj = [array objectAtIndex:index];
    });
    return obj;
}

- (BOOL)containsObject:(id)anObject {
    __block BOOL isContained = NO;
    dispatch_sync(queue, ^{
        isContained = [array containsObject:anObject];
    });
    return isContained;
}

- (void)enumerateObjectsUsingBlock:(void (^)(id obj, NSUInteger idx, BOOL *stop))block {
    dispatch_sync(queue, ^{
        [array enumerateObjectsUsingBlock:block];
    });
}

#pragma mark - mutable

- (void)addObject:(id)anObject {
    dispatch_barrier_async(queue, ^{
        [array addObject:anObject];
    });
}

- (void)addObjectsFromArray:(NSArray *)otherArray {
    dispatch_barrier_async(queue, ^{
        [array addObjectsFromArray:otherArray];
    });
}

- (void)insertObject:(id)anObject atIndex:(NSUInteger)index {
    dispatch_barrier_async(queue, ^{
        [array insertObject:anObject atIndex:index];
    });
}

- (void)removeObject:(id)anObject {
    dispatch_barrier_async(queue, ^{
        [array removeObject:anObject];
    });
}

- (void)removeObjectAtIndex:(NSUInteger)index {
    dispatch_barrier_async(queue, ^{
        [array removeObjectAtIndex:index];
    });
}

- (void)removeAllObjects {
    dispatch_barrier_async(queue, ^{
        [array removeAllObjects];
    });
}

@end

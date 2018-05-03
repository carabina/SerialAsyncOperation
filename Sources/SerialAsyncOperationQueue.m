//
//  SerialAsyncOperationQueue.m
//  SerialAsyncOperation
//
//  Created by Chris Hu on 03/05/2018.
//  Copyright © 2018 com.icetime. All rights reserved.
//

#import "SerialAsyncOperationQueue.h"
#import "CSThreadSafeArray.h"


@interface SerialAsyncOperationQueue ()

@property (nonatomic, strong) CSThreadSafeArray *observers;

@end


@implementation SerialAsyncOperationQueue

- (void)dealloc
{
    [_observers removeAllObjects];
    _observers = nil;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.maxConcurrentOperationCount = 1;
        self.name = @"com.icetime.SerialAsyncOperationQueue";
        
        self.observers = [[CSThreadSafeArray alloc] init];
    }
    return self;
}

- (void)addOperation:(SerialAsyncOperation *)op {
    [super addOperation:op];
    
    op.operationQueue = self;
}

// MARK: - getters

- (SerialAsyncOperation *)executingOperation {
    return (SerialAsyncOperation *)self.operations.firstObject;
}

// MARK: - observer

- (void)addObserver:(id<SerialAsyncOperationQueueDelegate>)observer {
    BOOL isExisting = NO;
    for (NSValue *value in self.observers) {
        if ([value.nonretainedObjectValue isEqual:observer]) {
            isExisting = YES;
            break;
        }
    }
    
    if (!isExisting) {
        [self.observers addObject:[NSValue valueWithNonretainedObject:observer]];
    }
}

- (void)removeObserver:(id<SerialAsyncOperationQueueDelegate>)observer {
    NSValue *existingValue = nil;
    for (NSValue *value in self.observers) {
        if ([value.nonretainedObjectValue isEqual:observer]) {
            existingValue = value;
            break;
        }
    }
    
    if (existingValue) {
        [self.observers removeObject:existingValue];
    }
}

// MARK: - SerialAsyncOperationDelegate

- (void)SerialAsyncOperation:(SerialAsyncOperation *)operation
                  isFinished:(BOOL)isFinished {
    [self.observers enumerateObjectsUsingBlock:^(NSValue *value, NSUInteger idx, BOOL * _Nonnull stop) {
        id<SerialAsyncOperationQueueDelegate> observer = value.nonretainedObjectValue;
        if ([observer respondsToSelector:@selector(SerialAsyncOperationQueue:operation:isFinished:)]) {
            [observer SerialAsyncOperationQueue:self operation:operation isFinished:isFinished];
        }
    }];
}

- (void)SerialAsyncOperation:(SerialAsyncOperation *)operation
                 isCancelled:(BOOL)isCancelled {
    [self.observers enumerateObjectsUsingBlock:^(NSValue *value, NSUInteger idx, BOOL * _Nonnull stop) {
        id<SerialAsyncOperationQueueDelegate> observer = value.nonretainedObjectValue;
        if ([observer respondsToSelector:@selector(SerialAsyncOperationQueue:operation:isCancelled:)]) {
            [observer SerialAsyncOperationQueue:self operation:operation isCancelled:isCancelled];
        }
    }];
}

- (void)SerialAsyncOperation:(SerialAsyncOperation *)operation
           executingProgress:(double)progress {
    [self.observers enumerateObjectsUsingBlock:^(NSValue *value, NSUInteger idx, BOOL * _Nonnull stop) {
        id<SerialAsyncOperationQueueDelegate> observer = value.nonretainedObjectValue;
        if ([observer respondsToSelector:@selector(SerialAsyncOperationQueue:operation:executingProgress:)]) {
            [observer SerialAsyncOperationQueue:self operation:operation executingProgress:progress];
        }
    }];
}

@end

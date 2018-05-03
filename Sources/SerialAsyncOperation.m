//
//  SerialAsyncOperation.m
//  SerialAsyncOperation
//
//  Created by Chris Hu on 03/05/2018.
//  Copyright © 2018 com.icetime. All rights reserved.
//

#import "SerialAsyncOperation.h"


@interface SerialAsyncOperation ()

// 因这些属性是readonly, 不会自动触发KVO. 需要手动触发KVO, 见setter方法.
@property (assign, nonatomic, getter = isExecuting)     BOOL executing;
@property (assign, nonatomic, getter = isFinished)      BOOL finished;
@property (assign, nonatomic, getter = isCancelled)     BOOL cancelled;

@end


@implementation SerialAsyncOperation

@synthesize executing       = _executing;
@synthesize finished        = _finished;
@synthesize cancelled       = _cancelled;

- (void)setExecuting:(BOOL)executing
{
    [self willChangeValueForKey:@"isExecuting"];
    _executing = executing;
    [self didChangeValueForKey:@"isExecuting"];
}

- (void)setFinished:(BOOL)finished
{
    [self willChangeValueForKey:@"isFinished"];
    _finished = finished;
    [self didChangeValueForKey:@"isFinished"];
}

- (void)setCancelled:(BOOL)cancelled
{
    [self willChangeValueForKey:@"isCancelled"];
    _cancelled = cancelled;
    [self didChangeValueForKey:@"isCancelled"];
}

- (void)start {
    if ([self p_checkCancelled]) {
        return;
    }
    
    self.executing = YES;
    
    [self main];
}

- (void)main {
    if ([self p_checkCancelled]) {
        return;
    }
    
    [self asyncOperation];
    
    while (self.isExecuting) {
        if ([self p_checkCancelled]) {
            return;
        }
    }
    
    if ([self p_checkCancelled]) {
        return;
    }
    
    if ([self.operationDelegate respondsToSelector:@selector(SerialAsyncOperation:isFinished:)]) {
        [self.operationDelegate SerialAsyncOperation:self isFinished:YES];
    }
    
    if ([self.operationQueue respondsToSelector:@selector(SerialAsyncOperation:isFinished:)]) {
        [self.operationQueue SerialAsyncOperation:self isFinished:YES];
    }
}

- (void)cancel {
    [super cancel];
    
    [self cancelAsyncOperation];
    
    self.cancelled = YES;
    
    if (self.isExecuting) {
        self.executing = NO;
        self.finished = YES;
    } else {
        self.finished = NO;
    }
}

- (BOOL)p_checkCancelled {
    if (self.isCancelled) {
        if ([self.operationDelegate respondsToSelector:@selector(SerialAsyncOperation:isCancelled:)]) {
            [self.operationDelegate SerialAsyncOperation:self isCancelled:YES];
        }
        
        if ([self.operationQueue respondsToSelector:@selector(SerialAsyncOperation:isCancelled:)]) {
            [self.operationQueue SerialAsyncOperation:self isCancelled:YES];
        }
        
        // must set finished to be YES.
        self.finished = YES;
        return YES;
    }
    
    return NO;
}

- (void)asyncOperation {
    [NSException raise:NSInternalInconsistencyException
                format:@"You must override %@ in a subclass!", NSStringFromSelector(_cmd)];
}

- (void)finishAsyncOperation {
    self.executing = NO;
    self.finished = YES;
}

- (void)cancelAsyncOperation {
    
}

- (void)updateExecutingProgress:(double)progress {
    if ([self.operationDelegate respondsToSelector:@selector(SerialAsyncOperation:isFinished:)]) {
        [self.operationDelegate SerialAsyncOperation:self executingProgress:progress];
    }
    
    if ([self.operationQueue respondsToSelector:@selector(SerialAsyncOperation:executingProgress:)]) {
        [self.operationQueue SerialAsyncOperation:self executingProgress:progress];
    }
}

@end

//
//  SerialAsyncOperationQueue.h
//  SerialAsyncOperation
//
//  Created by Chris Hu on 03/05/2018.
//  Copyright © 2018 com.icetime. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SerialAsyncOperation.h"


@protocol SerialAsyncOperationQueueDelegate;


@interface SerialAsyncOperationQueue : NSOperationQueue <
    SerialAsyncOperationDelegate
>

@property (nonatomic, strong) SerialAsyncOperation *executingOperation;

// MARK: - observer

/**
 use observer to notify the operation status
 */
- (void)addObserver:(id<SerialAsyncOperationQueueDelegate>)observer;
- (void)removeObserver:(id<SerialAsyncOperationQueueDelegate>)observer;

@end


@protocol SerialAsyncOperationQueueDelegate <NSObject>

@optional
- (void)SerialAsyncOperationQueue:(SerialAsyncOperationQueue *)operationQueue
                        operation:(SerialAsyncOperation *)operation
                       isFinished:(BOOL)isFinished;

- (void)SerialAsyncOperationQueue:(SerialAsyncOperationQueue *)operationQueue
                        operation:(SerialAsyncOperation *)operation
                      isCancelled:(BOOL)isCancelled;

- (void)SerialAsyncOperationQueue:(SerialAsyncOperationQueue *)operationQueue
                        operation:(SerialAsyncOperation *)operation
                executingProgress:(double)progress;

@end

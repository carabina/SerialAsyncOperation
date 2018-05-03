//
//  SerialAsyncOperation.h
//  SerialAsyncOperation
//
//  Created by Chris Hu on 03/05/2018.
//  Copyright © 2018 com.icetime. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SerialAsyncOperationDelegate;


@interface SerialAsyncOperation : NSOperation

@property (nonatomic, weak) id<SerialAsyncOperationDelegate> operationDelegate;
@property (nonatomic, weak) NSOperationQueue <SerialAsyncOperationDelegate> *operationQueue;

/**
 @required
 Override asyncOperation() to implement your async operation.
 MUST override it and DO NOT call it yourself.
 */
- (void)asyncOperation;

/**
 Override finishAsyncOperation() to custom how to finish.
 MUST CALL finishAsyncOperation() to finish async operation by yourself.
 Maybe called by NSURLSessionDelegate method or user action.
 */
- (void)finishAsyncOperation;

/**
 Override cancelAsyncOperation() to custom how to cancel.
 */
- (void)cancelAsyncOperation;

/**
 Report progress of async operation
 Maybe called by NSURLSessionDelegate method or user action.
 */
- (void)updateExecutingProgress:(double)progress;

@end


@protocol SerialAsyncOperationDelegate <NSObject>

@optional
- (void)SerialAsyncOperation:(SerialAsyncOperation *)operation
                  isFinished:(BOOL)isFinished;

- (void)SerialAsyncOperation:(SerialAsyncOperation *)operation
                 isCancelled:(BOOL)isCancelled;

- (void)SerialAsyncOperation:(SerialAsyncOperation *)operation
           executingProgress:(double)progress;

@end

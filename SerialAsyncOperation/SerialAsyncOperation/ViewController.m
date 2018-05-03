//
//  ViewController.m
//  SerialAsyncOperation
//
//  Created by Chris Hu on 03/05/2018.
//  Copyright © 2018 com.icetime. All rights reserved.
//

#import "ViewController.h"
#import "SerialAsyncOperationQueue.h"
#import "SerialAsyncCountdown.h"
#import "SerialAsyncDownload.h"


@interface ViewController () <
    SerialAsyncOperationDelegate,
    SerialAsyncOperationQueueDelegate
>

@end

@implementation ViewController {
    SerialAsyncOperationQueue *asyncOperationQueue;
}

- (void)dealloc
{
    [asyncOperationQueue removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor greenColor];
    
    
    asyncOperationQueue = [[SerialAsyncOperationQueue alloc] init];
    
    [asyncOperationQueue addObserver:self];
    
    
    /*
    SerialAsyncCountdown *op1 = [[SerialAsyncCountdown alloc] init];
    op1.operationDelegate = self;
    
    SerialAsyncCountdown *op2 = [[SerialAsyncCountdown alloc] init];
    op2.operationDelegate = self;
    
    SerialAsyncCountdown *op3 = [[SerialAsyncCountdown alloc] init];
    op3.operationDelegate = self;
    
    SerialAsyncCountdown *op4 = [[SerialAsyncCountdown alloc] init];
    op4.operationDelegate = self;
    */
    
    
    SerialAsyncDownload *op1 = [[SerialAsyncDownload alloc] init];
    op1.downloadUrlString = @"https://api.beautyplus.com/archive/f1af1bf8462495518e224afea26be1f6.zip";
    op1.operationDelegate = self;
    
    SerialAsyncDownload *op2 = [[SerialAsyncDownload alloc] init];
    op2.downloadUrlString = @"https://api.beautyplus.com/archive/92976a327c32ef3724fb2c638c5d6f3f.zip";
    op2.operationDelegate = self;
    
    SerialAsyncDownload *op3 = [[SerialAsyncDownload alloc] init];
    op3.downloadUrlString = @"https://api.beautyplus.com/archive/5d323d05b9157a4e87f023a2c4cd53e4.zip";
    op3.operationDelegate = self;
    
    SerialAsyncDownload *op4 = [[SerialAsyncDownload alloc] init];
    op4.downloadUrlString = @"https://api.beautyplus.com/archive/b6c839dcdaba4a4a99e779b54e119a30.zip";
    op4.operationDelegate = self;
    
    
    [asyncOperationQueue addOperation:op1];
    [asyncOperationQueue addOperation:op2];
    [asyncOperationQueue addOperation:op3];
    [asyncOperationQueue addOperation:op4];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)),
                   dispatch_get_main_queue(), ^{
//                       [op1 cancel];
//                       [op2 cancel];
//                       [op3 cancel];
//                       [op4 cancel];
                   });
}

// MARK: - SerialAsyncOperationDelegate

- (void)SerialAsyncOperation:(SerialAsyncOperation *)operation
                  isFinished:(BOOL)isFinished {
    NSLog(@"SerialAsyncOperationDelegate operation %@ isFinished %d", operation, isFinished);
}

- (void)SerialAsyncOperation:(SerialAsyncOperation *)operation
                  isCancelled:(BOOL)isCancelled {
    NSLog(@"SerialAsyncOperationDelegate operation %@ isCancelled %d", operation, isCancelled);
}

- (void)SerialAsyncOperation:(SerialAsyncOperation *)operation
           executingProgress:(double)progress {
    NSLog(@"SerialAsyncOperationDelegate operation %@ executingProgress %f", operation, progress);
}

// MARK: - SerialAsyncOperationQueueDelegate

- (void)SerialAsyncOperationQueue:(SerialAsyncOperationQueue *)operationQueue
                        operation:(SerialAsyncOperation *)operation
                       isFinished:(BOOL)isFinished {
    NSLog(@"SerialAsyncOperationQueueDelegate operation %@ isFinished %d", operation, isFinished);
    NSLog(@"");
}

- (void)SerialAsyncOperationQueue:(SerialAsyncOperationQueue *)operationQueue
                        operation:(SerialAsyncOperation *)operation
                      isCancelled:(BOOL)isCancelled {
    NSLog(@"SerialAsyncOperationQueueDelegate operation %@ isCancelled %d", operation, isCancelled);
    NSLog(@"");
}

- (void)SerialAsyncOperationQueue:(SerialAsyncOperationQueue *)operationQueue
                        operation:(SerialAsyncOperation *)operation
                executingProgress:(double)progress {
    NSLog(@"SerialAsyncOperationQueueDelegate operation %@ executingProgress %f", operation, progress);
}

@end

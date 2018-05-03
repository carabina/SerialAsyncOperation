//
//  SerialAsyncCountdown.m
//  SerialAsyncOperation
//
//  Created by Chris Hu on 03/05/2018.
//  Copyright © 2018 com.icetime. All rights reserved.
//

#import "SerialAsyncCountdown.h"

@implementation SerialAsyncCountdown

- (void)asyncOperation {
    dispatch_async(dispatch_get_global_queue(0, DISPATCH_QUEUE_PRIORITY_DEFAULT), ^{
        for (int i = 0; i<10000; i++) {
            NSLog(@"%d",i);
        }
        
        [self finishAsyncOperation];
    });
}

@end

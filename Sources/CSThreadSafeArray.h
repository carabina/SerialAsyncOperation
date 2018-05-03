//
//  CSThreadSafeArray.h
//  SerialAsyncOperation
//
//  Created by Chris Hu on 03/05/2018.
//  Copyright © 2018 com.icetime. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 ThreadSafe NSMutableArray using dispatch_queue_t.
 */
@interface CSThreadSafeArray : NSMutableArray

@end

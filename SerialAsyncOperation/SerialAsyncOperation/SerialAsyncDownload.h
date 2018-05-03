//
//  SerialAsyncDownload.h
//  SerialAsyncOperation
//
//  Created by Chris Hu on 03/05/2018.
//  Copyright © 2018 com.icetime. All rights reserved.
//

#import "SerialAsyncOperation.h"

@interface SerialAsyncDownload : SerialAsyncOperation

@property (nonatomic, strong) NSString *downloadUrlString;

@end

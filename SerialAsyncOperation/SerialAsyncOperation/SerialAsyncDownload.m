//
//  SerialAsyncDownload.m
//  SerialAsyncOperation
//
//  Created by Chris Hu on 03/05/2018.
//  Copyright © 2018 com.icetime. All rights reserved.
//

#import "SerialAsyncDownload.h"


@interface SerialAsyncDownload () <
    NSURLSessionDownloadDelegate
>

@end


@implementation SerialAsyncDownload {
    NSURLSession *urlSession;
    NSURLSessionDownloadTask *downloadTask;
}

- (void)asyncOperation {
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    config.timeoutIntervalForRequest = 20.f;
    config.timeoutIntervalForResource = 20.f;
    
    urlSession = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURL *url = [NSURL URLWithString:self.downloadUrlString];
    NSURLRequest *reqeust = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:20.f];
    
    downloadTask = [urlSession downloadTaskWithRequest:reqeust];
    [downloadTask resume];
}

- (void)finishAsyncOperation {
    [super finishAsyncOperation];
    
    [urlSession finishTasksAndInvalidate];
    urlSession = nil;
}

- (void)cancelAsyncOperation {
    [downloadTask cancel];
    
    [urlSession invalidateAndCancel];
    urlSession = nil;
}

// MARK: - NSURLSessionDownloadDelegate

- (void)URLSession:(NSURLSession *)session
      downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location {
    NSLog(@"SerialAsyncDownload finished : %@", downloadTask.currentRequest.URL.absoluteString);
    
    [self finishAsyncOperation];
}

/* Sent periodically to notify the delegate of download progress. */
- (void)URLSession:(NSURLSession *)session
      downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    double progress = 1.0 * totalBytesWritten / totalBytesExpectedToWrite;
    
    NSLog(@"SerialAsyncDownload progress : %@, %f", downloadTask.currentRequest.URL.absoluteString, progress);
    
    [self updateExecutingProgress:progress];
}

- (void)URLSession:(NSURLSession *)session
              task:(NSURLSessionTask *)task
didCompleteWithError:(nullable NSError *)error {
    if (!error) {
        return;
    }
    NSLog(@"SerialAsyncDownload didCompleteWithError : %@", error.localizedDescription);
    switch (error.code) {
        case -999: // timeoutIntervalForResource
            [self cancel];
            break;
        case -1001: // timeout
            [self cancel];
            break;
        default:
            [self cancel];
            break;
    }
}

@end

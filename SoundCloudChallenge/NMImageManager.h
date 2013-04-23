//
//  NMImageDownloader.h
//  SoundCloudChallenge
//
//  Created by Nicola Miotto on 4/23/13.
//  Copyright (c) 2013 Nicola Miotto. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^ImageDownloadBlock) (UIImage *image);

@interface NMImageManager : NSObject<NSURLConnectionDelegate>

- (UIImage *)imageForURL:(NSURL *)url;
- (void)fetchImageForURL:(NSURL *)url
               withBlock:(ImageDownloadBlock)block;

@end

//
//  NMImageDownloader.m
//  SoundCloudChallenge
//
//  Created by Nicola Miotto on 4/23/13.
//  Copyright (c) 2013 Nicola Miotto. All rights reserved.
//

#import "NMImageManager.h"

static NSCache *cache;

@implementation NMImageManager
{
    ImageDownloadBlock __imageBlock;
    NSURLRequest      *__request;
}

+ (void)initialize
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cache = [NSCache new];
    });
}

- (UIImage *)imageForURL:(NSURL *)url
{
    UIImage *image;
    @synchronized(cache){
        image = [cache objectForKey:url.absoluteString];
    }
    
    return image;
}

- (void)fetchImageForURL:(NSURL *)url
               withBlock:(ImageDownloadBlock)block
{
    __imageBlock = [block copy];
    __request = [NSURLRequest requestWithURL:url];
    [NSURLConnection connectionWithRequest:__request delegate:self];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    UIImage *image = [[UIImage alloc] initWithData:data];
    CGRect topHalf = CGRectMake(0, 0, image.size.width, image.size.height / 2);
    UIImage *cropped = [image croppedToRect:topHalf];
    
    @synchronized(cache){
        [cache setObject:cropped forKey:__request.URL.absoluteString];
    }
    
    __imageBlock(cropped);
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    __imageBlock(nil);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
}

@end

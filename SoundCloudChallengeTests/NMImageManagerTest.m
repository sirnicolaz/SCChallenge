//
//  NMImageManagerTest.m
//  SoundCloudChallenge
//
//  Created by Nicola Miotto on 4/23/13.
//  Copyright (c) 2013 Nicola Miotto. All rights reserved.
//

#import "Kiwi.h"
#import "NMImageManager.h"

SPEC_BEGIN(ImageManager)

describe(@"Image manager", ^{
    
    __block NMImageManager *manager = [NMImageManager new];
    __block NSURL *imageURL = [NSURL URLWithString:@"https://w1.sndcdn.com/VbrzqYHVt4tV_m.png"];
    
    context(@"Fetching an image", ^{
        
        
        it(@"should not return a local image if already retrieved", ^{
            
            UIImage *image = [manager imageForURL:imageURL];
            [image shouldBeNil];
        });
        
        it(@"should fetch the image if not already retrieved", ^{
            
            __block UIImage *resultImage = nil;
            [manager fetchImageForURL:imageURL withBlock:^(UIImage *image) {
                resultImage = image;
            }];
            
            [[expectFutureValue(resultImage) shouldEventuallyBeforeTimingOutAfter(10)] beNonNil];
        });
        
        it(@"should get a local image if already retrieved", ^{
            
            __block UIImage *fetchedImage;
            [manager fetchImageForURL:imageURL withBlock:^(UIImage *image) {
                fetchedImage = image;
            }];
            
            [[expectFutureValue(fetchedImage) shouldEventuallyBeforeTimingOutAfter(10)] beNonNil];
            
            UIImage *localImage = [manager imageForURL:imageURL];
            [localImage shouldNotBeNil];
            
        });
    });
    
    
});

SPEC_END

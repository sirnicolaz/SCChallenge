//
//  UIImage+Additions.m
//  SoundCloudChallenge
//
//  Created by Nicola Miotto on 4/23/13.
//  Copyright (c) 2013 Nicola Miotto. All rights reserved.
//

#import "UIImage+Additions.h"

@implementation UIImage (Additions)

- (UIImage *)croppedToRect:(CGRect)rect
{
    CGImageRef imageRef = CGImageCreateWithImageInRect([self CGImage], rect);
    UIImage *cropped = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    
    return cropped;
}

@end

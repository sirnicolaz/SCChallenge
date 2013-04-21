//
//  UIView+Additions.m
//  SoundCloudChallenge
//
//  Created by Nicola Miotto on 4/21/13.
//  Copyright (c) 2013 Nicola Miotto. All rights reserved.
//

#import "UIView+Additions.h"

@implementation UIView (Additions)

+ (id)selfFromNib
{
    Class theClass = [self class];
    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:[theClass description] owner:nil options:nil];
    for(id currentObject in topLevelObjects) {
        if([currentObject isKindOfClass:[self class]]) {
            return currentObject;
        }
    }
    return nil;
}

@end

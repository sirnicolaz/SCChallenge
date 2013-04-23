//
//  UITableView+Operation.m
//  SoundCloudChallenge
//
//  Created by Nicola Miotto on 4/22/13.
//  Copyright (c) 2013 Nicola Miotto. All rights reserved.
//

#import "UITableView+Operation.h"
#import <objc/runtime.h>

#define kNMQueueKey @"queue"

@implementation UITableView (Operation)

@dynamic queue;

- (void)setQueue:(NSOperationQueue *)queue
{
    [self willChangeValueForKey:kNMQueueKey];
    objc_setAssociatedObject(self, kNMQueueKey, queue, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:kNMQueueKey];
}

- (NSOperationQueue *)queue
{
    return objc_getAssociatedObject(self, kNMQueueKey);
}

@end

//
//  NMTrack.h
//  SoundCloudChallenge
//
//  Created by Nicola Miotto on 4/18/13.
//  Copyright (c) 2013 Nicola Miotto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NMTrack : NSObject

@property (assign) NSInteger identifier;

@property NSString  *title;
@property NSDate    *createdAt;
@property NSURL     *waveFormURL;

@end

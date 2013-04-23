//
//  NMTracksManagerTest.m
//  SoundCloudChallenge
//
//  Created by Nicola Miotto on 4/23/13.
//  Copyright (c) 2013 Nicola Miotto. All rights reserved.
//

#import "Kiwi.h"
#import "NMTracksManager.h"
#import "NMTrack.h"
#import "NSDate+Formatting.h"
#import "NMSoundCloudAPI.h"

SPEC_BEGIN(TrackManager)

describe(@"Track manager", ^{
    
    __block NMTracksManager *manager = [NMTracksManager new];
    
    context(@"given a JSON representation of tracks", ^{
        
        __block NSDictionary *jsonTrack = @{kNMSoundCloudKeyTrackDate: @"2011/11/11 11:11:11 +0000",
                                            kNMSoundCloudKeyTrackIdentifier : @(42),
                                            kNMSoundCloudKeyTrackTitle : @"The Hitchhiker's Guide to The Galaxy",
                                            kNMSoundCloudKeyTrackWaveURL : @"http://www.wave.com/2.png"};
        __block NSArray *moreTracks = @[jsonTrack, jsonTrack];
        
        it(@"should build a track reflecting the representation", ^{
            
            NMTrack *track = [manager buildTrackWithJSONDictionary:jsonTrack];
            
            [[track.title should] equal:@"The Hitchhiker's Guide to The Galaxy"];
            [[theValue(track.identifier) should] equal:theValue(42)];
            [[[track.createdAt stringValueWithFormat:@"yyyy/MM/dd kk:mm:ss ZZZZ"] should]
             equal:@"2011/11/11 11:11:11 GMT"];
            [[track.waveFormURL.absoluteString should] equal:@"http://www.wave.com/2.png"];
        });
        
        it(@"should build an array containing the given amount of tracks", ^{
            
            NSArray *tracks = [manager buildTracksWithJSONArray:moreTracks];
            [[theValue(tracks.count) should] equal:theValue(2)];
            [[tracks[0] should] beNonNil];
            [[tracks[1] should] beNonNil];
        });
    });
});

SPEC_END
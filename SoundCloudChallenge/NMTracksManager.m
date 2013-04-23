//
//  NMTracksManager.m
//  SoundCloudChallenge
//
//  Created by Nicola Miotto on 4/22/13.
//  Copyright (c) 2013 Nicola Miotto. All rights reserved.
//

#import "NMTracksManager.h"
#import "NMTrack.h"

@implementation NMTracksManager

- (NSArray *)buildTracksWithJSONArray:(NSArray *)JSONArray
{
    NSMutableArray *tracks = [NSMutableArray new];
    for (NSDictionary *trackDict in JSONArray) {
        
        NMTrack *track = [NMTrack new];
        track.identifier = [trackDict[kNMSoundCloudKeyTrackIdentifier] intValue];
        track.title = trackDict[kNMSoundCloudKeyTrackTitle];
        track.waveFormURL = URL(trackDict[kNMSoundCloudKeyTrackWaveURL]);
        track.createdAt = [NSDate dateWithString:trackDict[kNMSoundCloudKeyTrackDate]
                                          format:kNMSoundCloudAPIDateFormat];
        
        [tracks addObject:track];
    }
    
    return tracks;
}

- (void)fetchTracksWithOffset:(NSInteger)offset
                        limit:(NSInteger)limit
                        block:(FetchResultBlock)fblock
{
    NSString *resourceString = [NSString stringWithFormat:@"%@%@%@", kSCSoundCloudAPIURL, kNMSoundCloudEndPointMe, kNMSoundCloudEndPointFavouriteTracks];
    NSDictionary *parameters = @{
                                 kNMSoundCloudParameterOffset   : [@(offset) stringValue],
                                 kNMSoundCloudParameterLimit    : [@(limit) stringValue]
                                 };
    
    SCRequestResponseHandler handler;
    handler = ^(NSURLResponse *response, NSData *data, NSError *error) {
        NSArray *tracks = [self buildTracksWithJSONArray:[data arrayFromJSON]];
        fblock(tracks, error);
    };
    
    [SCRequest performMethod:SCRequestMethodGET
                  onResource:URL(resourceString)
             usingParameters:parameters
                 withAccount:[SCSoundCloud account]
      sendingProgressHandler:nil
             responseHandler:handler];
    
}

@end

//
//  NMTracksManager.h
//  SoundCloudChallenge
//
//  Created by Nicola Miotto on 4/22/13.
//  Copyright (c) 2013 Nicola Miotto. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^FetchResultBlock) (NSArray *tracks, NSError *error);

@interface NMTracksManager : NSObject

- (NMTrack *)buildTrackWithJSONDictionary:(NSDictionary *)trackDict;
- (NSArray *)buildTracksWithJSONArray:(NSArray *)JSONArray;

- (void)fetchTracksWithOffset:(NSInteger)offset
                        limit:(NSInteger)limit
                        block:(FetchResultBlock)fblock;

@end

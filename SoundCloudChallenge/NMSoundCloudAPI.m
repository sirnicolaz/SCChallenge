//
//  NMSoundCloudEndPoints.m
//  SoundCloudChallenge
//
//  Created by Nicola Miotto on 4/22/13.
//  Copyright (c) 2013 Nicola Miotto. All rights reserved.
//

// Endpoints
NSString *const kNMSoundCloudEndPointMe                 = @"me";
NSString *const kNMSoundCloudEndPointTracks             = @"/tracks.json";
NSString *const kNMSoundCloudEndPointFavouriteTracks    = @"/favorites.json";

// Parameters
NSString *const kNMSoundCloudParameterLimit  = @"limit";
NSString *const kNMSoundCloudParameterOffset = @"offset";

// Keys
NSString *const kNMSoundCloudKeyTrackIdentifier = @"id";
NSString *const kNMSoundCloudKeyTrackTitle      = @"title";
NSString *const kNMSoundCloudKeyTrackDate       = @"created_at";
NSString *const kNMSoundCloudKeyTrackWaveURL    = @"waveform_url";

// Others

NSString *const kNMSoundCloudAPIDateFormat = @"yyyy/MM/dd kk:mm:ss ZZZZ";
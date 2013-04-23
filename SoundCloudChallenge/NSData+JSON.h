//
//  NSData+JSON.h
//  SoundCloudChallenge
//
//  Created by Nicola Miotto on 4/22/13.
//  Copyright (c) 2013 Nicola Miotto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (JSON)

- (NSArray *)arrayFromJSON;
- (NSDictionary *)dictionaryFromJSON;

@end

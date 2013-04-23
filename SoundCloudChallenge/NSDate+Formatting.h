//
//  NSDate+Formatting.h
//  SoundCloudChallenge
//
//  Created by Nicola Miotto on 4/22/13.
//  Copyright (c) 2013 Nicola Miotto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Formatting)

+ (NSDate *)dateWithString:(NSString *)dateString
                    format:(NSString *)format;
- (NSString *)stringValueWithFormat:(NSString *)format;

@end

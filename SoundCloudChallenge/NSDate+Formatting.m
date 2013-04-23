//
//  NSDate+Formatting.m
//  SoundCloudChallenge
//
//  Created by Nicola Miotto on 4/22/13.
//  Copyright (c) 2013 Nicola Miotto. All rights reserved.
//

#import "NSDate+Formatting.h"

@implementation NSDate (Formatting)

+ (NSDate *)dateWithString:(NSString *)dateString
                    format:(NSString *)format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    
    return [formatter dateFromString:dateString];
}

- (NSString *)stringValueWithFormat:(NSString *)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    NSString *strDate = [dateFormatter stringFromDate:self];
    
    return strDate;
}

@end

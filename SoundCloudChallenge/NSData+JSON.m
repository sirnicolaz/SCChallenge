//
//  NSData+JSON.m
//  SoundCloudChallenge
//
//  Created by Nicola Miotto on 4/22/13.
//  Copyright (c) 2013 Nicola Miotto. All rights reserved.
//

#import "NSData+JSON.h"

@implementation NSData (JSON)

- (id)objFromJSON
{
    id obj;
    NSError *jsonError = nil;
    NSJSONSerialization *jsonResponse = [NSJSONSerialization
                                         JSONObjectWithData:self
                                         options:0
                                         error:&jsonError];
    if (!jsonError){
        obj = jsonResponse;
    }
    
    return obj;
}

- (NSArray *)arrayFromJSON
{
    NSArray *arr;
    
    id result = [self objFromJSON];
    if ([result isKindOfClass:[NSArray class]]) {
        arr = (NSArray *)result;
    }
    
    return arr;
}

- (NSDictionary *)dictionaryFromJSON
{
    NSDictionary *dict;
    
    id result = [self objFromJSON];
    if ([result isKindOfClass:[NSDictionary class]]) {
        dict = (NSDictionary *)result;
    }
    
    return dict;
}

@end

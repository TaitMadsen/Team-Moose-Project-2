//
//  SettingsSaveObject.m
//  Seminar Scene
//
//  Created by Tait Madsen on 10/10/13.
//  Copyright (c) 2013 TaitMadsen. All rights reserved.
//

#import "SettingsSaveObject.h"

@implementation SettingsSaveObject

@synthesize startTime, length, location;

- (void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:startTime forKey:@"startTime"];
    [aCoder encodeObject:location forKey:@"location"];
    [aCoder encodeDouble:length forKey:@"length"];
}

- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        [self setStartTime:[aDecoder decodeObjectForKey:@"startTime"]];
        [self setLocation:[aDecoder decodeObjectForKey:@"location"]];
        [self setLength:[aDecoder decodeDoubleForKey:@"length"]];
    }
    
    return self;
}

- (id) initWithStartTime:(NSDate *)st length:(NSTimeInterval)len location:(NSString *)loc
{
    self = [super init];
    if (self) {
        [self setLength:len];
        [self setLocation:loc];
        [self setStartTime:st];
    }
    
    return self;
}


@end

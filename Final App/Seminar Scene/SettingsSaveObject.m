//
//  SettingsSaveObject.m
//  Seminar Scene
//
//  Created by Tait Madsen on 10/10/13.
//  Copyright (c) 2013 TaitMadsen. All rights reserved.
//

#import "SettingsSaveObject.h"

@implementation SettingsSaveObject

@synthesize startTime, length, location, alertTime, alertSwitchOn;

// The next two methods allow this object to be archived and unarchived
- (void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:startTime forKey:@"startTime"];
    [aCoder encodeObject:location forKey:@"location"];
    [aCoder encodeDouble:length forKey:@"length"];
    [aCoder encodeObject:alertTime forKey:@"alertTime"];
    [aCoder encodeBool:alertSwitchOn forKey:@"alertSwitchOn"];
}

// An initializer method by unarchiving
- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        [self setStartTime:[aDecoder decodeObjectForKey:@"startTime"]];
        [self setLocation:[aDecoder decodeObjectForKey:@"location"]];
        [self setLength:[aDecoder decodeDoubleForKey:@"length"]];
        [self setAlertTime:[aDecoder decodeObjectForKey:@"alertTime"]];
        [self setAlertSwitchOn:[aDecoder decodeBoolForKey:@"alertSwitchOn"]];
    }
    
    return self;
}

// Initializes a new SettingsSaveObject
- (id) initWithStartTime:(NSDate *)st length:(NSTimeInterval)len location:(NSString *)loc alertTime:(NSDate *)at alertSwitchOn:(BOOL)aso
{
    self = [super init];
    if (self) {
        [self setLength:len];
        [self setLocation:loc];
        [self setStartTime:st];
        [self setAlertTime:at];
        [self setAlertSwitchOn:aso];
    }
    
    return self;
}


@end

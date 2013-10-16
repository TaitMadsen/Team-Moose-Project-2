//
//  Seminar.m
//  Seminar Scene
//
//  Created by Tait Madsen on 10/7/13.
//  Copyright (c) 2013 TaitMadsen. All rights reserved.
//

#import "Seminar.h"

@implementation Seminar

@synthesize dateOfSeminar, location, whatAbout, availableFood, seminarLength, alarmTime, calendarEventID, notification;

// Init method, in Java you would call this a constuctor method
- (id) initWithDate:(NSDate *)d length:(NSTimeInterval)le location:(NSString *)lo about:(NSString *)a food:(NSString *)f alarmTime:(NSDate *)alarm
{
    self =[super init];
    if (self) {
        dateOfSeminar = d;
        location = lo;
        whatAbout = a;
        availableFood = f;
        seminarLength = le;
        alarmTime = alarm;
        calendarEventID = @"";
    }
    
    return self;
}

// The next two methods allow this object to be archived.
- (void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:dateOfSeminar forKey:@"dateOfSeminar"];
    [aCoder encodeObject:location forKey:@"location"];
    [aCoder encodeObject:whatAbout forKey:@"whatAbout"];
    [aCoder encodeObject:availableFood forKey:@"availableFood"];
    [aCoder encodeDouble:seminarLength forKey:@"seminarLength"];
    [aCoder encodeObject:alarmTime forKey:@"alarmTime"];
    [aCoder encodeObject:calendarEventID forKey:@"calendarEvendID"];
    [aCoder encodeObject:notification forKey:@"notification"];
}

- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        [self setDateOfSeminar:[aDecoder decodeObjectForKey:@"dateOfSeminar"]];
        [self setLocation:[aDecoder decodeObjectForKey:@"location"]];
        [self setWhatAbout:[aDecoder decodeObjectForKey:@"whatAbout"]];
        [self setAvailableFood:[aDecoder decodeObjectForKey:@"availableFood"]];
        [self setSeminarLength:[aDecoder decodeDoubleForKey:@"seminarLength"]];
        [self setAlarmTime:[aDecoder decodeObjectForKey:@"alarmTime"]];
        [self setCalendarEventID:[aDecoder decodeObjectForKey:@"calendarEventID"]];
        [self setNotification:[aDecoder decodeObjectForKey:@"notification"]];
    }
    
    return self;
}

// A method for returning the date of this seminar object as a string
// with a specified format style
- (NSString *) dateAsStringWithStyle:(NSDateFormatterStyle)style
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:style];
    [formatter setTimeStyle:style];
    return [formatter stringFromDate:[self dateOfSeminar]];
}


@end










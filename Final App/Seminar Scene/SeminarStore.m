//
//  SeminarStore.m
//  Seminar Scene
//
//  Created by Tait Madsen on 10/7/13.
//  Copyright (c) 2013 TaitMadsen. All rights reserved.
//

#import <EventKit/EventKit.h>

#import "SeminarStore.h"
#import "Seminar.h"
#import "SSAppDelegate.h"
#import "SettingsViewController.h"

@implementation SeminarStore

// Code necessary to make this a singleton:
+ (SeminarStore *)seminarStore
{
    static SeminarStore *seminarStore = nil;
    if (!seminarStore)
        seminarStore = [[super allocWithZone:nil] init];
    
    return seminarStore;
}

+ (id) allocWithZone:(struct _NSZone *)zone
{
    return [self seminarStore];
}

/////////////////

- (id) init
{
    self = [super init];
    if (self) {
        NSString *path = [self seminarArchivePath];
        allSeminars = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        
        if (!allSeminars)
            allSeminars = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSString *)seminarArchivePath // Necessary for saving
{
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [documentDirectories objectAtIndex:0];
    return [documentDirectory stringByAppendingPathComponent:@"seminars.archive"];
}

- (BOOL) save
{
    NSString *path = [self seminarArchivePath];
    return [NSKeyedArchiver archiveRootObject:allSeminars toFile:path];
    NSLog(@"Saved SeminarStore.");
}

- (NSMutableArray *)allSeminars
{
    return allSeminars;
}

- (void) deleteSeminarAtIndex:(NSUInteger)i
{
    Seminar *thisSeminar = [allSeminars objectAtIndex:i];
    NSString *eventID = [thisSeminar calendarEventID];
    [allSeminars removeObjectAtIndex:i];
    
    // Delete notification and remove event from calendar
    
    // Remove from calendar
    EKEventStore *store = [[EKEventStore alloc] init];
    [store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
        if (!granted) {
            NSLog(@"Delete from calendar Access Denied!");
        } else {
            EKEvent *eventToRemove = [store eventWithIdentifier:eventID];
            if (eventToRemove) {
                NSError* error = nil;
                [store removeEvent:eventToRemove span:EKSpanThisEvent commit:YES error:&error];
            }
        }
    }];
    
    // Remove the associated notification, if it exists
    if ([thisSeminar notification])
        [[UIApplication sharedApplication] cancelLocalNotification:[thisSeminar notification]];
    
    
}

- (void) insertSeminar:(Seminar *)s
{
    // Inserts the seminar into the NSMutableArray allSeminars, making sure it is ordered with other seminars
    NSLog(@"Inserting Seminar.");
    int index = 0;
    BOOL hasAdded = NO;
    while (index < allSeminars.count && !hasAdded) {
        
        if ([[s dateOfSeminar] compare:[[allSeminars objectAtIndex:index] dateOfSeminar]] == NSOrderedAscending) {
            [allSeminars insertObject:s atIndex:index];
            hasAdded = YES;
        }
       
        index++;
    }
    
    if (!hasAdded)
        [allSeminars insertObject:s atIndex:index];
    
    NSLog(@"Seminar should be added now.");
    // The seminar has been added to the store, now create a notification and add an event to the calendar
    
    // Adding to the calendar
    EKEventStore *store = [[EKEventStore alloc] init];
    [store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
        if (!granted) {
            NSLog(@"Save to calendar Access Denied!");
        } else {
            EKEvent *event = [EKEvent eventWithEventStore:store];
            event.title = [s whatAbout];
            event.startDate = [s dateOfSeminar];
            event.endDate = [event.startDate dateByAddingTimeInterval:[s seminarLength] * 3600];
            [event setCalendar:[store defaultCalendarForNewEvents]];
            [event setLocation:[s location]];
            
            NSError *err = nil;
            [store saveEvent:event span:EKSpanThisEvent commit:YES error:&err];
            [s setCalendarEventID:[event eventIdentifier]];  //this is so I can access this event later
        }
    }];
    
    // Add the notification, only if notifications are turned on
    SSAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    SettingsViewController *settings = [delegate settingsController];
    
    if ([settings alertSwitchOn]) {
        UILocalNotification *notification = [[UILocalNotification alloc] init];
        [notification setFireDate:[s alarmTime]];
        [notification setTimeZone:[NSTimeZone defaultTimeZone]];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateStyle:NSDateFormatterShortStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        
        [notification setAlertBody:[NSString stringWithFormat:@"%@ at %@",
                                    [s whatAbout], [formatter stringFromDate:[s dateOfSeminar]]]];
        [notification setAlertAction:@"view"];
        [notification setSoundName:UILocalNotificationDefaultSoundName];
        
        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
        
        // Save the notification object so it can be deleted.
        [s setNotification:notification];
    }
}

- (void) deleteSeminar:(Seminar *)s
{
    NSUInteger index = [allSeminars indexOfObject:s];
    [self deleteSeminarAtIndex:index];
}


@end




























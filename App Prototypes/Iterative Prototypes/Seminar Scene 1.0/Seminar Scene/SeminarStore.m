//
//  SeminarStore.m
//  Seminar Scene
//
//  Created by Tait Madsen on 10/7/13.
//  Copyright (c) 2013 TaitMadsen. All rights reserved.
//

#import "SeminarStore.h"
#import "Seminar.h"

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

- (NSString *)seminarArchivePath
{
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [documentDirectories objectAtIndex:0];
    return [documentDirectory stringByAppendingPathComponent:@"seminars.archive"];
}

- (BOOL) save
{
    NSLog(@"Saving...");
    NSString *path = [self seminarArchivePath];
    return [NSKeyedArchiver archiveRootObject:allSeminars toFile:path];
}

- (NSMutableArray *)allSeminars
{
    return allSeminars;
}

- (void) deleteSeminarAtIndex:(int)i
{
    [allSeminars removeObjectAtIndex:i];
    
    // Delete notification and remove event from calendar
}

- (void) insertSeminar:(Seminar *)s
{
    int index = 0;
    BOOL hasAdded = NO;
    while (index < allSeminars.count) {
        
        if ([[s dateOfSeminar] compare:[allSeminars objectAtIndex:index]] == NSOrderedDescending) {
            [allSeminars insertObject:s atIndex:index];
            hasAdded = YES;
        }
        
    }
    
    if (!hasAdded)
        [allSeminars insertObject:s atIndex:index];
    
    // The seminar has been added to the store, now create a notification and add an event to the calendar
}

@end




























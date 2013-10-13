//
//  SeminarStore.h
//  Seminar Scene
//
//  Created by Tait Madsen on 10/7/13.
//  Copyright (c) 2013 TaitMadsen. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Seminar;

@interface SeminarStore : NSObject
{
    NSMutableArray *allSeminars;
}

+ (SeminarStore *) seminarStore;

- (NSMutableArray *) allSeminars;

- (void) insertSeminar:(Seminar *)s;
- (void) deleteSeminarAtIndex:(NSUInteger) i;
- (void) deleteSeminar:(Seminar *)s;

- (NSString *)seminarArchivePath;
- (BOOL) save;

@end

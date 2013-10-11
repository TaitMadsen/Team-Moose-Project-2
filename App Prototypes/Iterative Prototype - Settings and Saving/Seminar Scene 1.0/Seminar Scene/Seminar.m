//
//  Seminar.m
//  Seminar Scene
//
//  Created by Tait Madsen on 10/7/13.
//  Copyright (c) 2013 TaitMadsen. All rights reserved.
//

#import "Seminar.h"

@implementation Seminar

@synthesize dateOfSeminar, location, whatAbout, availableFood, seminarLength;

- (id) initWithDate:(NSDate *)d length:(NSTimeInterval *)le location:(NSString *)lo about:(NSString *)a food:(NSString *)f
{
    self =[super init];
    if (self) {
        dateOfSeminar = d;
        location = lo;
        whatAbout = a;
        availableFood = f;
        seminarLength = le;
    }
    
    return self;
}


@end

//
//  Seminar.h
//  Seminar Scene
//
//  Created by Tait Madsen on 10/7/13.
//  Copyright (c) 2013 TaitMadsen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Seminar : NSObject

@property (nonatomic) NSDate *dateOfSeminar;
@property (nonatomic) NSString *location;
@property (nonatomic) NSString *whatAbout;
@property (nonatomic) NSString *availableFood;

// Be sure to add an end time/length of seminar field // done.
// This will be dictated in the options tab,
// as will a default location

// Also have a default time, so that the time picker starts out set to it.

@property NSTimeInterval *seminarLength;

@end

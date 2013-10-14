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
@property (nonatomic, copy) NSString *location;
@property (nonatomic, copy) NSString *whatAbout;
@property (nonatomic, copy) NSString *availableFood;
@property (nonatomic) NSTimeInterval seminarLength;
@property (nonatomic) NSDate *alarmTime;
@property (nonatomic, copy) NSString *calendarEventID;
@property (nonatomic) UILocalNotification *notification;

- (id) initWithDate:(NSDate *)d length:(NSTimeInterval)le location:(NSString *)lo about:(NSString *)a food:(NSString *)f alarmTime:(NSDate *)alarm;

- (NSString *) dateAsStringWithStyle:(NSDateFormatterStyle)style;



@end

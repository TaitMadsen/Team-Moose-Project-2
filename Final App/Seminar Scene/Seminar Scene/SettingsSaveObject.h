//
//  SettingsSaveObject.h
//  Seminar Scene
//
//  Created by Tait Madsen on 10/10/13.
//  Copyright (c) 2013 TaitMadsen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SettingsSaveObject : NSObject

@property (nonatomic) NSTimeInterval length;
@property (nonatomic) NSDate *startTime;
@property (nonatomic, copy) NSString *location;
@property (nonatomic) NSDate *alertTime;
@property (nonatomic) BOOL alertSwitchOn;

- (id) initWithStartTime:(NSDate *)st length:(NSTimeInterval)len location:(NSString *)loc alertTime:(NSDate *)at alertSwitchOn:(BOOL) aso;

@end


// This is an object used to save settings
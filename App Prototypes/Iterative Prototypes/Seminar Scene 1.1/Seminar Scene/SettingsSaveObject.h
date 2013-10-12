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
@property (nonatomic) NSString *location;

- (id) initWithStartTime:(NSDate *)st length:(NSTimeInterval)len location:(NSString *)loc;

@end

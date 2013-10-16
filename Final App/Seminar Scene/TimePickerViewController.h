//
//  TimePickerViewController.h
//  Seminar Scene
//
//  Created by Tait Madsen on 10/7/13.
//  Copyright (c) 2013 TaitMadsen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimePickerViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (nonatomic, copy) void (^dismissBlock) (void);
@property (nonatomic, strong) NSDate *defaultDate;
@property (nonatomic) UIDatePickerMode mode;

- (IBAction)DoneButtonWasPressed:(UIButton *)sender;

- (id) initWithDate:(NSDate *)d andMode:(UIDatePickerMode)m;


@end

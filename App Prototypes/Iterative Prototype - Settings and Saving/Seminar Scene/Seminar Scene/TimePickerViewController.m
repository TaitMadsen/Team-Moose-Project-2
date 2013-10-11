//
//  TimePickerViewController.m
//  Seminar Scene
//
//  Created by Tait Madsen on 10/7/13.
//  Copyright (c) 2013 TaitMadsen. All rights reserved.
//

#import "TimePickerViewController.h"


@implementation TimePickerViewController

@synthesize datePicker, dismissBlock;

- (id) initWithDate:(NSDate *)d
{
    self = [super init];
    if (self) {
        
        [datePicker setDatePickerMode:UIDatePickerModeTime];
        
        // Make sure the time picker displays the current default time
        [datePicker setDate:d];
    }
    
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)DoneButtonWasPressed:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:dismissBlock];
}
@end

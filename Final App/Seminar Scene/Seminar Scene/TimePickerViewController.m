//
//  TimePickerViewController.m
//  Seminar Scene
//
//  Created by Tait Madsen on 10/7/13.
//  Copyright (c) 2013 TaitMadsen. All rights reserved.
//

#import "TimePickerViewController.h"


@implementation TimePickerViewController

@synthesize datePicker, dismissBlock, defaultDate, mode;

- (id) initWithDate:(NSDate *)d andMode:(UIDatePickerMode)m
{
    self = [super init];
    if (self) {
        
        defaultDate = d;
        mode = m;
        
    }
    
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [datePicker setDatePickerMode:mode];
    
    [datePicker setDate:defaultDate animated:YES];
    
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

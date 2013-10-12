//
//  EditSeminarViewController.m
//  Seminar Scene
//
//  Created by Tait Madsen on 10/11/13.
//  Copyright (c) 2013 TaitMadsen. All rights reserved.
//

#import "EditSeminarViewController.h"
#import "Seminar.h"
#import "SSAppDelegate.h"
#import "SettingsViewController.h"
#import "TimePickerViewController.h"
#import "SeminarStore.h"

@implementation EditSeminarViewController

@synthesize summary, location, startTime, endTime, alertTime, alertsOn, refreshments, length, saveBlock;

static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 216;

- (id) initAsEditOfSeminar:(Seminar *)seminar
{
    self = [super init];
    if (self) {
        
        SSAppDelegate *appDelegate = (SSAppDelegate *)[[UIApplication sharedApplication] delegate];
        settings = [appDelegate settingsController];
        
        summary = [seminar whatAbout];
        location = [seminar location];
        length = [seminar seminarLength];
        startTime = [seminar dateOfSeminar];
        endTime = [self determineEndTime];
        alertTime = [seminar alarmTime];
        alertsOn = [settings alertSwitchOn];
        refreshments = [seminar availableFood];
    }
    
    return self;
}

- (id) initAsNew
{
    self = [super init];
    if (self) {
        SSAppDelegate *appDelegate = (SSAppDelegate *)[[UIApplication sharedApplication] delegate];
        settings = [appDelegate settingsController];
        
        summary = @"";
        location = @"";
        length = [settings length];
        startTime = [self dateObjectWithDateFrom:[NSDate date] andTimeFrom:[settings startTime]];
        endTime = [self determineEndTime];
        alertTime = [self dateObjectWithDateFrom:[NSDate date] andTimeFrom:[settings alertTime]];
        alertsOn = [settings alertSwitchOn];
        refreshments = @"";
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [summaryTextView setText:summary];
    [locationLabel setText:location];
    [startTimeField setText: [self date:startTime asStringWithStyle:NSDateFormatterShortStyle]];
    [endTimeField setText: [self date:endTime asStringWithStyle:NSDateFormatterShortStyle]];
    [alertTimeField setText: [self date:alertTime asStringWithStyle:NSDateFormatterShortStyle]];
    [refreshmentsTextView setText:refreshments];
    
    // Make the alert fields appropriatedly hidden or not
    if ([settings alertSwitchOn]) {
        [alertTimeField setAlpha:1];
        [alertTimeLabel setAlpha:1];
        [alertTimeEditButton setAlpha:1];
    } else {
        [alertTimeField setAlpha:0];
        [alertTimeLabel setAlpha:0];
        [alertTimeEditButton setAlpha:0];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancelButtonPressed:(UIBarButtonItem *)sender
{
    [[self presentingViewController] dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)doneButtonPressed:(UIBarButtonItem *)sender
{
    // Create a new Seminar object
    Seminar *newSeminar = [[Seminar alloc] initWithDate:startTime
                                                 length:length
                                               location:location
                                                  about:summary
                                                   food:refreshments
                                              alarmTime:alertTime];
    
    // Insert that new Seminar into the SeminarStore
    [[SeminarStore seminarStore] insertSeminar:newSeminar];
    
    [[self presentingViewController] dismissViewControllerAnimated:YES completion:saveBlock];
}

- (IBAction)backgroundTapped:(UIControl *)sender
{
    [[self view] endEditing:YES];
}

- (IBAction)startTimeEditButtonPressed:(UIButton *)sender
{
    TimePickerViewController *tp = [[TimePickerViewController alloc] initWithDate:startTime andMode:UIDatePickerModeDateAndTime];
    [tp setDismissBlock:^{
        
        // Get the datePickers' time
        startTime = [[tp datePicker] date];
        
        
        // Adjust the end time
        endTime = [self determineEndTime];
        
        // Adjust the date of the alert
        alertTime = [self dateObjectWithDateFrom:startTime andTimeFrom:alertTime];
        
        [self viewDidLoad];
    }];
    
    [self presentViewController:tp animated:YES completion:nil];
}

- (IBAction)endTimeEditButtonPressed:(UIButton *)sender
{
    TimePickerViewController *tp = [[TimePickerViewController alloc] initWithDate:endTime andMode:UIDatePickerModeDateAndTime];
    [tp setDismissBlock:^{
        
        // Get the datePicker's time
        endTime = [[tp datePicker] date];
        
        [self viewDidLoad];
    }];
    
    [self presentViewController:tp animated:YES completion:nil];
}

- (IBAction)alertTimeEditButtonPressed:(UIButton *)sender
{
    TimePickerViewController *tp = [[TimePickerViewController alloc] initWithDate:alertTime andMode:UIDatePickerModeDateAndTime];
    [tp setDismissBlock:^{
        
        // Get the datePicker's time
        alertTime = [[tp datePicker] date];
        
        [self viewDidLoad];
    }];
    
    [self presentViewController:tp animated:YES completion:nil];
}

- (void) textViewDidBeginEditing:(UITextView *)textView
{
    if (textView == refreshmentsTextView) {
        // Animate the keyboard
        CGFloat animatedDistance = PORTRAIT_KEYBOARD_HEIGHT;
        
        CGRect viewFrame = self.view.frame;
        viewFrame.origin.y -= animatedDistance;
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
        
        [[self view] setFrame:viewFrame];
        
        [UIView commitAnimations];
    }
}

- (void) textViewDidEndEditing:(UITextView *)textView
{
    if (textView == refreshmentsTextView) {
        CGFloat animatedDistance = PORTRAIT_KEYBOARD_HEIGHT;
        
        CGRect viewFrame = self.view.frame;
        viewFrame.origin.y += animatedDistance;
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
        
        [[self view] setFrame:viewFrame];
        
        [UIView commitAnimations];
    }
}

- (NSDate *) dateObjectWithDateFrom:(NSDate *)dateDateObject andTimeFrom:(NSDate *)timeDateObject
{
    unsigned dateFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    unsigned timeFlags = NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:dateFlags fromDate:dateDateObject];
    NSDateComponents *timeComponents = [[NSCalendar currentCalendar] components:timeFlags fromDate:timeDateObject];
    
    NSDate *dateToReturn = [[NSCalendar currentCalendar] dateFromComponents:dateComponents];
    dateToReturn = [[NSCalendar currentCalendar] dateByAddingComponents:timeComponents toDate:dateToReturn options:0];
    
    return dateToReturn;
}

- (NSDate *)determineEndTime
{
    return [startTime dateByAddingTimeInterval:length];
}

- (NSString *) date:(NSDate *)d asStringWithStyle:(NSDateFormatterStyle)style
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:style];
    return [formatter stringFromDate:d];
}


@end




















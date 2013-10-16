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

@synthesize thisSeminar, alertsOn, saveBlock, isNewSeminar;

// constants for animating the keyboard.
static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 216;

// Initializing methods
- (id) initAsEditOfSeminar:(Seminar *)seminar
{
    self = [super init];
    if (self) {
        
        SSAppDelegate *appDelegate = (SSAppDelegate *)[[UIApplication sharedApplication] delegate];
        settings = [appDelegate settingsController];
        
        thisSeminar = seminar;
        alertsOn = [settings alertSwitchOn];
        isNewSeminar = NO;
        
    }
    
    return self;
}

- (id) initAsNew
{
    self = [super init];
    if (self) {
        SSAppDelegate *appDelegate = (SSAppDelegate *)[[UIApplication sharedApplication] delegate];
        settings = [appDelegate settingsController];
        
        alertsOn = [settings alertSwitchOn];
        
        // Create a default Seminar object
        thisSeminar = [[Seminar alloc] initWithDate:[self dateObjectWithDateFrom:[NSDate date] andTimeFrom:[settings startTime]]
                                             length:[settings length]
                                           location:[settings location]
                                              about:@""
                                               food:@""
                                          alarmTime:[self dateObjectWithDateFrom:[NSDate date] andTimeFrom:[settings alertTime]]
                       ];
        
        isNewSeminar = YES;
        
    }
    
    return self;
}

// Methods called by iOS
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [summaryTextView setText:[thisSeminar whatAbout]];
    [locationField setText:[thisSeminar location]];
    [startTimeField setText: [self date:[thisSeminar dateOfSeminar] asStringWithStyle:NSDateFormatterShortStyle]];
    [endTimeField setText: [self date:[self determineEndTime] asStringWithStyle:NSDateFormatterShortStyle]];
    [alertTimeField setText: [self date:[thisSeminar alarmTime] asStringWithStyle:NSDateFormatterShortStyle]];
    [refreshmentsTextView setText:[thisSeminar availableFood]];
    
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

// Defining methods for the actions linked from the xib
- (IBAction)doneButtonPressed:(UIBarButtonItem *)sender
{
    // Make sure the three text areas are saved
    [thisSeminar setWhatAbout:[summaryTextView text]];
    [thisSeminar setLocation:[locationField text]];
    [thisSeminar setAvailableFood:[refreshmentsTextView text]];
    
    // Insert that new Seminar into the SeminarStore, if this is a new seminar
    if (isNewSeminar) {
        [[SeminarStore seminarStore] insertSeminar:thisSeminar];
    } else { // We are editing an old seminar
        
        [[SeminarStore seminarStore] deleteSeminar:thisSeminar];
        [[SeminarStore seminarStore] insertSeminar:thisSeminar];
    }
    
    [[self presentingViewController] dismissViewControllerAnimated:YES completion:saveBlock];
}

- (IBAction)backgroundTapped:(UIControl *)sender
{
    NSLog(@"backgroundTapped");
    [[self view] endEditing:YES];
}

- (IBAction)locationFieldDidEdit:(UITextField *)sender
{
    [thisSeminar setLocation:[locationField text]];
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)startTimeEditButtonPressed:(UIButton *)sender
{
    // Make sure the text areas are saved
    [thisSeminar setWhatAbout:[summaryTextView text]];
    [thisSeminar setLocation:[locationField text]];
    [thisSeminar setAvailableFood:[refreshmentsTextView text]];
    
    TimePickerViewController *tp = [[TimePickerViewController alloc] initWithDate:[thisSeminar dateOfSeminar] andMode:UIDatePickerModeDateAndTime];
    [tp setDismissBlock:^{
        
        // Get the datePickers' time
        [thisSeminar setDateOfSeminar:[[tp datePicker] date]];
        
        // Adjust the date of the alert
        [thisSeminar setAlarmTime:[self dateObjectWithDateFrom:[thisSeminar dateOfSeminar] andTimeFrom:[thisSeminar alarmTime]]];
        
        [self viewDidLoad];
    }];
    
    [self presentViewController:tp animated:YES completion:nil];
}

- (IBAction)endTimeEditButtonPressed:(UIButton *)sender
{
    // Make sure the text areas are saved
    [thisSeminar setWhatAbout:[summaryTextView text]];
    [thisSeminar setLocation:[locationField text]];
    [thisSeminar setAvailableFood:[refreshmentsTextView text]];
    
    TimePickerViewController *tp = [[TimePickerViewController alloc] initWithDate:[self determineEndTime] andMode:UIDatePickerModeDateAndTime];
    [tp setDismissBlock:^{
        
        // Get the datePicker's time
        [thisSeminar setSeminarLength:[[[tp datePicker] date] timeIntervalSinceDate:[thisSeminar dateOfSeminar]]];
        [self viewDidLoad];
    }];
    
    [self presentViewController:tp animated:YES completion:nil];
}

- (IBAction)alertTimeEditButtonPressed:(UIButton *)sender
{
    // Make sure the text areas are saved
    [thisSeminar setWhatAbout:[summaryTextView text]];
    [thisSeminar setLocation:[locationField text]];
    [thisSeminar setAvailableFood:[refreshmentsTextView text]];
    
    TimePickerViewController *tp = [[TimePickerViewController alloc] initWithDate:[thisSeminar alarmTime] andMode:UIDatePickerModeDateAndTime];
    [tp setDismissBlock:^{
        
        // Get the datePicker's time
        [thisSeminar setAlarmTime:[[tp datePicker] date]];
        
        [self viewDidLoad];
    }];
    
    [self presentViewController:tp animated:YES completion:nil];
}

- (void) textViewDidBeginEditing:(UITextView *)textView
{
    NSLog(@"textviewDidBeginEditing");
    if (textView == refreshmentsTextView) {
        NSLog(@"It was refreshmentsTextView");
        
        // Save the text!
        [thisSeminar setAvailableFood:[refreshmentsTextView text]];
        
        // Animate the keyboard
        CGFloat animatedDistance = PORTRAIT_KEYBOARD_HEIGHT;
        
        CGRect viewFrame = self.view.frame;
        viewFrame.origin.y -= animatedDistance;
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
        
        [[self view] setFrame:viewFrame];
        
        [UIView commitAnimations];
    } else {
        // It's the summaryTextView, so save that!
        [thisSeminar setWhatAbout:[summaryTextView text]];
    }
}

- (void) textViewDidEndEditing:(UITextView *)textView
{
    NSLog(@"textviewDidEndEditing");
    if (textView == refreshmentsTextView) {
        NSLog(@"It was refreshmentsTextView");
        
        // Animate the keyboard
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

// A method to return a date object witht the date of one date object and the time of another
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

// Determines the end time of a seminar based on the start time and the length
- (NSDate *)determineEndTime
{
    return [[thisSeminar dateOfSeminar] dateByAddingTimeInterval:([thisSeminar seminarLength] * 3600)];
}

// Returns the string representation of a date object with a specified format style
- (NSString *) date:(NSDate *)d asStringWithStyle:(NSDateFormatterStyle)style
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:style];
    [formatter setTimeStyle:style];
    return [formatter stringFromDate:d];
}


@end




















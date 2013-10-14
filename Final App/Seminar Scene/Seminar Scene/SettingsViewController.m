//
//  SettingsViewController.m
//  Seminar Scene
//
//  Created by Tait Madsen on 10/7/13.
//  Copyright (c) 2013 TaitMadsen. All rights reserved.
//

#import "SettingsViewController.h"
#import "TimePickerViewController.h"
#import "SettingsSaveObject.h"

@implementation SettingsViewController

@synthesize length, location, startTime, alertTime, alertSwitchOn;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        NSString *path = [self archivePath];
        SettingsSaveObject *sso = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        
        if (sso) {
            NSLog(@"Loading settigns");
            length = [sso length];
            location = [sso location];
            startTime = [sso startTime];
            alertTime = [sso alertTime];
            alertSwitchOn = [sso alertSwitchOn];
        } else {
            NSLog(@"Creating default default settings :D");
            
            length = 1.0;
            location = @"";
            
            // setting a default time
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"hh:mm a"];
            startTime = [formatter dateFromString:@"08:00 pm"];
            alertTime = [formatter dateFromString:@"10:00 am"];
            alertSwitchOn = YES;
        }
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // Make sure the fields display the correct data
    [lengthField setText:[NSString stringWithFormat:@"%.2f", length]];
    [locationField setText:location];
    
    // The times
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"hh:mm a"];
    [startTimeField setText:[dateFormatter stringFromDate:startTime]];
    [alertTimeField setText:[dateFormatter stringFromDate:alertTime]];
    
    // Make sure the alert switch appears correctly
    [alertSwitch setOn:[self alertSwitchOn] animated:YES];
    
    // If the alert switch is on, make sure all necessary fields are approriately visible
    if (alertSwitchOn) {
        [self showSwitchAnimated:NO];
    } else {
        [self hideSwitchAnimated:NO];
    }
    
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)LengthFieldDidEdit:(UITextField *)sender
{
    [self setLength:[[sender text] doubleValue]];
    NSLog(@"Length Field Did Edit");
}

- (IBAction)LocationFieldDidEdit:(UITextField *)sender
{
    [self setLocation:[sender text]];
    NSLog(@"Location Field Did Edit");
}

- (IBAction)startTimeButtonPressed:(UIButton *)sender
{
    TimePickerViewController *tp = [[TimePickerViewController alloc] initWithDate:startTime andMode:UIDatePickerModeTime];
    [tp setDismissBlock:^{
        [self setStartTime:[[tp datePicker] date]];
        
        [self viewWillAppear:YES];
        
        NSLog(@"Set the start time from the time picker.");
    }];
    
    [self presentViewController:tp animated:YES completion:nil];
}

- (IBAction)AlertTimeButtonPressed:(UIButton *)sender
{
    TimePickerViewController *tp = [[TimePickerViewController alloc] initWithDate:alertTime andMode:UIDatePickerModeTime];
    [tp setDismissBlock:^{
        [self setAlertTime:[[tp datePicker] date]];
        
        [self viewWillAppear:YES];
        
        NSLog(@"Set the alert time from the time picker.");
    }];
    
    [self presentViewController:tp animated:YES completion:nil];
}

- (IBAction)alertSwitchDidToggle:(UISwitch *)sender
{
    [self setAlertSwitchOn:[sender isOn]];
    
    if ([sender isOn]) {
        [self showSwitchAnimated:YES];
    } else {
        [self hideSwitchAnimated:YES];
    }
}

- (IBAction)backgroundWasTapped:(UIControl *)sender
{
    [[self view] endEditing:YES];
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
    
    // In the nib, the textFields in question must have the File's Owner as a delegate.
}

- (NSString *)archivePath
{
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [documentDirectories objectAtIndex:0];
    return [documentDirectory stringByAppendingPathComponent:@"SettingsSaveObject"];
}

- (BOOL) save
{
    SettingsSaveObject *sso = [[SettingsSaveObject alloc] initWithStartTime:startTime
                                                                     length:length location:location
                                                                  alertTime:alertTime
                                                              alertSwitchOn:alertSwitchOn];
    
    NSString *path = [self archivePath];
    BOOL success = [NSKeyedArchiver archiveRootObject:sso toFile:path];
    
    if (success)
        NSLog(@"Settings saved successfully!");
    else
        NSLog(@"Settings failed to save.");
    
    return success;
}

- (void) showSwitchAnimated:(BOOL)animated
{
    if (!animated) {
        [alertTimeLabel setAlpha:1];
        [alertTimeField setAlpha:1];
        [alertTimeEditButton setAlpha:1];
        
    } else {
        
        [UIView animateWithDuration:0.2
                         animations:^{
                             [alertTimeLabel setAlpha:1];
                             [alertTimeField setAlpha:1];
                             [alertTimeEditButton setAlpha:1];
                         }];
    }
    
}

- (void) hideSwitchAnimated:(BOOL)animated
{
    if (!animated) {
        [alertTimeLabel setAlpha:0];
        [alertTimeField setAlpha:0];
        [alertTimeEditButton setAlpha:0];
    
    } else {
        
        [UIView animateWithDuration:0.2
                         animations:^{
                             [alertTimeLabel setAlpha:0];
                             [alertTimeField setAlpha:0];
                             [alertTimeEditButton setAlpha:0];
                         }];
    }
}





@end









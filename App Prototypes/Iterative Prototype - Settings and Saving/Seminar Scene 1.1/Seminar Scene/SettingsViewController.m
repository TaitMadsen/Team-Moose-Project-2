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

@synthesize length, location, startTime;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        NSString *path = [self archivePath];
        SettingsSaveObject *sso = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        
        if (sso) {
            length = [sso length];
            location = [sso location];
            startTime = [sso startTime];
        } else {
            length = 1.0;
            location = @"";
            
            // setting a default time
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"HH:mm"];
            startTime = [formatter dateFromString:@"20:00"];
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
    
    // The time
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"hh:mm a"];
    [startTimeField setText:[dateFormatter stringFromDate:startTime]];
    
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
    TimePickerViewController *tp = [[TimePickerViewController alloc] initWithDate:startTime];
    [tp setDismissBlock:^{
        [self setStartTime:[[tp datePicker] date]];
        
        [self viewWillAppear:YES];
        
        NSLog(@"Set the time from the time picker.");
    }];
    
    [self presentViewController:tp animated:YES completion:nil];
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
    SettingsSaveObject *sso = [[SettingsSaveObject alloc] initWithStartTime:startTime length:length location:location];
    
    NSString *path = [self archivePath];
    BOOL success = [NSKeyedArchiver archiveRootObject:sso toFile:path];
    
    if (success)
        NSLog(@"Settings saved successfully!");
    else
        NSLog(@"Settings failed to save.");
    
    return success;
}





@end









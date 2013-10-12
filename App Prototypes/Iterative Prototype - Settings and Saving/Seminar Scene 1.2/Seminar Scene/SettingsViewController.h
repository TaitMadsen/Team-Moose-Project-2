//
//  SettingsViewController.h
//  Seminar Scene
//
//  Created by Tait Madsen on 10/7/13.
//  Copyright (c) 2013 TaitMadsen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController
{
    __weak IBOutlet UITextField *lengthField;
    __weak IBOutlet UITextField *locationField;
    __weak IBOutlet UILabel *startTimeField;
    __weak IBOutlet UILabel *alertTimeLabel;
    __weak IBOutlet UILabel *alertTimeField;
    __weak IBOutlet UISwitch *alertSwitch;
    __weak IBOutlet UIButton *alertTimeEditButton;
}

- (IBAction)LengthFieldDidEdit:(UITextField *)sender;
- (IBAction)LocationFieldDidEdit:(UITextField *)sender;

@property (nonatomic) NSTimeInterval length;
@property (nonatomic) NSDate *startTime;
@property (nonatomic) NSString *location;
@property (nonatomic) NSDate *alertTime;
@property (nonatomic) BOOL alertSwitchOn;

- (IBAction)startTimeButtonPressed:(UIButton *)sender;
- (IBAction)AlertTimeButtonPressed:(UIButton *)sender;
- (IBAction)alertSwitchDidToggle:(UISwitch *)sender;

- (IBAction)backgroundWasTapped:(UIControl *)sender;

- (NSString *)archivePath;
- (BOOL) save;

- (void) showSwitchAnimated:(BOOL)animated;
- (void) hideSwitchAnimated:(BOOL)animated;


@end

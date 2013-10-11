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
}


@property (nonatomic) NSTimeInterval length;
@property (nonatomic) NSDate *startTime;
@property (nonatomic) NSString *location;

- (IBAction)lengthFieldEdited:(UITextField *)sender;
- (IBAction)locationFieldEdited:(UITextField *)sender;

- (IBAction)startTimeButtonPressed:(UIButton *)sender;
- (IBAction)backgroundWasTapped:(UIControl *)sender;

- (NSString *)archivePath;
- (BOOL) save;

@end

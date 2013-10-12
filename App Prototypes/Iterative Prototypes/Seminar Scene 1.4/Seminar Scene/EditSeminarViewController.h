//
//  EditSeminarViewController.h
//  Seminar Scene
//
//  Created by Tait Madsen on 10/11/13.
//  Copyright (c) 2013 TaitMadsen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Seminar, SettingsViewController;

@interface EditSeminarViewController : UIViewController <UITextViewDelegate, UITextFieldDelegate>
{
    __weak IBOutlet UITextView *summaryTextView;
    __weak IBOutlet UITextField *locationField;
    __weak IBOutlet UILabel *startTimeField;
    __weak IBOutlet UILabel *endTimeField;
    __weak IBOutlet UILabel *alertTimeField;
    
    __weak IBOutlet UILabel *alertTimeLabel;
    __weak IBOutlet UIButton *alertTimeEditButton;
    
    
    __weak IBOutlet UITextView *refreshmentsTextView;
    
    SettingsViewController *settings;
}

@property (nonatomic, copy) NSString *summary;
@property (nonatomic, copy) NSString *location;
@property (nonatomic) NSDate *startTime;
@property (nonatomic) NSDate *endTime;
@property (nonatomic) NSDate *alertTime;
@property (nonatomic) BOOL alertsOn;
@property (nonatomic, copy) NSString *refreshments;
@property (nonatomic) NSTimeInterval length;
@property (nonatomic, copy) void (^saveBlock) (void);

- (IBAction)cancelButtonPressed:(UIBarButtonItem *)sender;
- (IBAction)doneButtonPressed:(UIBarButtonItem *)sender;
- (IBAction)backgroundTapped:(UIControl *)sender;
- (IBAction)locationFieldDidEdit:(UITextField *)sender;
- (IBAction)startTimeEditButtonPressed:(UIButton *)sender;
- (IBAction)endTimeEditButtonPressed:(UIButton *)sender;
- (IBAction)alertTimeEditButtonPressed:(UIButton *)sender;

- (id) initAsNew;
- (id) initAsEditOfSeminar:(Seminar *)seminar;

- (NSDate *)dateObjectWithDateFrom:(NSDate *)dateDateObject andTimeFrom:(NSDate *)timeDateObject;
- (NSDate *)determineEndTime;
- (NSString *) date:(NSDate *)d asStringWithStyle:(NSDateFormatterStyle)style;

@end







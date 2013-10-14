//
//  ListSignupViewController.h
//  Seminar Scene
//
//  Created by Tait Madsen on 10/13/13.
//  Copyright (c) 2013 TaitMadsen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListSignupViewController : UIViewController <UITextViewDelegate>
{
    __weak IBOutlet UITextView *subscriptionTextField;
}

- (IBAction)backgroundTapped:(UIControl *)sender;

@property (nonatomic, copy) NSString *subscriptionString;

- (NSString *)subscriptionArchivePath;
- (BOOL) save;

@end

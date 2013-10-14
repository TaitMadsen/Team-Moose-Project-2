//
//  ListSignupViewController.m
//  Seminar Scene
//
//  Created by Tait Madsen on 10/13/13.
//  Copyright (c) 2013 TaitMadsen. All rights reserved.
//

#import "ListSignupViewController.h"

@implementation ListSignupViewController

@synthesize subscriptionString;

static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 160;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        NSString *savedString = [NSKeyedUnarchiver unarchiveObjectWithFile:[self subscriptionArchivePath]];
        if (savedString) {
            subscriptionString = savedString;
        } else {
            subscriptionString = nil;
        }
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [subscriptionTextField setText:subscriptionString];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)subscriptionArchivePath
{
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [documentDirectories objectAtIndex:0];
    return [documentDirectory stringByAppendingPathComponent:@"subscriptions.archive"];
}

- (BOOL) save
{
    NSString *path = [self subscriptionArchivePath];
    return [NSKeyedArchiver archiveRootObject:subscriptionString toFile:path];
    NSLog(@"Saved Subscriptions.");
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self setSubscriptionString:[subscriptionTextField text]];
}

- (void) textViewDidBeginEditing:(UITextView *)textView
{
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

- (void) textViewDidEndEditing:(UITextView *)textView
{
    // Save the textView
    [self setSubscriptionString:[subscriptionTextField text]];
    
    CGFloat animatedDistance = PORTRAIT_KEYBOARD_HEIGHT;
    
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y += animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [[self view] setFrame:viewFrame];
    
    [UIView commitAnimations];
}

- (IBAction)backgroundTapped:(UIControl *)sender
{
    [[self view] endEditing:YES];
}
@end












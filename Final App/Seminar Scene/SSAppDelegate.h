//
//  SSAppDelegate.h
//  Seminar Scene
//
//  Created by Tait Madsen on 10/7/13.
//  Copyright (c) 2013 TaitMadsen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SettingsViewController, ListSignupViewController;

@interface SSAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) SettingsViewController *settingsController;
@property (strong, nonatomic) ListSignupViewController *subscriptionsController;

@end

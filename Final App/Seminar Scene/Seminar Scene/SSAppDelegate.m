//
//  SSAppDelegate.m
//  Seminar Scene
//
//  Created by Tait Madsen on 10/7/13.
//  Copyright (c) 2013 TaitMadsen. All rights reserved.
//

#import "SSAppDelegate.h"
#import "SettingsViewController.h"
#import "SeminarTableViewController.h"
#import "SeminarStore.h"
#import "ListSignupViewController.h"

@implementation SSAppDelegate

@synthesize settingsController, subscriptionsController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.

    // Setting up the layout of the app:  The main view is a tab bar controller,
    // It holds:
    // * A navigation controller which holds the table view
    // * The settings controller
    // * The subscriptions controller
    [self setSettingsController:[[SettingsViewController alloc] init]];
    [[settingsController tabBarItem] setTitle:@"Settings"];
    [[settingsController tabBarItem] setImage:[UIImage imageNamed:@"options.png"]];
    
    [self setSubscriptionsController:[[ListSignupViewController alloc] init]];
    [[subscriptionsController tabBarItem] setTitle:@"Subscriptions"];
    [[subscriptionsController tabBarItem] setImage:[UIImage imageNamed:@"subscriptions.png"]];
    
    SeminarTableViewController *tableView = [[SeminarTableViewController alloc] init];
    UINavigationController *navConroller = [[UINavigationController alloc] initWithRootViewController:tableView];
    [[navConroller tabBarItem] setTitle:@"Scheduled Events"];
    [[navConroller tabBarItem] setImage:[UIImage imageNamed:@"logs.png"]];
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    NSArray *controllers = [NSArray arrayWithObjects:navConroller, settingsController, subscriptionsController, nil];
    [tabBarController setViewControllers:controllers animated:NO];
    
    [[self window] setRootViewController:tabBarController];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    
    [settingsController save];
    [[SeminarStore seminarStore] save];
    [subscriptionsController save];
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

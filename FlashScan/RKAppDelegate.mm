//
//  RKAppDelegate.m
//  FlashScan
//
//  Created by Rishi Kapadia on 4/19/13.
//  Copyright (c) 2013 Rishi Kapadia. All rights reserved.
//

#import "RKAppDelegate.h"
#import "RKMasterViewController.h"

@implementation RKAppDelegate

- (void)dealloc
{
    [_window release];
    //[_viewController release];
    [_navigationController release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    //self.window.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.jpg"]];
    RKMasterViewController *masterViewController = [[[RKMasterViewController alloc] initWithNibName:@"RKMasterViewController" bundle:nil] autorelease];
    self.navigationController = [[[UINavigationController alloc] initWithRootViewController:masterViewController] autorelease];
    self.navigationController.navigationBar.tintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"abstract.jpg"]];
    self.navigationController.navigationBar.alpha = 0.7f;
    self.navigationController.navigationBar.translucent = YES;
    
    //if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
    //    self.navigationController = [[[RKMasterViewController alloc] initWithNibName:@"RKMasterViewController" bundle:nil] autorelease];
    //} else {
    //    self.viewController = [[[RKMasterViewController alloc] initWithNibName:@"RKMasterViewController" bundle:nil] autorelease];
    //}
    //self.window.rootViewController = self.viewController;
    
    self.window.rootViewController = self.navigationController;
    [self.window makeKeyAndVisible];
    return YES;
}

/*
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.

    RKMasterViewController *masterViewController = [[[RKMasterViewController alloc] initWithNibName:@"RKMasterViewController" bundle:nil] autorelease];
    //self.navigationController = [[[UINavigationController alloc] initWithRootViewController:masterViewController] autorelease];
    //self.window.rootViewController = self.navigationController;
    [self.window makeKeyAndVisible];
    return YES;
}
 */

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    RKModel* _model = [RKModel sharedModel];
    [_model writeToNSUerDefaults];
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

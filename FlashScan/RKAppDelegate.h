//
//  RKAppDelegate.h
//  FlashScan
//
//  Created by Rishi Kapadia on 4/19/13.
//  Copyright (c) 2013 Rishi Kapadia. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RKMasterViewController;

@interface RKAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) RKMasterViewController *viewController;

@property (strong, nonatomic) UINavigationController *navigationController;

@end

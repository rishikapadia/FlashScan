//
//  RKMasterViewController.h
//  FlashScan
//
//  Created by Rishi Kapadia on 4/19/13.
//  Copyright (c) 2013 Rishi Kapadia. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RKDetailViewController;

@interface RKMasterViewController : UITableViewController

@property (strong, nonatomic) RKDetailViewController *detailViewController;

@end

//
//  RKListViewController.h
//  FlashScan
//
//  Created by Rishi Kapadia on 4/23/13.
//  Copyright (c) 2013 Rishi Kapadia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RKModel.h"
#import "RKListSelectViewController.h"

@interface RKListViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate, UIGestureRecognizerDelegate>
{
@private
    RKModel* _model;
    //UITableView* _tView;
    UInt32 listIndexToChange;
}


@end

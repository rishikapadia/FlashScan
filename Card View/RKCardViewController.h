//
//  RKCardViewController.h
//  FlashScan
//
//  Created by Rishi Kapadia on 4/24/13.
//  Copyright (c) 2013 Rishi Kapadia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RKModel.h"

@interface RKCardViewController : UITableViewController <UIAlertViewDelegate>
{
@private
    RKModel* _model;
    UInt32 _listIndex;
    NSMutableArray* cards;
}

-(void)listIndex:(UInt32)index;

@end

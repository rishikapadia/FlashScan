//
//  RKMasterViewController.h
//  FlashScan
//
//  Created by Rishi Kapadia on 4/19/13.
//  Copyright (c) 2013 Rishi Kapadia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RKModel.h"

//@class RKDetailViewController;


@interface RKMasterViewController : UIViewController <UIAlertViewDelegate>
{
@private
    RKModel* _model;
}

//@property (strong, nonatomic) RKDetailViewController *detailViewController;

- (IBAction)viewLists:(id)sender;
- (IBAction)createList:(id)sender;
- (IBAction)convertPicture:(id)sender;

//settings button/pop-up alert

@end

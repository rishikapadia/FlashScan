//
//  RKListSelectViewController.h
//  FlashScan
//
//  Created by Rishi Kapadia on 4/24/13.
//  Copyright (c) 2013 Rishi Kapadia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RKModel.h"
#import "RKCardViewController.h"
#import "RKAddCardViewController.h"

@interface RKListSelectViewController : UIViewController
{
@private
    RKModel* _model;
    UInt32 _listIndex;
}

-(void)listIndex:(UInt32)index;

- (IBAction)studyMode:(id)sender;

- (IBAction)randomize:(id)sender;
- (IBAction)sort:(id)sender;
- (IBAction)addCard:(id)sender;
- (IBAction)viewCards:(id)sender;


@end

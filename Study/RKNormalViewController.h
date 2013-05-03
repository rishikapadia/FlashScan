//
//  RKNormalViewController.h
//  FlashScan
//
//  Created by Rishi Kapadia on 5/2/13.
//  Copyright (c) 2013 Rishi Kapadia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RKModel.h"
#import "RKFlashCard.h"

@interface RKNormalViewController : UIPageViewController
{
@private
    UIImageView* imageView;
    UILabel* label;
    RKModel* _model;
    
    NSMutableArray* cards;
    UInt32 listNumber;
    UInt32 cardNumber;
    RKNormalViewController* next;
}

@property (retain, nonatomic) IBOutlet UIImageView *imageView;
@property (retain, nonatomic) IBOutlet UILabel *label;

-(void)loadListIndex:(UInt32)listIndex;
-(void)loadCardIndex:(UInt32)cardIndex;


@end

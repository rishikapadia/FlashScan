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
#import "RKContentViewController.h"

@interface RKNormalViewController : UIPageViewController <UIGestureRecognizerDelegate>
{
@private
    RKModel* _model;
    NSMutableArray* cards;
    UInt32 listNumber;
    UInt32 cardNumber;
    
    UIPageViewController *pageController;
    NSArray *frontPageContent;
    NSArray *backPageContent;
    BOOL currIsFront;
}

@property (strong, nonatomic) UIPageViewController *pageController;
@property (strong, nonatomic) NSArray *frontPageContent;
@property (strong, nonatomic) NSArray *backPageContent;

-(void)loadListIndex:(UInt32)listIndex;
-(void)loadCardIndex:(UInt32)cardIndex;


@end

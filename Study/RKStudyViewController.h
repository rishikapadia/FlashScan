//
//  RKStudyViewController.h
//  FlashScan
//
//  Created by Rishi Kapadia on 5/2/13.
//  Copyright (c) 2013 Rishi Kapadia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RKModel.h"
#import "RKFlashCard.h"
#import "RKContentViewController.h"

@interface RKStudyViewController : UIViewController <UIGestureRecognizerDelegate>
{
@private
    RKModel* _model;
    NSMutableArray* cards;
    UInt32 listNumber;
    
    UIPageViewController *pageController;
    NSArray *currController;
    BOOL currIsFront;
    
    //4 buckets
    NSArray* buckets;
        //buckets[currBucket][currBucketIndex][front/back]
    NSArray* nextBuckets;
    UInt32 currBucket;     //0,1,2,3
    UInt32 currIterationNumber;  //0,1,2,3
    UInt32 currBucketIndex;  //0...n/4
}

@property (strong, nonatomic) UIPageViewController *pageController;

-(void)loadListIndex:(UInt32)listIndex;

@end

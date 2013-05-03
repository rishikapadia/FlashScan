//
//  RKContentViewController.h
//  FlashScan
//
//  Created by Rishi Kapadia on 5/2/13.
//  Copyright (c) 2013 Rishi Kapadia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RKContentViewController : UIViewController
{
@private
    UILabel* label;
    UIImageView* imageView;
    BOOL isFront;
}

@property (retain, nonatomic) UILabel *label;
@property (retain, nonatomic) UIImageView *imageView;
@property (nonatomic) BOOL isFront;

-(void)setLabelText:(NSString*)text image:(UIImage*)image;

@end

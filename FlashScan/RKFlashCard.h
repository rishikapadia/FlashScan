//
//  RKFlashCard.h
//  FlashScan
//
//  Created by Rishi Kapadia on 4/19/13.
//  Copyright (c) 2013 Rishi Kapadia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RKFlashCard : NSObject <NSCoding>
{
@private
    NSString *_frontText;
    UIImage *_frontImage;
    NSString *_backText;
    UIImage *_backImage;
    UInt32 cardNumberInList;
}

@property (nonatomic, retain) NSString *_frontText;
@property (nonatomic, retain) UIImage *_frontImage;
@property (nonatomic, retain) NSString *_backText;
@property (nonatomic, retain) UIImage *_backImage;
@property (nonatomic) UInt32 cardNumberInList;

-(NSInteger)compareWithElem:(NSObject*)elem;

@end

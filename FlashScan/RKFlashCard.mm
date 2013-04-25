//
//  RKFlashCard.m
//  FlashScan
//
//  Created by Rishi Kapadia on 4/19/13.
//  Copyright (c) 2013 Rishi Kapadia. All rights reserved.
//

#import "RKFlashCard.h"

@implementation RKFlashCard

@synthesize _frontText;
@synthesize _frontImage;
@synthesize _backText;
@synthesize _backImage;
@synthesize cardNumberInList;

-(void) dealloc
{
    [_frontText release];
    [_frontImage release];
    [_backText release];
    [_backImage release];
    [super dealloc];
}

@end

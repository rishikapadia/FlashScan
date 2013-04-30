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

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self._frontText = [decoder decodeObjectForKey:@"frontText"];
        self._frontImage = [decoder decodeObjectForKey:@"frontImage"];
        self._backText = [decoder decodeObjectForKey:@"backText"];
        self._backImage = [decoder decodeObjectForKey:@"backImage"];
        self.cardNumberInList = (UInt32) [decoder decodeIntegerForKey:@"cardNumber"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    NSInteger value = cardNumberInList;
    [encoder encodeInteger:value forKey:@"cardNumber"];
    [encoder encodeObject:_frontText forKey:@"frontText"];
    [encoder encodeObject:_frontImage forKey:@"frontImage"];
    [encoder encodeObject:_backText forKey:@"backText"];
    [encoder encodeObject:_backImage forKey:@"backImage"];
}

@end

//
//  RKModel.h
//  FlashScan
//
//  Created by Rishi Kapadia on 4/19/13.
//  Copyright (c) 2013 Rishi Kapadia. All rights reserved.
//

#import <UIKit/UIKit.h>
#include <stdlib.h>
#import "RKFlashCard.h"

@interface RKModel : NSObject //<NSCoding>
{
    NSMutableArray *lists;
}

@property (nonatomic, retain) NSMutableArray *lists;

+(RKModel*) sharedModel;
-(NSString*)getListName:(UInt32)index;
-(void)writeToNSUerDefaults;

-(void)addListWithName:(NSString*)listName;
-(void)addCardtoList:(UInt32)index
                card:(RKFlashCard *)card;

-(void)removeListAtIndex:(UInt32)index;
-(void)removeCardFromListIndex:(UInt32)listIndex cardIndex:(UInt32)cardIndex;

-(void)editCardInList:(UInt32)listIndex cardIndex:(UInt32)cardIndex
                 card:(RKFlashCard*)card;
-(void)changeNameOfListAtIndex:(UInt32)index
                toName:(NSString*)newName;

-(void)sortListAtIndex:(UInt32)index;
-(void)randomizeListAtIndex:(UInt32)index;
-(NSMutableArray*)getCardListAtIndex:(UInt32)index;


@end

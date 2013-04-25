//
//  RKModel.m
//  FlashScan
//
//  Created by Rishi Kapadia on 4/19/13.
//  Copyright (c) 2013 Rishi Kapadia. All rights reserved.
//

#import "RKModel.h"

static RKModel* gSharedModel;


@interface RKList : NSObject
{
    UInt32 numberOfCards;
    NSMutableArray *cards;
    NSString* name;
}

@property (nonatomic) UInt32 numberOfCards;
@property (nonatomic, retain) NSString* name;
@property (nonatomic, retain) NSMutableArray* cards;

-(void)removeCardAtIndex:(UInt32)index;
-(void)addCard:(RKFlashCard*)card;
-(void)randomize;
-(void)sort;
-(void)changeName:(NSString*)newName;
-(void)editCardAtIndex:(UInt32)cardIndex card:(RKFlashCard*)card;

@end


@implementation RKList

@synthesize numberOfCards;
@synthesize name;
@synthesize cards;

-(id)initWithName:(NSString*) listName
{
    self = [super init];
    if (self != nil)
    {
        numberOfCards = 0;
        name = [listName retain];
        cards = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void)dealloc
{
    [name release];
    [cards release];
    [super dealloc];
}

-(void)removeCardAtIndex:(UInt32)index
{
    [cards removeObjectAtIndex:index];
}

-(void)addCard:(RKFlashCard*)card
{
    [cards addObject:card];
    numberOfCards++;
}

-(void)randomize
{
    for (int w = [cards count]; w > 1; w--)
    {
        int r = arc4random_uniform(w);
        [cards exchangeObjectAtIndex:r withObjectAtIndex:w-1];
    }
}

-(void)sort
{
    [cards sortUsingSelector:@selector(compareWithElem:)];
}

-(NSInteger)compareWithElem:(NSObject*)elem
{
    RKFlashCard* first = (RKFlashCard*) self;
    RKFlashCard* second = (RKFlashCard*) elem;
    if (first.cardNumberInList < second.cardNumberInList)
        return NSOrderedAscending;
    if (first.cardNumberInList == second.cardNumberInList)
        return NSOrderedSame;
    return NSOrderedDescending;
}

-(void)changeName:(NSString*)newName
{
    [name release];
    name = newName;
    [name retain];
}

-(void)editCardAtIndex:(UInt32)cardIndex card:(RKFlashCard*)card
{
    [cards replaceObjectAtIndex:cardIndex withObject:card];
}

@end






@implementation RKModel

@synthesize lists;

-(id) init
{
    self = [super init];
    if (self != nil)
    {
        lists = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void)addListWithName:(NSString *)listName
{
    [lists addObject:[[RKList alloc] initWithName:listName]];
}

-(void)addCardtoList:(UInt32)index
    frontText:(NSString *)frontText frontImage:(UIImage *)frontImage
    backText:(NSString *)backText backImage:(UIImage *)backImage
{
    //
}

-(void)removeListAtIndex:(UInt32)index
{
    //
}

-(void)removeCardFromListIndex:(UInt32)listIndex cardIndex:(UInt32)cardIndex
{
    //
}

-(void)editCardInList:(UInt32)listIndex cardIndex:(UInt32)cardIndex
                 card:(RKFlashCard*)card
{
    RKList* temp = [lists objectAtIndex:listIndex];
    [temp editCardAtIndex:cardIndex card:card];
}

-(void)changeNameOfListAtIndex:(UInt32)index toName:(NSString*)newName
{
    [[lists objectAtIndex:index] changeName:newName];
}

-(void)randomizeListAtIndex:(UInt32)index
{
    [[lists objectAtIndex:index] randomize];
}

-(void)sortListAtIndex:(UInt32)index
{
    [[lists objectAtIndex:index] sort];
}

-(NSString*)getListName:(UInt32)index
{

    RKList* temp = (RKList*) [lists objectAtIndex:index];
    return temp.name;
}

+(RKModel*)sharedModel
{
    if (gSharedModel == nil)
    {
        gSharedModel = [[RKModel alloc] init];
    }
    return gSharedModel;
}

@end

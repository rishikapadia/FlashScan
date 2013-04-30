//
//  RKModel.m
//  FlashScan
//
//  Created by Rishi Kapadia on 4/19/13.
//  Copyright (c) 2013 Rishi Kapadia. All rights reserved.
//

#import "RKModel.h"

static RKModel* gSharedModel;


@interface RKList : NSObject <NSCoding>
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

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.numberOfCards = [decoder decodeIntegerForKey:@"numberOfCards"];
        self.cards = [decoder decodeObjectForKey:@"cards"];
        self.name = [decoder decodeObjectForKey:@"name"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    NSInteger value = numberOfCards;
    [encoder encodeInteger:value forKey:@"numberOfCards"];
    [encoder encodeObject:cards forKey:@"cards"];
    [encoder encodeObject:name forKey:@"name"];
}

@end








@implementation RKModel

@synthesize lists;

-(id) init
{
    self = [super init];
    if (self != nil)
    {
        NSData *archivedLists = [[NSUserDefaults standardUserDefaults] dataForKey:kUserDefaultsListsKey];
        if (archivedLists) {
            NSArray *unarchivedLists = [NSKeyedUnarchiver unarchiveObjectWithData:archivedLists];
            lists = [[unarchivedLists mutableCopy] retain];
        } else {
            lists = [[NSMutableArray alloc] init];
        }
    }
    return self;
}

-(void)dealloc
{
    [lists release];
    [super dealloc];
}

-(void)addListWithName:(NSString *)listName
{
    [lists addObject:[[RKList alloc] initWithName:listName]];
}

-(void)addCardtoList:(UInt32)index
    card:(RKFlashCard *)card
{
    [[lists objectAtIndex:index] addCard:card];
}

-(void)removeListAtIndex:(UInt32)index
{
    [lists removeObjectAtIndex:index];
}

-(void)removeCardFromListIndex:(UInt32)listIndex cardIndex:(UInt32)cardIndex
{
    RKList* temp = [lists objectAtIndex:listIndex];
    [temp removeCardAtIndex:cardIndex];
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

-(void)writeToNSUerDefaults
{
    NSUserDefaults *stdDefaults = [NSUserDefaults standardUserDefaults];
    NSData *copy = [NSKeyedArchiver archivedDataWithRootObject:lists];
    [stdDefaults setObject:copy forKey:kUserDefaultsListsKey];
    [stdDefaults synchronize];
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

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.lists = [decoder decodeObjectForKey:@"lists"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:lists forKey:@"lists"];
}

-(NSMutableArray*)getCardListAtIndex:(UInt32)index
{
    RKList* temp = [lists objectAtIndex:index];
    return temp.cards;
}

@end

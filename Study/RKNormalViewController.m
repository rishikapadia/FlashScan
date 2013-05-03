//
//  RKNormalViewController.m
//  FlashScan
//
//  Created by Rishi Kapadia on 5/2/13.
//  Copyright (c) 2013 Rishi Kapadia. All rights reserved.
//

#import "RKNormalViewController.h"

@interface RKNormalViewController ()

@end

@implementation RKNormalViewController

@synthesize label, imageView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        if (_model == nil)
        {
            _model = [RKModel sharedModel];
            [_model retain];
        }
    }
    return self;
}

-(void)loadListIndex:(UInt32)listIndex
{
    if (_model == nil)
    {
        _model = [RKModel sharedModel];
        [_model retain];
    }
    listNumber = listIndex;
    cards = [_model getCardListAtIndex:listIndex];
}

-(void)loadCardIndex:(UInt32)cardIndex
{
    if ((signed int)cardIndex < 0 || cardIndex >= [cards count])
        return;
    cardNumber = cardIndex;
    imageView.image = [[cards objectAtIndex:cardNumber] _frontImage];
    [self.label setText:[[cards objectAtIndex:cardNumber] _frontText]];
    
    NSLog(@"%@", label.text);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if (_model == nil)
    {
        _model = [RKModel sharedModel];
        [_model retain];
    }
    /*
     UISwipeGestureRecognizer* swipeUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeUpFrom:)];
     swipeUp.direction = UISwipeGestureRecognizerDirectionUp;
     [self.view addGestureRecognizer:swipeUp];
     
     UISwipeGestureRecognizer* swipeDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeDownFrom:)];
     swipeDown.direction = UISwipeGestureRecognizerDirectionDown;
     [self.view addGestureRecognizer:swipeDown];
     
     UISwipeGestureRecognizer* swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeRightFrom:)];
     swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
     [self.view addGestureRecognizer:swipeRight];
     
     UISwipeGestureRecognizer* swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeLeftFrom:)];
     swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
     [self.view addGestureRecognizer:swipeLeft];
     
     UITapGestureRecognizer *singleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
     singleTapRecognizer.numberOfTapsRequired = 1;
     [self.view addGestureRecognizer:singleTapRecognizer];
     
     UITapGestureRecognizer *doubleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
     doubleTapRecognizer.numberOfTouchesRequired = 2;
     [self.view addGestureRecognizer:doubleTapRecognizer];
     */
}


/*
 - (void)handleSwipeUpFrom:(UIGestureRecognizer*)recognizer
 {
 //mark card as understood
 //go to next card, or previous if on last card
 }
 
 - (void)handleSwipeRightFrom:(UIGestureRecognizer*)recognizer
 {
 if (cardNumber == 0)
 return;
 if (next == nil)
 {
 next = [[RKStudyViewController alloc] init];
 [next setNext:self];
 [next loadListIndex:listNumber];
 }
 
 [[self navigationController] pushViewController:next animated:YES];
 [next loadCardIndex:cardNumber-1];
 [[self navigationController] popViewControllerAnimated:NO];
 }
 
 - (void)handleSwipeLeftFrom:(UIGestureRecognizer*)recognizer
 {
 if ((signed int)cardNumber >= [cards count])
 return;
 //if (next == nil)
 {
 next = [[RKStudyViewController alloc] init];
 //[next setNext:self];
 [next loadListIndex:listNumber];
 }
 
 [[self navigationController] pushViewController:next animated:YES];
 [next loadCardIndex:cardNumber+1];
 //[[self navigationController] popViewControllerAnimated:NO];
 }
 
 - (void)handleSwipeDownFrom:(UIGestureRecognizer*)recognizer
 {
 //mark card as mistake
 //go to next card, or previous if on last card
 }
 
 
 //single tap: switch to back
 //double-tap: hide nav bar from both self and next
 
 
 - (void)handleSingleTap:(UITapGestureRecognizer *)sender
 {
 if (sender.state == UIGestureRecognizerStateEnded)
 {
 //switch to back of card
 }
 }
 
 - (void)handleDoubleTap:(UITapGestureRecognizer *)sender
 {
 if (sender.state == UIGestureRecognizerStateEnded)
 {
 UINavigationBar* bar = self.navigationController.navigationBar;
 bar.hidden = !bar.hidden;
 }
 }
 */

-(void)setNext:(RKNormalViewController*)nextCard
{
    next = nextCard;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    [label release];
    [imageView release];
    [_model release];
    [super dealloc];
}

@end

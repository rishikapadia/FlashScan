//
//  RKStudyViewController.m
//  FlashScan
//
//  Created by Rishi Kapadia on 5/2/13.
//  Copyright (c) 2013 Rishi Kapadia. All rights reserved.
//

#import "RKStudyViewController.h"

@interface RKStudyViewController ()

@end

@implementation RKStudyViewController

@synthesize pageController;

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

- (void) createContentPages
{
    buckets = [NSArray arrayWithObjects:[[NSMutableArray alloc]init],
               [[NSMutableArray alloc]init],
               [[NSMutableArray alloc]init],
               [[NSMutableArray alloc]init], nil];
    nextBuckets = [NSArray arrayWithObjects:[[NSMutableArray alloc]init], [[NSMutableArray alloc]init], [[NSMutableArray alloc]init], [[NSMutableArray alloc]init], nil];

    for (int i = 0; i < [cards count]; i++)
    {
        RKContentViewController* tempFront = [[RKContentViewController alloc] initWithNibName:@"RKContentViewController" bundle:nil];
        RKContentViewController* tempBack = [[RKContentViewController alloc] initWithNibName:@"RKContentViewController" bundle:nil];
        tempBack.isFront = NO;
        
        RKFlashCard* card = [cards objectAtIndex:i];
        [tempFront setLabelText:[card _frontText] image:[card _frontImage]];
        [tempBack setLabelText:[card _backText] image:[card _backImage]];
        
        [buckets[i % 4] addObject:[NSArray arrayWithObjects:tempFront, tempBack, nil]];
    }
    
    currBucket = 0;
    currIterationNumber = 0;
    currBucketIndex = 0;
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


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if (_model == nil)
    {
        _model = [RKModel sharedModel];
        [_model retain];
    }
    
    [self createContentPages];
    NSDictionary *options = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:UIPageViewControllerSpineLocationMin]
        forKey: UIPageViewControllerOptionSpineLocationKey];
    
    self.pageController = [[UIPageViewController alloc]
        initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
            navigationOrientation:UIPageViewControllerNavigationOrientationVertical
                           options: options];
    
    [[pageController view] setFrame:[[self view] bounds]];
    
    currController = buckets[0][0];
    currIsFront = YES;
    RKContentViewController* initialViewController = currController[0];  //first front controller
    NSArray *viewControllers = [NSArray arrayWithObject:initialViewController];
    
    [pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [self addChildViewController:pageController];
    [[self view] addSubview:[pageController view]];
    [pageController didMoveToParentViewController:self];
    
    
    
    
    
    UISwipeGestureRecognizer* swipeUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeUpFrom:)];
    swipeUp.direction = UISwipeGestureRecognizerDirectionUp;
    [self.view addGestureRecognizer:swipeUp];
    
    UISwipeGestureRecognizer* swipeDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeDownFrom:)];
    swipeDown.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:swipeDown];
    
    UITapGestureRecognizer *singleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    singleTapRecognizer.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:singleTapRecognizer];
    
    UITapGestureRecognizer *doubleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
    doubleTapRecognizer.numberOfTouchesRequired = 2;
    [self.view addGestureRecognizer:doubleTapRecognizer];
}


-(void)handleSwipeUpFrom:(UIGestureRecognizer*)recognizer
{
    NSLog(@"%@", @"Swipe Up called");
    //mark card as understood
    if (currBucket < [buckets count] - 1)
    {
        //put currController in the next bucket
        [nextBuckets[currBucket + 1] addObject:currController];
    }
    
    [self displayNextCard:YES];
}
 
-(void)handleSwipeDownFrom:(UIGestureRecognizer*)recognizer
{
    NSLog(@"%@", @"Swipe Down called");
    //mark card as mistake
    if (currBucket > 0)
    {
        //put currController in the previous bucket
        [nextBuckets[currBucket - 1] addObject:currController];
    }
    
    [self displayNextCard:NO];
}

-(void)displayNextCard:(BOOL)fromFront
{
    if (currBucket == currIterationNumber && currBucketIndex == [buckets[currBucket] count]-1)
    {
        //move on to next round
        
        for (int i = currIterationNumber+1; i < [buckets count]; i++)
        {
            for (int j=0; j< [buckets[i] count]; j++)
            {
                nextBuckets[i][j] = buckets[i][j];
            }
        }
        
        if (currIterationNumber == [buckets count] - 1)
        {
            currIterationNumber = 0;
        }
        else
        {
            currIterationNumber++;
        }
        currBucket = 0;
        currBucketIndex = 0;
        
        NSArray* temp = buckets;
        buckets = nextBuckets;
        nextBuckets = temp;
    }
    else if (currBucketIndex == [buckets[currBucket] count]-1)
    {
        currBucket++;
        currBucketIndex = 0;
    }
    else
    {
        currBucketIndex++;
    }
    //update currBucket
    //update currIterationNumber
        //swap buckets and nextBuckets
    //update currBucketIndex
    //update currController

    while (currBucketIndex == 0 && [buckets[currBucket] count] == 0)
    {
        if (currBucket == currIterationNumber)
        {
            currIterationNumber++;
        }
        currBucket++;
    }
    
    currController = buckets[currBucket][currBucketIndex];
    RKContentViewController* nextVC = currController[0];
    
    if (fromFront)
    {
        [pageController setViewControllers:[NSArray arrayWithObject:nextVC] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    }
    else
    {
        [pageController setViewControllers:[NSArray arrayWithObject:nextVC] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
    }
    
    currIsFront = YES;
}


//single tap: switch to back
//double-tap: hide nav bar from both self and next

-(void)handleSingleTap:(UITapGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateEnded)
    {
        //switch to other side of card
        if (currIsFront)
        {
            [pageController setViewControllers:[NSArray arrayWithObject:currController[1]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
        }
        else
        {
            [pageController setViewControllers:[NSArray arrayWithObject:currController[0]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
        }
        currIsFront = !currIsFront;
    }
}
 
-(void)handleDoubleTap:(UITapGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateEnded)
    {
        UINavigationBar* bar = self.navigationController.navigationBar;
        bar.hidden = !bar.hidden;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    [pageController release];
    for (int i=0; i<[buckets count]; i++)
    {
        for (int j=0; j<[buckets[i] count]; j++)
        {
            [buckets[i][j][0] release];
            [buckets[i][j][1] release];
            [buckets[i][j] release];
        }
        [buckets[i] release];
    }
    [buckets release];
    
    for (int i=0; i<[nextBuckets count]; i++)
    {
        for (int j=0; j<[nextBuckets[i] count]; j++)
        {
            [nextBuckets[i][j][0] release];
            [nextBuckets[i][j][1] release];
            [nextBuckets[i][j] release];
        }
        [nextBuckets[i] release];
    }
    [nextBuckets release];
    [_model release];
    [super dealloc];
}

@end

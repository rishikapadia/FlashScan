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

@synthesize frontPageContent, backPageContent, pageController;

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
    NSMutableArray *fronts = [[NSMutableArray alloc] init];
    NSMutableArray *backs = [[NSMutableArray alloc] init];
    for (int i = 0; i < [cards count]; i++)
    {
        RKContentViewController* tempFront = [[RKContentViewController alloc] initWithNibName:@"RKContentViewController" bundle:nil];
        RKContentViewController* tempBack = [[RKContentViewController alloc] initWithNibName:@"RKContentViewController" bundle:nil];
        tempBack.isFront = NO;
        
        RKFlashCard* card = [cards objectAtIndex:i];
        [tempFront setLabelText:[card _frontText] image:[card _frontImage]];
        [tempBack setLabelText:[card _backText] image:[card _backImage]];
        [fronts addObject:tempFront];
        [backs addObject:tempBack];
    }
    frontPageContent = [[NSArray alloc] initWithArray:fronts];
    backPageContent = [[NSArray alloc] initWithArray:backs];
}

- (RKContentViewController*)viewControllerAtIndex:(NSUInteger)index isFront:(BOOL)isFront
{
    // Return the data view controller for the given index.
    if (([self.frontPageContent count] == 0) || (index >= [self.frontPageContent count]))
    {
        return nil;
    }
    
    // Create a new view controller and pass suitable data.
    if (isFront)
        return [frontPageContent objectAtIndex:index];
    else
        return [backPageContent objectAtIndex:index];
}

- (NSUInteger)indexOfViewController:(RKContentViewController *)viewController
{
    if (viewController.isFront)
        return [frontPageContent indexOfObject:viewController];
    else
        return [backPageContent indexOfObject:viewController];
}


- (UIViewController*)pageViewController:(UIPageViewController*)pageViewController viewControllerBeforeViewController:(UIViewController*)viewController
{
    if (cardNumber == 0)
    {
        return nil;
    }
    
    cardNumber--;
    return [self viewControllerAtIndex:cardNumber isFront:YES];
}

- (UIViewController *)pageViewController:
(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    cardNumber++;
    if (cardNumber == [cards count])
    {
        return nil;
    }
    
    return [self viewControllerAtIndex:cardNumber isFront:YES];
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
    cardNumber = 0;
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
        initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl
            navigationOrientation:UIPageViewControllerNavigationOrientationVertical
                           options: options];
    
    pageController.dataSource = self;
    [[pageController view] setFrame:[[self view] bounds]];
    
    RKContentViewController *initialViewController = [self viewControllerAtIndex:0 isFront:YES];
    NSArray *viewControllers = [NSArray arrayWithObject:initialViewController];
    
    [pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [self addChildViewController:pageController];
    [[self view] addSubview:[pageController view]];
    [pageController didMoveToParentViewController:self];
    
    
    
    
    /*
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
    
    gestures = [NSArray arrayWithObjects:swipeUp, swipeDown, singleTapRecognizer, doubleTapRecognizer, nil];
     */
}


/*
 - (void)handleSwipeUpFrom:(UIGestureRecognizer*)recognizer
 {
 //mark card as understood
 //go to next card, or previous if on last card
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    [_model release];
    [super dealloc];
}

@end

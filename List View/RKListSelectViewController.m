//
//  RKListSelectViewController.m
//  FlashScan
//
//  Created by Rishi Kapadia on 4/24/13.
//  Copyright (c) 2013 Rishi Kapadia. All rights reserved.
//

#import "RKListSelectViewController.h"

@interface RKListSelectViewController ()

@end

@implementation RKListSelectViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)listIndex:(UInt32)index
{
    _listIndex = index;
}

- (IBAction)studyMode:(id)sender
{
    //
}

- (IBAction)randomize:(id)sender
{
    [_model randomizeListAtIndex:_listIndex];
}

- (IBAction)sort:(id)sender
{
    [_model sortListAtIndex:_listIndex];
}

- (IBAction)addCard:(id)sender
{
    //push new xib
    RKAddCardViewController *advc = [[RKAddCardViewController alloc] initWithNibName:@"RKAddCardViewController" bundle:nil];
    [advc listIndex:_listIndex];
    // ...
    // Pass the selected object to the new view controller.
    [self.navigationController pushViewController:advc animated:YES];
    [advc release];
}

- (IBAction)viewCards:(id)sender
{
    RKCardViewController *cvc = [[RKCardViewController alloc] initWithNibName:@"RKCardViewController" bundle:nil];
    [cvc listIndex:_listIndex];

    [self.navigationController pushViewController:cvc animated:YES];
    [cvc release];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _model = [RKModel sharedModel];
    [_model retain];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_model release];
    [super dealloc];
}


@end

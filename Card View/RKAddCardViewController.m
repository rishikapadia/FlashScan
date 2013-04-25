//
//  RKAddCardViewController.m
//  FlashScan
//
//  Created by Rishi Kapadia on 4/24/13.
//  Copyright (c) 2013 Rishi Kapadia. All rights reserved.
//

#import "RKAddCardViewController.h"

@interface RKAddCardViewController ()

@end

@implementation RKAddCardViewController

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _model = [RKModel sharedModel];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

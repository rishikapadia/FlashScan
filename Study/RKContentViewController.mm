//
//  RKContentViewController.m
//  FlashScan
//
//  Created by Rishi Kapadia on 5/2/13.
//  Copyright (c) 2013 Rishi Kapadia. All rights reserved.
//

#import "RKContentViewController.h"

@interface RKContentViewController ()

@end

@implementation RKContentViewController

@synthesize label, imageView, isFront;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        label = [[UILabel alloc] init];
        imageView = [[UIImageView alloc] init];
        isFront = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)setLabelText:(NSString*)text image:(UIImage*)image
{
    if (text == nil && image == nil)
        return;
    else if (text == nil)
    {
        imageView.image = image;
        //fill imageview to entire bounds
        [imageView setFrame:[[self view] bounds]];
        [[self view] addSubview:imageView];
    }
    else if (image == nil)
    {
        label.text = text;
        label.textAlignment = NSTextAlignmentCenter;
        //fill text to entire bounds, and center
        [label setFrame:[[self view] bounds]];
        [[self view] addSubview:label];
    }
    else
    {
        label.text = text;
        [label setFrame:CGRectMake((CGFloat)20, (CGFloat)20, (CGFloat)280, (CGFloat)120)];
        imageView.image = image;
        [imageView setFrame:CGRectMake((CGFloat)0, (CGFloat)148, (CGFloat)320, (CGFloat)400)];
        [[self view] addSubview:imageView];
        [[self view] addSubview:label];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [label release];
    [imageView release];
    [super dealloc];
}
@end

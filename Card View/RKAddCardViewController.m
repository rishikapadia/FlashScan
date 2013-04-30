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

@synthesize front, back;
@synthesize front1, front2, front3;
@synthesize back1, back2, back3;

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

-(void)flipCardToBack
{
    front.hidden = YES;
    front1.hidden = YES;
    front2.hidden = YES;
    front3.hidden = YES;
    
    back.hidden = NO;
    back1.hidden = NO;
    back2.hidden = NO;
    back3.hidden = NO;
}

-(void)addFlashcard
{
    [_model addCardtoList:_listIndex card:curr];
    
    //pop this view from stack
    [[self navigationController] pushViewController:self animated:YES];
}

- (IBAction)textFront:(id)sender
{
    
    [self flipCardToBack];
}

- (IBAction)textBack:(id)sender
{
    
    [self addFlashcard];
}

- (IBAction)addPicFront:(id)sender
{
    
    [self flipCardToBack];
}

- (IBAction)addPicBack:(id)sender
{
    
    [self addFlashcard];
}

- (IBAction)scanFront:(id)sender
{
    
    [self flipCardToBack];
}

- (IBAction)scanBack:(id)sender
{
    
    [self addFlashcard];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _model = [RKModel sharedModel];
    [_model retain];
    curr = [[RKFlashCard alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)imagePickerController:(UIImagePickerController *)picker
		didFinishPickingImage:(UIImage *)image
				  editingInfo:(NSDictionary *)editingInfo
{
	
	// Dismiss the image selection, hide the picker and
	
	//show the image view with the picked image
	
	[picker dismissModalViewControllerAnimated:YES];
    curr._frontImage = image;
    //curr._backImage = image;
    
	//UIImage *newImage = [self resizeImage:image];
	//iv.image = newImage;
	//NSString *text = [self ocrImage:newImage];
    //textField.text = text;
}

- (void)dealloc {
    [front release];
    [back release];
    [_model release];
    [front1 release];
    [front2 release];
    [front3 release];
    [back1 release];
    [back2 release];
    [back3 release];
    [super dealloc];
}
@end

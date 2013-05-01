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
@synthesize front1, front2, front3, front4;
@synthesize back1, back2, back3, back4;

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
    front4.hidden = YES;
    
    back.hidden = NO;
    back1.hidden = NO;
    back2.hidden = NO;
    back3.hidden = NO;
    back4.hidden = NO;
}

-(void)addFlashcard
{
    [_model addCardtoList:_listIndex card:curr];
    [curr release];
    
    //pop this view from stack
    [[self navigationController] popViewControllerAnimated:YES];
}

- (IBAction)textFront:(id)sender
{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Creating New Card..." message:@"Please enter the text to be on the front:" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Continue", nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    UITextField * alertTextField = [alert textFieldAtIndex:0];
    alertTextField.keyboardType = UIKeyboardTypeDefault;
    alertTextField.placeholder = @"Enter front text";
    alert.tag = 1;
    [alert show];
    [alert release];
    [self flipCardToBack];
}

- (IBAction)textBack:(id)sender
{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Creating New Card..." message:@"Please enter the text to be on the back:" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Continue", nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    UITextField * alertTextField = [alert textFieldAtIndex:0];
    alertTextField.keyboardType = UIKeyboardTypeDefault;
    alertTextField.placeholder = @"Enter back text";
    alert.tag = 2;
    [alert show];
    [alert release];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
        return;

    if (alertView.tag == 1)
    {
        if (buttonIndex == 1)
        {
            NSLog(@"Entered: %@",[[alertView textFieldAtIndex:0] text]);
            curr._frontText = [[alertView textFieldAtIndex:0] text];
        }
    }
    else if (alertView.tag == 2)
    {
        if (buttonIndex == 1)
        {
            NSLog(@"Entered: %@",[[alertView textFieldAtIndex:0] text]);
            curr._backText = [[alertView textFieldAtIndex:0] text];
            [self addFlashcard];
        }
    }
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

- (IBAction)albumFront:(id)sender
{
    
    [self flipCardToBack];
}

- (IBAction)albumBack:(id)sender
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

- (void)dealloc
{
    [_model release];
    
    [front release];
    [back release];
    [front1 release];
    [front2 release];
    [front3 release];
    [front4 release];
    [back1 release];
    [back2 release];
    [back3 release];
    [back4 release];
    
    [_frontPicker release];
    [_backPicker release];
    [super dealloc];
}
@end

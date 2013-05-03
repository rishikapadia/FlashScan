//
//  RKAddCardViewController.h
//  FlashScan
//
//  Created by Rishi Kapadia on 4/24/13.
//  Copyright (c) 2013 Rishi Kapadia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RKModel.h"
#import "RKFlashCard.h"
#import "RKOCRViewController.h"

@interface RKAddCardViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIAlertViewDelegate>
{
@private
    RKModel* _model;
    UInt32 _listIndex;
    RKFlashCard* curr;
    UIImagePickerController* _frontPicker;
    UIImagePickerController* _backPicker;
    
    UILabel* front;
    UILabel* back;
    UIButton* front1;
    UIButton* back1;
    UIButton* front2;
    UIButton* back2;
    UIButton* front3;
    UIButton* back3;
    UIButton* front4;
    UIButton* back4;
}
@property (retain, nonatomic) IBOutlet UILabel *front;
@property (retain, nonatomic) IBOutlet UILabel *back;
@property (retain, nonatomic) IBOutlet UIButton *front1;
@property (retain, nonatomic) IBOutlet UIButton *front2;
@property (retain, nonatomic) IBOutlet UIButton *front3;
@property (retain, nonatomic) IBOutlet UIButton *front4;
@property (retain, nonatomic) IBOutlet UIButton *back1;
@property (retain, nonatomic) IBOutlet UIButton *back2;
@property (retain, nonatomic) IBOutlet UIButton *back3;
@property (retain, nonatomic) IBOutlet UIButton *back4;



-(void)listIndex:(UInt32)index;

- (IBAction)textFront:(id)sender;
- (IBAction)textBack:(id)sender;
- (IBAction)addPicFront:(id)sender;
- (IBAction)addPicBack:(id)sender;
- (IBAction)scanFront:(id)sender;
- (IBAction)scanBack:(id)sender;
- (IBAction)albumFront:(id)sender;
- (IBAction)albumBack:(id)sender;


@end

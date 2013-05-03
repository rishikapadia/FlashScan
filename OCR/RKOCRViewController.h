//
//  RKOCRViewController.h
//  FlashScan
//
//  Created by Rishi Kapadia on 4/30/13.
//  Copyright (c) 2013 Rishi Kapadia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "baseapi.h"
#import "RKFlashCard.h"

@interface RKOCRViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate>
{
	UIImagePickerController *imagePickerController;
	TessBaseAPI *tess;
	UIImageView *iv;
    UITextView* textField;
    UIButton* camera;
    UIButton* album;
    UIButton* save;
    
    RKFlashCard* flashCard;
    BOOL isFrontImage;
}

@property (nonatomic, retain) IBOutlet UIImageView *iv;
@property (nonatomic, retain) IBOutlet UITextView *textField;
@property (retain, nonatomic) IBOutlet UIButton *camera;
@property (retain, nonatomic) IBOutlet UIButton *album;
@property (retain, nonatomic) IBOutlet UIButton *save;


- (IBAction) findPhoto:(id) sender;
- (IBAction) takePhoto:(id) sender;
- (IBAction) saveText:(id)sender;

- (void) startTesseract;
- (NSString *) applicationDocumentsDirectory;
- (NSString *) ocrImage: (UIImage *) uiImage;
- (UIImage *)resizeImage:(UIImage *)image;
- (void)sendFlashcard:(RKFlashCard*)card isFrontImage:(BOOL)isFront;

@end

//
//  RKOCRViewController.h
//  FlashScan
//
//  Created by Rishi Kapadia on 4/30/13.
//  Copyright (c) 2013 Rishi Kapadia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "baseapi.h"

@interface RKOCRViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate>
{
	UIImagePickerController *imagePickerController;
	TessBaseAPI *tess;
	UIImageView *iv;
	//UILabel *label;
    UITextView* textField;
}

@property (nonatomic, retain) IBOutlet UIImageView *iv;
//@property (nonatomic, retain) IBOutlet UILabel *label;
@property (nonatomic, retain) IBOutlet UITextView *textField;


- (IBAction) findPhoto:(id) sender;
- (IBAction) takePhoto:(id) sender;

- (void) startTesseract;
- (NSString *) applicationDocumentsDirectory;
- (NSString *) ocrImage: (UIImage *) uiImage;
- (UIImage *)resizeImage:(UIImage *)image;

@end

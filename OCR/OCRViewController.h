//
//  OCRViewController.h
//  OCRDemo
//
//  Created by Nolan Brown on 12/30/09.

//

#import <UIKit/UIKit.h>
#import "baseapi.h"

@interface OCRViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate>
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


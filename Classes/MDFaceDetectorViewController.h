//
//  MDFaceDetectorViewController.h
//  MDFaceDetector
//
//  Created by Mohammed Eldehairy on 5/14/13.
//  Copyright (c) 2013 Mohammed Eldehairy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDFaceDetectorDelegate.h"
@interface MDFaceDetectorViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIPopoverControllerDelegate>
{
    IBOutlet UIImageView *imageView;
    
    CIDetector *Facedetector;
    CIContext *context;
    
    CIImage *beginImage;
    UIPopoverController *popOver;
}
@property(nonatomic,assign)id<MDFaceDetectorDelegate> delegate;
-(IBAction)LoadPhotoAlbum:(id)sender;
+(MDFaceDetectorViewController*)faceDetector;
@end

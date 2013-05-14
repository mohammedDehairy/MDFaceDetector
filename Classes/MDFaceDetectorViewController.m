//
//  MDFaceDetectorViewController.m
//  MDFaceDetector
//
//  Created by Mohammed Eldehairy on 5/14/13.
//  Copyright (c) 2013 Mohammed Eldehairy. All rights reserved.
//

#import "MDFaceDetectorViewController.h"

@interface MDFaceDetectorViewController ()

@end

@implementation MDFaceDetectorViewController
+(MDFaceDetectorViewController*)faceDetector
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return [[MDFaceDetectorViewController alloc] initWithNibName:@"MDFaceDetectorViewController_iPhone" bundle:nil];
    } else {
        return [[MDFaceDetectorViewController alloc] initWithNibName:@"MDFaceDetectorViewController_iPad" bundle:nil];
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
   
    
    NSDictionary  *opts = [NSDictionary dictionaryWithObject:CIDetectorAccuracyHigh
                                                      forKey:CIDetectorAccuracy]; // 2
    Facedetector = [CIDetector detectorOfType:CIDetectorTypeFace
                                      context:context
                                      options:opts];
    
    
    
    imageView.image = [UIImage imageNamed:@"image.png"];
    
    
}

-(void)LoadPhotoAlbum:(id)sender
{
    UIImagePickerController *PickerC = [[UIImagePickerController alloc] init];
    PickerC.delegate = self;
    PickerC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        popOver = [[UIPopoverController alloc] initWithContentViewController:PickerC];
        [popOver presentPopoverFromRect:CGRectMake(0, 800, 500, 500) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
        
        popOver.delegate = self;
    } else {
        [self presentViewController:PickerC animated:YES completion:nil];
    }
    
    
}
-(void)SavePhoto:(id)sender
{
    
}
-(UIImage*)ResizeImage:(UIImage*)img
{
    CGSize size = CGSizeMake(self.view.frame.size.width, 285);
    
    
    size.height = (img.size.height/img.size.width)*self.view.frame.size.width;
    
    //Resize ImageView to the match the Image Size
    CGRect rect = imageView.frame ;
    rect.size = size;
    imageView.frame = rect;
    
    
    UIGraphicsBeginImageContext(size);
    [img drawInRect:CGRectMake(0,0,size.width,size.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
    
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    if(!popOver)
        [self dismissViewControllerAnimated:YES completion:nil];
    else
        [popOver dismissPopoverAnimated:YES];
    
    [self deleteAllAnnotaions];
    
    
    UIImage *goImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    
    //Resize the Image With the same Aspect Ratio
    beginImage = [CIImage imageWithCGImage:[self ResizeImage:goImage].CGImage];
    
    
    //set the resized image to UIImageView image
    imageView.image = goImage;
    
    
    //convert coordinate System To UIKit coordinate System
    CGAffineTransform transform = CGAffineTransformMakeScale(1, -1);
    transform = CGAffineTransformTranslate(transform,
                                           0, -imageView.bounds.size.height);
    
    
    NSArray *arr = [self DetectFaces];
    
    int tagCounter = 100;
    
    
    //Add Annotaion Views
    for(CIFaceFeature *f in arr)
    {
        
        const CGRect faceRect = CGRectApplyAffineTransform(
                                                           f.bounds, transform);
        
        [imageView addSubview:[self getAnnotaionViewWithRect:faceRect WithTag:tagCounter]];
        tagCounter++;
    }
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapAnnotaion:)];
    
    tap.numberOfTapsRequired = 1;
    [imageView addGestureRecognizer:tap];
    [imageView setUserInteractionEnabled:YES];
}
-(void)deleteAllAnnotaions
{
    for(UIView *v in imageView.subviews)
    {
        if(v.tag>99)
        {
            [v removeFromSuperview];
        }
    }
}
-(UIView*)getAnnotaionViewWithRect:(CGRect)rect WithTag:(int)tag
{
    if([_delegate respondsToSelector:@selector(MDFaceDetectorviewForFaceAnnotaion:withRect:)])
    {
        UIView *v = [_delegate MDFaceDetectorviewForFaceAnnotaion:self withRect:rect];
        v.tag = tag;
        return v;
    }
    return nil;
   /* UIView *v = [[UIView alloc] initWithFrame:rect];
    v.tag = tag;
    
    v.backgroundColor = [UIColor clearColor];
    v.layer.borderWidth = 1;
    v.layer.borderColor = [[UIColor redColor] CGColor];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapAnnotaion:)];
    
    tap.numberOfTapsRequired = 1;
    [v addGestureRecognizer:tap];
    
    return v;*/
}

-(void)TapAnnotaion:(UITapGestureRecognizer*)gesture
{
    CGPoint tapPoint = [gesture locationInView:imageView];
    
    UIView *anntaionTapped;
    
    for(UIView *annotaion in imageView.subviews)
    {
        if(annotaion.tag>99 && CGRectContainsPoint(annotaion.frame, tapPoint))
        {
            
            anntaionTapped = annotaion;
            break;
            
        }
    }
    
    if(anntaionTapped!=nil && [_delegate respondsToSelector:@selector(MDFaceDetectorFaceTapped:AtRect:)])
    {
        [_delegate MDFaceDetectorFaceTapped:self AtRect:anntaionTapped.frame];
    }
}

-(NSArray*)DetectFaces
{
    
    
    NSArray *features = [Facedetector featuresInImage:beginImage];
    
    
    return features;
}
- (void)imagePickerControllerDidCancel:
(UIImagePickerController *)picker {
    if(!popOver)
        [self dismissViewControllerAnimated:YES completion:nil];
    else
        [popOver dismissPopoverAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    
}

@end

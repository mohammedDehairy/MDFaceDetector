//
//  MDFaceDetectorDelegate.h
//  MDFaceDetector
//
//  Created by Mohammed Eldehairy on 5/14/13.
//  Copyright (c) 2013 Mohammed Eldehairy. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MDFaceDetectorViewController;
@protocol MDFaceDetectorDelegate <NSObject>
-(void)MDFaceDetectorFaceTapped:(MDFaceDetectorViewController*)faceDetector AtRect:(CGRect)faceRect;
-(UIView*)MDFaceDetectorviewForFaceAnnotaion:(MDFaceDetectorViewController*)faceDetector withRect:(CGRect)facerect;
@end

//
//  MDFaceDetectorAppDelegate.h
//  MDFaceDetector
//
//  Created by Mohammed Eldehairy on 5/14/13.
//  Copyright (c) 2013 Mohammed Eldehairy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDFaceDetectorDelegate.h"
#import <QuartzCore/QuartzCore.h>
@class MDFaceDetectorViewController;

@interface MDFaceDetectorAppDelegate : UIResponder <UIApplicationDelegate,MDFaceDetectorDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) MDFaceDetectorViewController *viewController;

@end

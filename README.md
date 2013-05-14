MDFaceDetector
==============

viewcontroller that detect faces in images from photo library and the user catch the event when a face is detected


Copyright (c) 2013 Mohammed dehairy

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.



installation :

1. copy the folder classes to your project

2. link your project to coreImage.framework

Usage :

- you should instantiate MDFaceDetectorViewController by the class method 

+(MDFaceDetectorViewController*)faceDetector

as it detects the device type (ipad or iphone) and load the appropriate xib

- present the view controller any way want as any view controller

- immplement the MDFaceDetectorDelegate protocole with two methods

-(void)MDFaceDetectorFaceTapped:(MDFaceDetectorViewController*)faceDetector AtRect:(CGRect)faceRect;

this delegate method you immplement it if you want to get notified when the user tap  a face in the photo


-(UIView*)MDFaceDetectorviewForFaceAnnotaion:(MDFaceDetectorViewController*)faceDetector withRect:(CGRect)facerect;

this method you implment to provide a uiview as an annotaion around the faces detected ,typically you should set the frame 
of your annotaion view to the CGRect parameter passed to the delegate method for the annotaion to go around the detected 
face ,or you can user that rect any way you want.

Enjoy

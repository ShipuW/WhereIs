//
//  CameraBackgroundWidget.h
//  WhereIs
//
//  Created by admin on 16/5/1.
//  Copyright © 2016年 ShipuW. All rights reserved.
//

#import "BaseWidget.h"
#import "ViewOnCamera.h"
#import <CoreLocation/CoreLocation.h>


typedef NS_ENUM(NSInteger, DevicePositon) {
    DevicePositonFront,
    DevicePositonBack
};

@interface CameraBackgroundWidget : BaseWidget <MAMapViewDelegate,CLLocationManagerDelegate>{
    CLLocationManager *_locationManager;
    CMMotionManager *_motionManager;
    MAMapView         *_mapView;
}

@property (nonatomic, retain) AVCaptureSession *session;
@property (nonatomic, retain) AVCaptureDeviceInput *input;
@property (nonatomic, retain) AVCaptureDevice *device;
@property (nonatomic, retain) AVCaptureStillImageOutput *imageOutput;
@property (nonatomic, retain) AVCaptureVideoPreviewLayer *preview;
@property (nonatomic) DevicePositon position;
@property (nonatomic) ViewOnCamera  *targetHint;
@property (nonatomic) MAPointAnnotation      *targetAnnotation;
@property (nonatomic) CLLocation* myLocation;
//-(instancetype)initWithFrame:(CGRect)frame positionDevice:(DevicePositon)position blur:(UIBlurEffectStyle)blur;
//-(instancetype)initWithFrame:(CGRect)frame positionDevice:(DevicePositon)position;
//-(void)removeBlurEffect;
//-(void)addBlurEffect:(UIBlurEffectStyle)style;


@end

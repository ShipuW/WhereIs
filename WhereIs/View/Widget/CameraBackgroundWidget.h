//
//  CameraBackgroundWidget.h
//  WhereIs
//
//  Created by admin on 16/5/1.
//  Copyright © 2016年 ShipuW. All rights reserved.
//

#import "BaseWidget.h"

typedef NS_ENUM(NSInteger, DevicePositon) {
    DevicePositonFront,
    DevicePositonBack
};

@interface CameraBackgroundWidget : BaseWidget

@property (nonatomic, retain) AVCaptureSession *session;
@property (nonatomic, retain) AVCaptureDeviceInput *input;
@property (nonatomic, retain) AVCaptureDevice *device;
@property (nonatomic, retain) AVCaptureStillImageOutput *imageOutput;
@property (nonatomic, retain) AVCaptureVideoPreviewLayer *preview;
@property (nonatomic) DevicePositon position;

//-(instancetype)initWithFrame:(CGRect)frame positionDevice:(DevicePositon)position blur:(UIBlurEffectStyle)blur;
//-(instancetype)initWithFrame:(CGRect)frame positionDevice:(DevicePositon)position;
//-(void)removeBlurEffect;
//-(void)addBlurEffect:(UIBlurEffectStyle)style;


@end

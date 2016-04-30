//
//  HomePage.m
//  WhereIs
//
//  Created by admin on 16/5/1.
//  Copyright © 2016年 ShipuW. All rights reserved.
//

#import "HomePage.h"

@implementation HomePage


- (void)viewDidLoad{
    [super viewDidLoad];
    [self setCameraBackground];
}

- (void)setCameraBackground{
    _cameraWidget = [[CameraBackgroundWidget alloc] init];
    _cameraWidget.position = AVCaptureDevicePositionFront;//前置或者后置摄像头
    _cameraWidget.view.frame = _cameraView.bounds;
    [_cameraView addSubview:_cameraWidget.view];
    [_cameraView sendSubviewToBack:_cameraWidget.view];
    
}
 
@end

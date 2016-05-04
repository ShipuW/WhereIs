//
//  HomePage.m
//  WhereIs
//
//  Created by admin on 16/5/1.
//  Copyright © 2016年 ShipuW. All rights reserved.
//

#import "CameraPage.h"

@implementation CameraPage


- (void)viewDidLoad{
    [super viewDidLoad];
    [self setCameraBackground];
    [self setTitle:AppTitle];
    //[self setNavigationLeft:@"NavigationBack.png" sel:nil];
//    [self addTargetHint];
}

- (void)setCameraBackground{
    _cameraWidget = [[CameraBackgroundWidget alloc] init];
    _cameraWidget.position = AVCaptureDevicePositionBack;//前置或者后置摄像头
    _cameraWidget.targetAnnotation = _targetAnnotation;
    //_cameraWidget.myLocation = [_myLocation copy];
    _cameraWidget.view.frame = _cameraView.bounds;
    [_cameraView addSubview:_cameraWidget.view];
    [_cameraView sendSubviewToBack:_cameraWidget.view];
    
}

//- (void)addTargetHint{
//    _targetHint = [[ViewOnCamera alloc]init];
//    [_targetHint setTitle:@"目标"];
//    [_targetHint setSubtitle:_targetAnnotation.title];
//    _targetHint.frame = CGRectMake(0, 0, _targetHint.frame.size.width, _targetHint.frame.size.height);
//    
//    
//    [_cameraView addSubview:_targetHint];
//
//}


@end

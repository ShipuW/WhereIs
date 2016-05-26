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
    
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    [self setCameraBackground];
    
    
    
    //[self setNavigationLeft:@"NavigationBack.png" sel:nil];
//    [self addTargetHint];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:TRUE];
//    [self.navigationController.view sendSubviewToBack:self.navigationController.navigationBar];
    [self.navigationController setNavigationBarHidden:YES animated:UIStatusBarAnimationFade];
    [self.navigationController setToolbarHidden:YES animated:UIStatusBarAnimationFade];
    
}


- (void)viewWillDisappear:(BOOL)animated{
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
//    [self.navigationController.view bringSubviewToFront:self.navigationController.navigationBar];
    [self.navigationController setNavigationBarHidden:NO animated:UIStatusBarAnimationFade];
    [self.navigationController setToolbarHidden:NO animated:UIStatusBarAnimationFade];
    [super viewDidDisappear:animated];


}

- (void)setCameraBackground{
    _cameraWidget = [[CameraBackgroundWidget alloc] init];
    _cameraWidget.position = AVCaptureDevicePositionBack;//前置或者后置摄像头
    _cameraWidget.targetAnnotation = _targetAnnotation;
    //_cameraWidget.myLocation = [_myLocation copy];
    _cameraWidget.view.frame = _cameraView.bounds;
    [_cameraView addSubview:_cameraWidget.view];
    [_cameraView sendSubviewToBack:_cameraWidget.view];
//    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 80, 80)];
//    view.backgroundColor = [UIColor whiteColor];
//
//    [view addSubview: [_cameraWidget.view copy]];
//
//    view.transform = CGAffineTransformMakeRotation(M_PI);
//    [_cameraView addSubview:view];
//    [_cameraView bringSubviewToFront:view];
    
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

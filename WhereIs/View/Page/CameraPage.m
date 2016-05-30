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
//    [self.navigationController setToolbarHidden:NO animated:UIStatusBarAnimationFade];
    [super viewDidDisappear:animated];


}

- (void)setCameraBackground{
    
    _cameraWidget = [[CameraBackgroundWidget alloc] init];
    _cameraWidget.position = AVCaptureDevicePositionBack;//前置或者后置摄像头
    _cameraWidget.targetAnnotation = _targetAnnotation;
    //_cameraWidget.myLocation = [_myLocation copy];
    _cameraWidget.view.frame = _cameraView.bounds;
    
//    _arWidget = [[ARCameraWidget alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
//    _arWidget.enableCardboardButton = YES;
//    _arWidget.enableFullscreenButton = YES;
//    [_arWidget loadFromUrl:[NSURL URLWithString:@"http://wangshipu001.eicp.net/1.mp4"]];
//    _arWidget.position = AVCaptureDevicePositionBack;//前置或者后置摄像头
//    _arWidget.targetAnnotation = _targetAnnotation;
//    [_arWidget setDelegate:self];

    
    
//    _arWidget.frame = _cameraView.bounds;
//    _arWidget.enableCardboardButton = YES;

    
    
//    self.videoView = [[GCSVideoView alloc]initWithFrame:CGRectMake(0, 0,self.view.width, self.view.height)];
//    self.videoView.enableCardboardButton = YES;
//    
//    [self.videoView loadFromUrl:[NSURL URLWithString:@"http://wangshipu001.eicp.net/1.mp4"]];
//    [self.videoView setDelegate:self];
//    self.videoView = _cameraWidget.view;
//    [self.view addSubview:self.videoView];
    
    
    [_cameraView addSubview:_cameraWidget.view];
    [_cameraView bringSubviewToFront:_cameraWidget.view];

    
    
//    [_cameraWidget.view setTransform: CGAffineTransformScale(_cameraWidget.view.transform, 0.5, 0.5)];


    //Configure viewlet r = new RectangleF(new PointF(0.0f, 0.0f), new SizeF(UIScreen.MainScreen.Bounds.Size))let s = new SCNView(r)configView s scene |> ignorethis.View <- s

    //Configure viewslet outer = new UIView(UIScreen.MainScreen.Bounds)let ss =	[		new RectangleF(new PointF(0.0f, 0.0f), new SizeF(float32 UIScreen.MainScreen.Bounds.Width / 2.0f - 1.0f, UIScreen.MainScreen.Bounds.Height));		new RectangleF(new PointF(float32 UIScreen.MainScreen.Bounds.Width / 2.0f + 1.0f, 0.0f), new SizeF(UIScreen.MainScreen.Bounds.Width / 2.0f -1.0f, UIScreen.MainScreen.Bounds.Height));	]	|> List.map (fun r -> new SCNView(r))	|> List.map (fun s -> outer.AddSubview(configView s scene); s)this.View <- outer
//    _copyCameraWidget = [[CameraBackgroundWidget alloc] init];
//    _copyCameraWidget.position = AVCaptureDevicePositionBack;//前置或者后置摄像头
//    _copyCameraWidget.targetAnnotation = _targetAnnotation;
//    _copyCameraWidget.view.frame = _downCameraView.bounds;

//    [_copyCameraWidget.view setTransform:CGAffineTransformScale(_copyCameraWidget.view.transform, 0.5, 0.5)];

    
    
//    [_downCameraView addSubview:_cameraWidget.view];
//    [_downCameraView bringSubviewToFront:_cameraWidget.view];
//    NSData *oldViewData =  [NSKeyedArchiver archivedDataWithRootObject:_cameraWidget.view];
//    UIView *newView = [NSKeyedUnarchiver unarchiveObjectWithData:oldViewData];
//    [_upCameraView addSubview:newView];
//    [_upCameraView bringSubviewToFront:_cameraWidget.view];
    
//    AVCaptureSession *captureSession = ...;
//    
//    AVCaptureVideoPreviewLayer *previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:captureSession];
//    
//    UIView *cameraView = ...;
//    
//    previewLayer.frame = cameraView.bounds;
//    
////    [cameraView.layer addSublayer:previewLayer];
//    NSData *oldViewData =  [NSKeyedArchiver archivedDataWithRootObject:_cameraWidget.view];
//    UIView *newView = [NSKeyedUnarchiver unarchiveObjectWithData:oldViewData];
//    [_downCameraView.layer addSublayer:newView.layer];
//    [_upCameraView bringSubviewToFront:newView];
//    _upCameraView.backgroundColor = [UIColor clearColor];
//    _downCameraView.backgroundColor = [UIColor clearColor];
//    [_downCameraView addSubview:_copyCameraWidget.view];
//    [_downCameraView bringSubviewToFront:_copyCameraWidget.view];
//    NSData * tempArchive = [NSKeyedArchiver archivedDataWithRootObject:_cameraWidget.view];
//    
//    UIView *copyView = [NSKeyedUnarchiver unarchiveObjectWithData:tempArchive];
//    UIView *copyView = _cameraWidget.view;
//
//    [_downCameraView addSubview:copyView];
//    [_downCameraView bringSubviewToFront:copyView];
//    [_downCameraView.layer addSublayer:[_cameraWidget.preview copy]];
//
//    
//    [_cameraView addSubview:_cameraWidget.view];
//    [_cameraView bringSubviewToFront:_cameraWidget.view];
//    [_cameraView addSubview:_copyCameraWidget.view];
//    [_cameraView bringSubviewToFront:_copyCameraWidget.view];
//    //    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 80, 80)];
//    
//    
//    _cameraWidget = [[CameraBackgroundWidget alloc] init];
//    _cameraWidget.position = AVCaptureDevicePositionBack;//前置或者后置摄像头
//    _cameraWidget.targetAnnotation = _targetAnnotation;
//    //_cameraWidget.myLocation = [_myLocation copy];
//    _cameraWidget.view.frame = _cameraView.bounds;
//    
//    CGAffineTransform newTransform =
//    CGAffineTransformScale(_cameraWidget.view.transform, 0.5, 0.5);
//    [_cameraWidget.view setTransform:newTransform];
//    [_cameraWidget.view setY:0];
//    
//    
//    
//    
//    
//    _copyCameraWidget = [[CameraBackgroundWidget alloc] init];
//    _copyCameraWidget.position = AVCaptureDevicePositionBack;//前置或者后置摄像头
//    _copyCameraWidget.targetAnnotation = _targetAnnotation;
//    _copyCameraWidget.view.frame = _cameraView.bounds;
//    
//    CGAffineTransform newCopyTransform =
//    CGAffineTransformScale(_copyCameraWidget.view.transform, 0.5, 0.5);
//    [_copyCameraWidget.view setTransform:newCopyTransform];
//    [_copyCameraWidget.view setY:0.5 * self.view.height+20];
//    
//    
//    
//    
//    [_cameraView addSubview:_cameraWidget.view];
//    [_cameraView bringSubviewToFront:_cameraWidget.view];
//    [_cameraView addSubview:_copyCameraWidget.view];
//    [_cameraView bringSubviewToFront:_copyCameraWidget.view];
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

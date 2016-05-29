//
//  ARCameraWidget.m
//  WhereIs
//
//  Created by admin on 16/5/29.
//  Copyright © 2016年 ShipuW. All rights reserved.
//

#import "ARCameraWidget.h"

@implementation ARCameraWidget

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
//    self.backgroundColor = [UIColor purpleColor];
    [self initCamera];
    [self initLocation];
    [self initMotion];
    [self addTargetHint];
    [self addCompassImage];
    [self initMapView];
    return self;
}


-(void)initCamera {
    
    self.session = [AVCaptureSession new];
    [self.session setSessionPreset:AVCaptureSessionPresetHigh];
    
    NSArray *devices = [NSArray new];
    devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in devices) {
        if (_position == DevicePositonBack1) {
            if ([device position] == AVCaptureDevicePositionBack) {
                _device = device;
                break;
            }
        }else {
            if ([device position] == AVCaptureDevicePositionFront) {
                _device = device;
                break;
            }
        }
    }
    
    NSError *error;
    
    self.input = [[AVCaptureDeviceInput alloc] initWithDevice:self.device error:&error];
    if ([self.session canAddInput:self.input]) {
        [self.session addInput:self.input];
    }
    
    self.imageOutput = [AVCaptureStillImageOutput new];
    NSDictionary *outputSettings = @{AVVideoCodecKey:AVVideoCodecJPEG};
    [self.imageOutput setOutputSettings:outputSettings];
    [self.session addOutput:self.imageOutput];
    self.preview = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.session];
    [self.preview setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [self.preview setFrame:CGRectMake(0, 0, self.frame.size.width,  self.frame.size.height)];
    [self.layer addSublayer:self.preview];

    [self.session startRunning];
    //    [self.sessionCopy startRunning];
    
}



- (void)initLocation{
    _locationManager= [[CLLocationManager alloc]init];
    _locationManager.delegate = self;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
    if ([CLLocationManager headingAvailable]) {
        //设置精度
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        //设置滤波器不工作
        _locationManager.headingFilter = kCLHeadingFilterNone;
        //开始更新方向
        [_locationManager startUpdatingHeading];
    }else{
//        [self showIndicator:@"罗盘不可用" autoHide:YES afterDelay:YES];
    }
}
- (void)initMotion{
    _motionManager = [[CMMotionManager alloc] init];
    //_motionManager.delegate = self;
    _motionManager.deviceMotionUpdateInterval = MotionUpdateInterval;
    if (_motionManager.accelerometerAvailable){
        //开始更新
        [_motionManager startDeviceMotionUpdates];
    }else{
//        [self showIndicator:@"加速剂不可用" autoHide:YES afterDelay:YES];
    }
}

- (void)addTargetHint{
    _targetHint = [[ViewOnCamera alloc]init];
    [_targetHint setTitle:@"目标"];
    [_targetHint setSubtitle:_targetAnnotation.title];
    
    _targetHint.frame = CGRectMake(-250, -250, _targetHint.frame.size.width, _targetHint.frame.size.height);
    
    
    [self addSubview:_targetHint];
    _targetHint.hidden = YES;
    
}

- (void)addCompassImage{
    
    _compassImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"arrow.png"]];
    
    _compassImage.frame = CGRectMake(self.center.x - 25, self.frame.size.height - 80, 50, 50);
    
    [self addSubview:_compassImage];
    
    //    _compassImage.hidden = NO;
}

- (void)initMapView{
    _mapView = [[MAMapView alloc] init];
    _mapView.delegate = self;
    _mapView.showsUserLocation = YES;
    
}

#pragma mark - MAMapViewDelegate, CLLocationManagerDelegate

-(void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading
{
    
    
    //    CGFloat heading = 1.0f * M_PI * newHeading.magneticHeading / 180.0f;
    //    _compassImage.transform = CGAffineTransformMakeRotation(heading);
    CGFloat compassAngle=-[Caculator caculateHintHeading:_targetAnnotation.coordinate withMyLocation:_myLocation inHeading:newHeading];
    _compassImage.transform = CGAffineTransformMakeRotation(compassAngle);//弧度制

    
    CGPoint point = [Caculator caculatePositionInCamera:_targetAnnotation.coordinate withMyLocation:_myLocation inHeading:newHeading withMotion:_motionManager withScreenWidth:self.frame.size.width withScreenHeight:self.frame.size.height];
    
    if(point.x < self.frame.size.width + CacheSpace && point.x > 0 - CacheSpace && point.y < self.frame.size.height + CacheSpace && point.y > 0 - CacheSpace){
        _targetHint.center = point;
        _targetHint.hidden = NO;
    }else{
        _targetHint.hidden = YES;
    }
    CGFloat tintAngle;
    if (_motionManager.deviceMotion.gravity.y < 0){
        tintAngle = atan(_motionManager.deviceMotion.gravity.x/_motionManager.deviceMotion.gravity.y);
    }else{
        tintAngle = atan(_motionManager.deviceMotion.gravity.x/_motionManager.deviceMotion.gravity.y)+M_PI;
    }
    
    _targetHint.transform = CGAffineTransformMakeRotation(tintAngle);
    
//    NSLog(@"%f,%f",compassAngle,tintAngle);
    if(fabs(compassAngle - tintAngle)<1.2*M_PI && fabs(compassAngle - tintAngle)>0.2*M_PI){
        _targetHint.hidden = YES;
    }else{
        _targetHint.hidden = NO;
    }
}

-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation
updatingLocation:(BOOL)updatingLocation
{
    if(updatingLocation)
    {
        //取出当前位置的坐标
        
        _myLocation = [userLocation.location copy];
        
    }
}
@end

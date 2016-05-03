//
//  CameraBackgroundWidget.m
//  WhereIs
//
//  Created by admin on 16/5/1.
//  Copyright © 2016年 ShipuW. All rights reserved.
//

#import "CameraBackgroundWidget.h"
#import "AppDelegate.h"

@interface CameraBackgroundWidget(){
    double gravityX;
    double gravityY;
    double gravityZ;
    double deviaX;
    double deviaY;
}

@end

@implementation CameraBackgroundWidget

- (void)viewDidLoad{
    [super viewDidLoad];
    [self initCamera];
    [self initLocation];
    [self initMotion];
    [self addTargetHint];
    [self initMapView];
}


-(void)initCamera {

    self.session = [AVCaptureSession new];
    [self.session setSessionPreset:AVCaptureSessionPresetHigh];
    
    NSArray *devices = [NSArray new];
    devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in devices) {
        if (_position == DevicePositonBack) {
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
    [self.preview setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view.layer addSublayer:self.preview];
    [self.session startRunning];
    
}

- (void)initLocation{
    _locationManager= [[CLLocationManager alloc]init];
    _locationManager.delegate = self;
    if ([CLLocationManager headingAvailable]) {
        //设置精度
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        //设置滤波器不工作
        _locationManager.headingFilter = kCLHeadingFilterNone;
        //开始更新方向
        [_locationManager startUpdatingHeading];
    }else{
        [self showIndicator:@"罗盘不可用" autoHide:YES afterDelay:YES];
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
        [self showIndicator:@"加速剂不可用" autoHide:YES afterDelay:YES];
    }
}

- (void)addTargetHint{
    _targetHint = [[ViewOnCamera alloc]init];
    [_targetHint setTitle:@"目标"];
    [_targetHint setSubtitle:_targetAnnotation.title];
    _targetHint.frame = CGRectMake(0, 0, _targetHint.frame.size.width, _targetHint.frame.size.height);
    
    
    [self.view addSubview:_targetHint];
    
}

- (void)initMapView{
    _mapView = [[MAMapView alloc] init];
    _mapView.delegate = self;
    _mapView.showsUserLocation = YES;
    
}

#pragma mark - MAMapViewDelegate, CLLocationManagerDelegate

-(void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading
{
//mylocation 要变化算
        //NSLog(@"%f",newHeading.magneticHeading);
    
    
        //_myLocation = delegate.currentLocation;
    //NSLog(@"mylocation:%f,%f",_myLocation.coordinate.latitude,_myLocation.coordinate.longitude);
    gravityX = _motionManager.deviceMotion.gravity.x;
    gravityY = _motionManager.deviceMotion.gravity.y;
    gravityZ = _motionManager.deviceMotion.gravity.z;
    
    deviaX = [Caculator caculateHorizontalPositionInCamera:_targetAnnotation.coordinate withMyLocation:_myLocation inHeading:newHeading withScreenWidth:self.view.frame.size.width] - _targetHint.frame.size.width * 0.5;
    //NSLog(@"deviaX:%f",deviaX);
    if(deviaX < self.view.frame.size.width + CacheSpace && deviaX > 0 - CacheSpace)
       [_targetHint setX:deviaX];
    
    deviaY = [Caculator caculateVerticalPositionWithGravityX:gravityX GravityY:gravityY GravityZ:gravityZ withScreenHeight:self.view.frame.size.height] - _targetHint.frame.size.height * 0.5;
    if(deviaY < self.view.frame.size.height + CacheSpace && deviaY > 0 - CacheSpace)
        [_targetHint setY:deviaY];
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

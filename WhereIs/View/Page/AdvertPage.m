//
//  AdvertPage.m
//  WhereIs
//
//  Created by admin on 16/5/1.
//  Copyright © 2016年 ShipuW. All rights reserved.
//

#import "AdvertPage.h"
#import "FxDate.h"
#import "FxAppSetting.h"
#import "AppDelegate.h"
#import "GetImage.h"


@implementation AdvertPage

+ (BOOL)canShowAdvertPage
{
    NSString *dateString = [FxAppSetting getValue:AdvertKey];
    NSDate *date = [FxDate dateFromStringYMDHMS:dateString];
    NSTimeInterval interval = [[NSDate date] timeIntervalSinceDate:date];
    
    //一小时之内不再显示启动图
    if (interval < AdvertCheckTime) {
        return NO;
    }
    
    return YES;
}

+ (void)showAdvertPage
{
    [FxAppSetting setValue:[FxDate stringFromDateYMDHMS:[NSDate date]] forKey:AdvertKey];
    
    AdvertPage *controller = [[AdvertPage alloc] init];
    UIWindow *window = [AppDelegate appDeg].window;
    
    if (window.rootViewController != nil) {
        CGRect frame = window.rootViewController.view.bounds;
        
        controller.view.frame = frame;
        [window.rootViewController.view addSubview:controller.view];
    }
    else {
        window.rootViewController = controller;
        [window makeKeyAndVisible];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self getAdvertImage];
    //[self showInfo];
}

- (void)getAdvertImage
{
    // 本地已经存在，取本地图片
    if ([self checkLanchExist]) {
        return;
    }
    
    [self getAdvertOp];
}

- (BOOL)checkLanchExist
{
    NSString *fileName = [FxDate stringFromDateYMD:[NSDate date]];//以时间为名字保存图片
    NSString *filePath = [Global getCacheImage:fileName];
    
    if ([FxFileUtility isFileExist:filePath]) {
        _advertImage.image = [UIImage imageWithContentsOfFile:filePath];//直接显示本地图片
        [self delayHideAdvert];
        return YES;
    }
    
    return NO;
}

- (void)getAdvertOp
{
    CGSize size = [UIScreen mainScreen].bounds.size;
    NSString *url = [NSString stringWithFormat:AdvertURL, (long)size.width, (long)size.height];//可以根据尺寸返回不同图片
    NSDictionary *dictInfo = @{@"url":url};
    
    _operation = [[BaseOperation alloc] initWithDelegate:self opInfo:dictInfo];
    [_operation executeOp];
}

- (void)getLaunchImageOp:(NSString *)url
{
    NSDictionary *dictInfo = @{@"url":url};
    
    _operation = [[GetImage alloc] initWithDelegate:self opInfo:dictInfo];
    [_operation executeOp];
}


#pragma mark


- (void)delayHideAdvert
{
    [self performSelector:@selector(hideLanch) withObject:nil afterDelay:AdvertDelayTime];//延迟方法
}

- (void)hideLanch   //关闭广告页面
{
    if (self.view.superview != [AppDelegate appDeg].window) {
        [self.view removeFromSuperview];
    }
    else
        [[AppDelegate appDeg] showHomePage];
}


#pragma mark - FxOperationDelegate methods

- (void)opSuccess:(NSDictionary *)dict
{
    NSDictionary *dictData = [dict objectForKey:NetData];
    NSString *url = [dictData objectForKey:@"imageurl"];
    
    [self getLaunchImageOp:url];//获得此url的图片
}

- (void)opSuccessEx:(id)data opinfo:(NSDictionary *)dictInfo
{
    [self setLaucnImage:data];
    [self delayHideAdvert];
}

- (void)setLaucnImage:(NSData *)data
{
    NSString *fileName = [FxDate stringFromDateYMD:[NSDate date]];
    UIImage *image = [UIImage imageWithData:data];
    
    if (image!=nil) {
        _advertImage.image = image;
        [data writeToFile:[Global getCacheImage:fileName] atomically:YES];//获取图片写入本地，data格式
    }
}


#pragma mark - motion data
//
//- (void)showInfo{
//    
//    motionManager = [[CMMotionManager alloc]init];
//
//    motionManager.deviceMotionUpdateInterval = 1.0/1.0;
//    
//    [self startMotion];
//    
//    locationManager= [[CLLocationManager alloc]init];
//    locationManager.delegate = self;
//    if ([CLLocationManager headingAvailable]) {
//        //设置精度
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
//        //设置滤波器不工作
//        locationManager.headingFilter = kCLHeadingFilterNone;
//        //开始更新
//        [locationManager startUpdatingHeading];
//    }
//}
//
//- (void)startMotion{
//    if(motionManager.isDeviceMotionAvailable){
//        [motionManager startDeviceMotionUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMDeviceMotion *motion, NSError *error) {
//            //Acceleration
//            NSLog(@"X:%f,Y:%f,Z:%f",motion.gravity.x,motion.gravity.y,motion.gravity.z);
//
//        }];
//    }
//}
//
//-(void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading
//{
//
//
//    NSLog(@"旋转角度angle：%f",newHeading.magneticHeading);
//}

@end

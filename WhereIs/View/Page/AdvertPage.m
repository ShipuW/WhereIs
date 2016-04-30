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

@end

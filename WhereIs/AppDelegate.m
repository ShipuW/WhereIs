//
//  AppDelegate.m
//  WhereIs
//
//  Created by admin on 16/4/30.
//  Copyright © 2016年 ShipuW. All rights reserved.
//

#import "AppDelegate.h"
#import "AdvertPage.h"
#import "CameraPage.h"
#import "MapPage.h"



@implementation AppDelegate


+ (AppDelegate *)appDeg
{
    return  (AppDelegate *)[UIApplication sharedApplication].delegate;
}


- (void)showHomePage
{
    //CameraPage *page = [[CameraPage alloc] init];
    MapPage *page = [[MapPage alloc] init];

    self.navController = [[UINavigationController alloc] init];
    [self.navController pushViewController:page animated:YES];
    self.window.rootViewController = self.navController;
    [self.window makeKeyAndVisible];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [MAMapServices sharedServices].apiKey = AmapKey;
    [AMapSearchServices sharedServices].apiKey = AmapKey;
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
#pragma mark - remember change
    [self showHomePage];
    //[AdvertPage showAdvertPage];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {

}

- (void)applicationDidEnterBackground:(UIApplication *)application {

}

- (void)applicationWillEnterForeground:(UIApplication *)application {

}

- (void)applicationDidBecomeActive:(UIApplication *)application {

}

- (void)applicationWillTerminate:(UIApplication *)application {
    
}

@end

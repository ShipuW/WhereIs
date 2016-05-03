//
//  AppDelegate.h
//  WhereIs
//
//  Created by admin on 16/4/30.
//  Copyright © 2016年 ShipuW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *navController; 
@property (nonatomic) CLLocation                *currentLocation;

+ (AppDelegate *)appDeg;
- (void)showHomePage;

@end


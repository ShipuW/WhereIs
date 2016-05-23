//
//  Caculator.h
//  WhereIs
//
//  Created by admin on 16/5/3.
//  Copyright © 2016年 ShipuW. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreMotion/CoreMotion.h>
@interface Caculator : NSObject

+(CGFloat)caculateHintHeading:(CLLocationCoordinate2D)targetLocation withMyLocation:(CLLocation*)myLocation inHeading:(CLHeading *)heading;

+(CGPoint)caculatePositionInCamera:(CLLocationCoordinate2D)targetLocation withMyLocation:(CLLocation*)myLocation inHeading:(CLHeading *)heading withMotion:(CMMotionManager *)motion withScreenWidth:(double)screenWidth withScreenHeight:(double)screenHeight;

//+(CGFloat)caculateVerticalPositionWithGravity:(CMMotionManager *)motion withScreenHeight:(double)screenHeight;
//
//+(CGFloat)modifyX:(CGFloat)deviaX withY:(CGFloat)deviaY inMotion:(CMMotionManager *)motion;
//
//+(CGFloat)modifyY:(CGFloat)deviaY withX:(CGFloat)deviaX inMotion:(CMMotionManager *)motion;

@end

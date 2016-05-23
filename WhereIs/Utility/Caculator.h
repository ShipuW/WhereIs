//
//  Caculator.h
//  WhereIs
//
//  Created by admin on 16/5/3.
//  Copyright © 2016年 ShipuW. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Caculator : NSObject

+(CGFloat)caculateHorizontalPositionInCamera:(CLLocationCoordinate2D)targetLocation withMyLocation:(CLLocation*)myLocation inHeading:(CLHeading *)heading withScreenWidth:(double)screenWidth;

+(CGFloat)caculateVerticalPositionWithGravityX:(double)gravityX GravityY:(double)gravityY GravityZ:(double)gravityZ withScreenHeight:(double)screenHeight;

+(CGFloat)caculateHintHeading:(CLLocationCoordinate2D)targetLocation withMyLocation:(CLLocation*)myLocation inHeading:(CLHeading *)heading;

@end

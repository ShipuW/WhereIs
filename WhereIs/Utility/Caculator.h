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

@end

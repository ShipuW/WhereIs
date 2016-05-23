//
//  Caculator.m
//  WhereIs
//
//  Created by admin on 16/5/3.
//  Copyright © 2016年 ShipuW. All rights reserved.
//

#import "Caculator.h"

@implementation Caculator

+(CGFloat)caculateHintHeading:(CLLocationCoordinate2D)targetLocation withMyLocation:(CLLocation*)myLocation inHeading:(CLHeading *)heading{

    
    double targetLatitude = targetLocation.latitude;
    double targetLongitude = targetLocation.longitude;
    double myLatitude = myLocation.coordinate.latitude;
    double myLongitude = myLocation.coordinate.longitude;
    CGFloat curHeading = 1.0f * M_PI * heading.magneticHeading / 180.0f;
    
    
    
    double dx = (targetLongitude - myLongitude) * [self getEdWithLo:myLongitude andLa:myLatitude];
    double dy = (targetLatitude - myLatitude) * [self getEcWithLo:myLongitude andLa:myLatitude];
    double angle=0.0;
    angle = atan(fabs(dx/dy))*180.0/M_PI;
    double dLo=targetLongitude - myLongitude;
    double dLa=targetLatitude - myLatitude;
    if(dLo>0&&dLa<=0){
        angle=(90.0-angle)+90;
    }
    else if(dLo<=0&&dLa<0){
        angle=angle+180.;
    }else if(dLo<0&&dLa>=0){
        angle= (90.-angle)+270;
    }
    
    return curHeading - angle*M_PI/180.0;
    
}

+(CGFloat)caculateHorizontalPositionInCamera:(CLLocationCoordinate2D)targetLocation withMyLocation:(CLLocation*)myLocation inHeading:(CLHeading *)heading withScreenWidth:(double)screenWidth{
    double xInCamera = 0.0f;
    float angle = [self caculateHintHeading:targetLocation withMyLocation:myLocation inHeading:heading];
    //return angle;
    //NSLog(@"摄像头朝向：%f",currentHeading.magneticHeading);
    //NSLog(@"目标方位角：%f",angle);
    xInCamera = screenWidth * 0.5 -(screenWidth * 0.5 * tan(angle) / tan(WidthFieldAngle * 0.5 * M_PI / 180.0));
    //NSLog(@"目标偏移位置：%f",xInCamera);
    if (fabs(angle) > 0.5*M_PI && 2*M_PI - fabs(angle) > 0.5*M_PI) return CGFLOAT_MAX;
    
    return xInCamera;

}



+ (double)getEcWithLo:(double)longitude andLa:(double)latigude{
//    double loSec = (longitude - (int)longitude - (int)((longitude - (int)longitude)*60)/60.0)*3600;
//    double laSec = (latigude - (int)latigude - (int)((latigude - (int)latigude)*60)/60.0)*3600;
    double Ec = Rj + (Rc - Rj) * (90.0 - latigude)/90.0;
    return Ec;
}
+ (double)getEdWithLo:(double)longitude andLa:(double)latigude{
    
    double Ec = [self getEcWithLo:longitude andLa:latigude];
    double Ed = Ec * cos(latigude * M_PI / 180.0);
    return Ed;
    
}

+(CGFloat)caculateVerticalPositionWithGravityX:(double)gravityX GravityY:(double)gravityY GravityZ:(double)gravityZ withScreenHeight:(double)screenHeight{
    double yInCamera = 0.0f;
    if (gravityZ == 0) return yInCamera;
    double angleToback = 90 - 180 * atan(gravityY / gravityZ) / M_PI;
    yInCamera = screenHeight * 0.5 - screenHeight * 0.5 * tan(angleToback * M_PI / 180.0) / tan(HeightFieldAngle * 0.5 * M_PI / 180.0)  ;
    
    //NSLog(@"angle:%f",90 - 180 * atan(gravityY/gravityZ) / M_PI);
    //NSLog(@"偏移：%f",yInCamera);
    if (gravityY > 0) return CGFLOAT_MAX;
    return yInCamera;
}

@end

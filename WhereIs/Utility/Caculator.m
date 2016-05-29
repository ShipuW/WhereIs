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

+(CGPoint)caculatePositionInCamera:(CLLocationCoordinate2D)targetLocation withMyLocation:(CLLocation*)myLocation inHeading:(CLHeading *)heading withMotion:(CMMotionManager *)motion withScreenWidth:(double)screenWidth withScreenHeight:(double)screenHeight{
    double gravityX = motion.deviceMotion.gravity.x;
    double gravityY = motion.deviceMotion.gravity.y;
    double gravityZ = motion.deviceMotion.gravity.z;
    
    float xInCamera = 0.0f;
    float yInCamera = 0.0f;
    float angle = [self caculateHintHeading:targetLocation withMyLocation:myLocation inHeading:heading];
    float angleToback = 0.0f;
    angle += atan(gravityX/gravityY);
    
    
    if (gravityZ != 0){
        float gravitySumXY = sqrt(gravityX*gravityX+gravityY*gravityY);
        angleToback = 180 * atan(gravitySumXY / gravityZ) / M_PI - 90;
        if (gravityY <= 0){
            yInCamera = screenHeight * 0.5 - cos(atan(gravityX/gravityY)) * screenHeight * 0.5 * tan(angleToback * M_PI / 180.0) / tan(HeightFieldAngle * 0.5 * M_PI / 180.0) - sin(atan(gravityX/gravityY)) * (screenWidth * 0.5 * tan(angle) / tan(WidthFieldAngle * 0.5 * M_PI / 180.0));
        }else{
            yInCamera = screenHeight * 0.5 + cos(atan(gravityX/gravityY)) * screenHeight * 0.5 * tan(angleToback * M_PI / 180.0) / tan(HeightFieldAngle * 0.5 * M_PI / 180.0) + sin(atan(gravityX/gravityY)) * (screenWidth * 0.5 * tan(angle) / tan(WidthFieldAngle * 0.5 * M_PI / 180.0));
        }
    }else{
        yInCamera = screenHeight * 0.5;
    }
    
    

    
    if (gravityY <= 0){
        xInCamera = screenWidth * 0.5 - cos(atan(gravityX/gravityY)) * (screenWidth * 0.5 * tan(angle) / tan(WidthFieldAngle * 0.5 * M_PI / 180.0)) + sin(atan(gravityX/gravityY)) * screenHeight * 0.5 * tan(angleToback * M_PI / 180.0) / tan(HeightFieldAngle * 0.5 * M_PI / 180.0);
    }else
    {
        xInCamera = screenWidth * 0.5 + cos(atan(gravityX/gravityY)) * (screenWidth * 0.5 * tan(angle) / tan(WidthFieldAngle * 0.5 * M_PI / 180.0)) - sin(atan(gravityX/gravityY)) * screenHeight * 0.5 * tan(angleToback * M_PI / 180.0) / tan(HeightFieldAngle * 0.5 * M_PI / 180.0);;
    }

    
//    if (fabs(angle) > 0.5*M_PI && 2*M_PI - fabs(angle) > 0.5*M_PI) xInCamera = CGFLOAT_MAX;
//    NSLog(@"%f",angle);
    if ((fabs(angle) < 0.2 * M_PI && gravityY > 0)||(fabs(angle) > 0.8 * M_PI && gravityY < 0)) xInCamera = CGFLOAT_MAX;
//    NSLog(@"%f,%f,%f",xInCamera,yInCamera,cos(atan(gravityX/gravityY)) * (screenWidth * 0.5 * tan(angle) / tan(WidthFieldAngle * 0.5 * M_PI / 180.0)) +sin(atan(gravityX/gravityY)) * screenHeight * 0.5 * tan(angleToback * M_PI / 180.0) / tan(HeightFieldAngle * 0.5 * M_PI / 180.0));
//    xInCamera = ceil(xInCamera);//防抖
//    yInCamera = ceil(yInCamera);
    
    return CGPointMake(xInCamera, yInCamera);


}


+ (double)getEcWithLo:(double)longitude andLa:(double)latigude{

    double Ec = Rj + (Rc - Rj) * (90.0 - latigude)/90.0;
    return Ec;
}
+ (double)getEdWithLo:(double)longitude andLa:(double)latigude{
    
    double Ec = [self getEcWithLo:longitude andLa:latigude];
    double Ed = Ec * cos(latigude * M_PI / 180.0);
    return Ed;
    
}



@end

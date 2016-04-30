//
//  AdvertPage.h
//  WhereIs
//
//  Created by admin on 16/5/1.
//  Copyright © 2016年 ShipuW. All rights reserved.
//

#import "BasePage.h"

@interface AdvertPage : BasePage<CLLocationManagerDelegate>{
    IBOutlet UIImageView    *_advertImage;
    CLLocationManager       *locationManager;
    CMMotionManager         *motionManager;

}


+ (BOOL)canShowAdvertPage;
+ (void)showAdvertPage;

@end

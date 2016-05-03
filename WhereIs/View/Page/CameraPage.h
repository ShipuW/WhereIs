//
//  HomePage.h
//  WhereIs
//
//  Created by admin on 16/5/1.
//  Copyright © 2016年 ShipuW. All rights reserved.
//

#import "BaseNavPage.h"
#import "CameraBackgroundWidget.h"
//#import <CoreLocation/CoreLocation.h>
//#import "ViewOnCamera.h"

@interface CameraPage : BaseNavPage{

    IBOutlet UIView         *_cameraView;
    CameraBackgroundWidget  *_cameraWidget;
//    ViewOnCamera            *_targetHint;
}

@property(nonatomic) MAPointAnnotation      *targetAnnotation;
@property(nonatomic) CLLocation             *myLocation;

@end

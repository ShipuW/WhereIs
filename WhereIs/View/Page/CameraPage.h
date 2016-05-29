//
//  HomePage.h
//  WhereIs
//
//  Created by admin on 16/5/1.
//  Copyright © 2016年 ShipuW. All rights reserved.
//

#import "BaseNavPage.h"
#import "CameraBackgroundWidget.h"
#import "ARCameraWidget.h"
//#import <CoreLocation/CoreLocation.h>
//#import "ViewOnCamera.h"
#import "GCSVideoView.h"


@interface CameraPage : BaseNavPage <GCSWidgetViewDelegate> {

    IBOutlet UIView         *_cameraView;
    CameraBackgroundWidget  *_cameraWidget;
    CameraBackgroundWidget  *_copyCameraWidget;
    ARCameraWidget          *_arWidget;
    IBOutlet UIView         *_upCameraView;
    IBOutlet UIView         *_downCameraView;
//    ViewOnCamera            *_targetHint;
}

@property(nonatomic) MAPointAnnotation      *targetAnnotation;
@property(nonatomic) CLLocation             *myLocation;
@property (nonatomic, strong) GCSVideoView *videoView;


@end

//
//  HomePage.h
//  WhereIs
//
//  Created by admin on 16/5/1.
//  Copyright © 2016年 ShipuW. All rights reserved.
//

#import "BaseNavPage.h"
#import "CameraBackgroundWidget.h"

@interface HomePage : BaseNavPage{

    IBOutlet UIView         *_cameraView;
    CameraBackgroundWidget  *_cameraWidget;
}

@end

//
//  MyPage.h
//  WhereIs
//
//  Created by admin on 16/5/4.
//  Copyright © 2016年 ShipuW. All rights reserved.
//

#import "BaseNavPage.h"

@interface MyPage : BaseNavPage{
    IBOutlet UIImageView    *_logoImage;
    IBOutlet UILabel        *_appName;
    IBOutlet UILabel        *_appVersion;
    IBOutlet UIButton       *_loginButton;
    NSString                *_token;
}

@end

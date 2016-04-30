//
//  AdvertPage.h
//  WhereIs
//
//  Created by admin on 16/5/1.
//  Copyright © 2016年 ShipuW. All rights reserved.
//

#import "BasePage.h"

@interface AdvertPage : BasePage{
    IBOutlet UIImageView *_advertImage;
}

+ (BOOL)canShowAdvertPage;
+ (void)showAdvertPage;

@end

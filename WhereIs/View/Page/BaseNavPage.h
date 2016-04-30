//
//  BaseNavPage.h
//  WhereIs
//
//  Created by admin on 16/5/1.
//  Copyright © 2016年 ShipuW. All rights reserved.
//

#import "BaseController.h"

@interface BaseNavPage : BaseController

@property(nonatomic, strong) NSString   *barBackgroudImage;

- (void)setNavigationItem:(NSString *)title
                 selector:(SEL)selector
                  isRight:(BOOL)isRight;

@end

//
//  ViewOnCamera.h
//  WhereIs
//
//  Created by admin on 16/5/3.
//  Copyright © 2016年 ShipuW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewOnCamera : UIView

@property(nonatomic, assign) MAPointAnnotation* annotation;

- (void)setTitle:(NSString *)title;
- (void)setSubtitle:(NSString *)subtitle;


@end

//
//  BaseController.h
//  WhereIs
//
//  Created by admin on 16/5/1.
//  Copyright © 2016年 ShipuW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseOperation.h"
#import "FxActivity.h"

@interface BaseController : UIViewController<BaseOperationDelegate>{
    BaseOperation       *_operation;
    FxActivity          *_activity;
}

- (void)showIndicator:(NSString *)tipMessage
             autoHide:(BOOL)hide
           afterDelay:(BOOL)delay;
- (void)hideIndicator;

- (void)setNavigationTitleImage:(NSString *)imageName;
- (void)setNavigationLeft:(NSString *)imageName sel:(SEL)sel;
- (void)setNavigationRight:(NSString *)imageName;
- (void)setStatusBarStyle:(UIStatusBarStyle)style;
- (IBAction)doBack:(id)sender;

@end

//
//  CalloutWidget.h
//  WhereIs
//
//  Created by admin on 16/5/2.
//  Copyright © 2016年 ShipuW. All rights reserved.
//

#import "BaseWidget.h"

@protocol CalloutDelegate;
@interface CalloutWidget : UIView

//@property (nonatomic, strong) UIImage *image;
//@property (nonatomic, copy) NSString *callouttitle;
//@property (nonatomic, copy) NSString *calloutsubtitle;
@property(nonatomic, assign) MAPointAnnotation* annotation;
@property(nonatomic, assign) id<CalloutDelegate> delegate;

- (void)setTitle:(NSString *)title;
- (void)setSubtitle:(NSString *)subtitle;
- (void)setButtonImage:(UIImage *)image;


@end

@protocol CalloutDelegate <NSObject>

- (void)beginNavigation:(MAPointAnnotation *)annotation;

@end
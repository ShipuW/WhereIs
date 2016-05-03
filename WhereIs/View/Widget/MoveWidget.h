//
//  MoveWidget.h
//  WhereIs
//
//  Created by admin on 16/5/3.
//  Copyright © 2016年 ShipuW. All rights reserved.
//

#import "BaseWidget.h"
@protocol MoveWidgetDelegate;

@interface MoveWidget : BaseWidget{
    IBOutlet UIView *_moveView;
        UIPanGestureRecognizer  *_panGesture;
    
}
@property(nonatomic, assign) id<MoveWidgetDelegate> delegate;
@property(nonatomic) IBOutlet UIImageView *arrowImage;

@end

@protocol MoveWidgetDelegate <NSObject>

- (void)beginMove:(CGFloat)moveY;

@end
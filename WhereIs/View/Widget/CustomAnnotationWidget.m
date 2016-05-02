//
//  CustomAnnotationView.m
//  WhereIs
//
//  Created by admin on 16/5/2.
//  Copyright © 2016年 ShipuW. All rights reserved.
//

#import "CustomAnnotationWidget.h"

@interface CustomAnnotationWidget ()

    @property (nonatomic, strong, readwrite) CalloutWidget *calloutWidget;

@end

@implementation CustomAnnotationWidget
@synthesize calloutWidget = _calloutWidget;

#pragma mark - Override

- (void)setSelected:(BOOL)selected
{
    [self setSelected:selected animated:NO];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    if (self.selected == selected)
    {
        return;
    }
    
    if (selected)
    {
        if (self.calloutWidget == nil)
        {
            self.calloutWidget = [[CalloutWidget alloc] init];
            _calloutWidget.delegate = _ownerMapPage;
            self.calloutWidget.center = CGPointMake(CGRectGetWidth(self.bounds) / 2.f + self.calloutOffset.x,
                                                  -CGRectGetHeight(self.calloutWidget.bounds) / 2.f + self.calloutOffset.y);
        }
        
//        self.calloutWidget.image = [UIImage imageNamed:@"beginnav.png"];
//        self.calloutWidget.callouttitle = self.annotation.title;
//        self.calloutWidget.calloutsubtitle = self.annotation.subtitle;
        
        [self.calloutWidget setTitle:self.annotation.title];
        [self.calloutWidget setSubtitle:self.annotation.subtitle];
        [self.calloutWidget setButtonImage:[UIImage imageNamed:@"beginnav.png"]];
        self.calloutWidget.annotation = self.annotation ;
        
        [self addSubview:self.calloutWidget];
    }
    else
    {
        [self.calloutWidget removeFromSuperview];
    }
    
    [super setSelected:selected animated:animated];
}

// 重新此函数，用以实现点击calloutView判断为点击该annotationView
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    BOOL inside = [super pointInside:point withEvent:event];
    
    if (!inside && self.selected)
    {
        inside = [self.calloutWidget pointInside:[self convertPoint:point toView:self.calloutWidget] withEvent:event];
    }
    
    return inside;
}

#pragma mark - CalloutDelegate

//- (void)beginNavigation:(MAPointAnnotation *)annotation{
//    NSLog(@"%@",annotation.title);
//    //[self.delegate beginNavigation2MapWidget:annotation];
//}

@end

//
//  CustomAnnotationView.h
//  WhereIs
//
//  Created by admin on 16/5/2.
//  Copyright © 2016年 ShipuW. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>
#import "CalloutWidget.h"
//#import "MapWidget.h"
//@class MapWidget;
@class MapPage;
//@protocol CustomAnnotationDelegate;

@interface CustomAnnotationWidget : MAAnnotationView //<CalloutDelegate>

@property (nonatomic, readonly) CalloutWidget *calloutWidget;
//@property (nonatomic, assign)   id<CustomAnnotationDelegate> delegate;
//@property (nonatomic, assign)   MapWidget   *ownerMapWidget;
@property (nonatomic, assign)   MapPage     *ownerMapPage;
@end

//@protocol CustomAnnotationDelegate <NSObject>
//
//- (void)beginNavigation2MapWidget:(MAPointAnnotation *)annotation;
//
//@end
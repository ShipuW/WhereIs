//
//  MapWidget.h
//  WhereIs
//
//  Created by admin on 16/5/1.
//  Copyright © 2016年 ShipuW. All rights reserved.
//

#import "BaseWidget.h"
#import "CustomAnnotationWidget.h"
@class MapPage;



//@protocol MapWidgetDelegate;

@interface MapWidget : BaseWidget<MAMapViewDelegate,UIGestureRecognizerDelegate>{
//    MAMapView                       *_mapView;
    NSMutableArray                  *_annotations;
    UILongPressGestureRecognizer    *_longPressGesture;
    
    
}


@property (nonatomic) MAMapView                 *mapView;
@property (nonatomic) MAMapLanguage             language;
@property (nonatomic) CLLocationCoordinate2D    centerCoordinate;
@property (nonatomic) CGFloat                   zoomLevel;
@property (nonatomic) CLLocation                *currentLocation;
@property (nonatomic) MAPointAnnotation         *destinationPoint;
@property (nonatomic) MapPage                   *ownerPage;
@property (nonatomic) UIButton                  *locationButton;
//@property (nonatomic) MAPointAnnotation         *currentAnnotation;
//@property(nonatomic, assign) id<MapWidgetDelegate> delegate;

- (void)addPoiAnnotation:(MAPointAnnotation *)annotation;
- (void)removePoiAnnotation:(MAPointAnnotation *)annotation;
- (void)clearAllAnnotations;
- (void)setPathRequest;
//- (void)reSizeMap:(MAMapRect)rect;
@end

//@protocol MapWidgetDelegate <NSObject>
//
//- (void)beginNavigation2MapPage:(MAPointAnnotation *)annotation;
//
//@end
//
//  MapWidget.h
//  WhereIs
//
//  Created by admin on 16/5/1.
//  Copyright © 2016年 ShipuW. All rights reserved.
//

#import "BaseWidget.h"

@interface MapWidget : BaseWidget<MAMapViewDelegate>{
    MAMapView       *_mapView;
    NSMutableArray  *_annotations;
    
}

@property (nonatomic) MAMapLanguage             language;
@property (nonatomic) CLLocationCoordinate2D    centerCoordinate;
@property (nonatomic) CGFloat                   zoomLevel;
@property (nonatomic) CLLocation                *currentLocation;

- (void)addPoiAnnotation:(MAPointAnnotation *)annotation;
- (void)removePoiAnnotation:(MAPointAnnotation *)annotation;
- (void)clearAllAnnotations;
@end

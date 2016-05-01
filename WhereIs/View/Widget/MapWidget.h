//
//  MapWidget.h
//  WhereIs
//
//  Created by admin on 16/5/1.
//  Copyright © 2016年 ShipuW. All rights reserved.
//

#import "BaseWidget.h"

@interface MapWidget : BaseWidget<MAMapViewDelegate,AMapSearchDelegate>{
    MAMapView       *_mapView;
    AMapSearchAPI   *_search;
    CLLocation      *_currentLocation;
    IBOutlet UIButton *_searchButton;
}

@property (nonatomic) MAMapLanguage             language;
@property (nonatomic) CLLocationCoordinate2D    centerCoordinate;
@property (nonatomic) CGFloat                   zoomLevel;

@end

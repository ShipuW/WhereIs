//
//  MapWidget.m
//  WhereIs
//
//  Created by admin on 16/5/1.
//  Copyright © 2016年 ShipuW. All rights reserved.
//

#import "MapWidget.h"
#import "AppDelegate.h"
#import <AMapSearchKit/AMapSearchAPI.h>


@implementation MapWidget

//- (instancetype)init {//初始化值
//    self = [super init];
//    if (self) {
//        _language = _mapView.language;
//        _centerCoordinate = _mapView.centerCoordinate;
//        _zoomLevel = _mapView.zoomLevel;
//    }
//    return self;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initMapView];
    [self initSearch];
    [self initNaviManager];
    [self initAttributes];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (void)initMapView{
    _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds))];
    _mapView.delegate = self;
    _mapView.showsCompass = NO;
#pragma mark - modify here
    MAMapPoint myPoint;
    myPoint.x = 0;
    myPoint.y = 0;
    MAMapSize mySize;
    mySize.height = 200;
    mySize.width = 200;
    MAMapRect currentMapRect;
    currentMapRect.origin = myPoint;
    currentMapRect.size = mySize;
    //_mapView.visibleMapRect = currentMapRect;
    [_mapView setVisibleMapRect:currentMapRect];
    //    if (_language)
//        _mapView.language = _language;
//    if (_centerCoordinate)
        _mapView.centerCoordinate = _centerCoordinate;
//    if (_zoomLevel)
        _mapView.zoomLevel = _zoomLevel;
    _mapView.showsUserLocation = YES;
    [_mapView setUserTrackingMode:MAUserTrackingModeFollow animated:YES];
    [self.view addSubview:_mapView];
    
}

- (void)initNaviManager
{
    if (_naviManager == nil)
    {
        _naviManager = [[AMapNaviManager alloc] init];
        [_naviManager setDelegate:self];
    }
}
- (void)initSearch{
    _search = [[AMapSearchAPI alloc] init];
    _search.delegate = self;
}

- (void)initAttributes{
    _annotations = [NSMutableArray array];
    self.listData = nil;
    _destinationPoint = [[MAPointAnnotation alloc]init];
    _longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    _longPressGesture.delegate = self;
    _longPressGesture.minimumPressDuration = 0.4;
    [_mapView addGestureRecognizer:_longPressGesture];
}

- (void)handleLongPress:(UILongPressGestureRecognizer *)gesture{
    if (gesture.state == UIGestureRecognizerStateBegan){
        CLLocationCoordinate2D coordinate = [_mapView convertPoint:[gesture locationInView:_mapView] toCoordinateFromView:_mapView];
        
        if (_destinationPoint != nil){
            [_mapView removeAnnotation:_destinationPoint];
            _destinationPoint = nil;
        }
        
        
        _destinationPoint.coordinate = coordinate;
        _destinationPoint.title = @"地图选点";
        
        [_mapView addAnnotation:_destinationPoint];
        
    }
}

- (void)reGeoAction{//逆地理编码搜索请求
    if(_currentLocation){
        AMapReGeocodeSearchRequest *request = [[AMapReGeocodeSearchRequest alloc] init];
        request.location = [AMapGeoPoint locationWithLatitude:_currentLocation.coordinate.latitude longitude:_currentLocation.coordinate.longitude];
        [_search AMapReGoecodeSearch:request];
    }
}

- (MAPointAnnotation*)containAnnotation:(MAPointAnnotation *)annotation in:(NSMutableArray<MAPointAnnotation*>*)annotations{
    for (MAPointAnnotation *ann in annotations){
        if( (ann.title == annotation.title)&&(ann.subtitle == annotation.subtitle) ){
            return ann;
        }
    }
    return nil;
}

- (void)addPoiAnnotation:(MAPointAnnotation *)annotation{
    [self removePoiAnnotation:[self containAnnotation:annotation in:_annotations]];
    [_annotations addObject:annotation];
    [_mapView addAnnotation:annotation];
    [_mapView setCenterCoordinate:annotation.coordinate animated:YES];

}
- (void)removePoiAnnotation:(MAPointAnnotation *)annotation{
    [_annotations removeObject:annotation];
    [_mapView removeAnnotation:annotation];
}
- (void)clearAllAnnotations{
    [_mapView removeAnnotations:_annotations];
    [_annotations removeAllObjects];
}



- (void)setPathRequest{
    
    _startPoint = [AMapNaviPoint locationWithLatitude:_mapView.userLocation.coordinate.latitude longitude:_mapView.userLocation.coordinate.longitude];
    _endPoint = [AMapNaviPoint locationWithLatitude:_destinationPoint.coordinate.latitude longitude:_destinationPoint.coordinate.longitude];
    
    NSArray *startPoints = @[_startPoint];
    NSArray *endPoints   = @[_endPoint];
    [self.naviManager calculateWalkRouteWithStartPoints:startPoints endPoints:endPoints];
}



- (void)showRouteWithNaviRoute:(AMapNaviRoute *)naviRoute
{
    if (naviRoute == nil)
    {
        return;
    }
    
    // 清除旧的overlays
    [self.mapView removeOverlays:self.mapView.overlays];
    
    NSUInteger coordianteCount = [naviRoute.routeCoordinates count];
    CLLocationCoordinate2D coordinates[coordianteCount];
    for (int i = 0; i < coordianteCount; i++)
    {
        AMapNaviPoint *aCoordinate = [naviRoute.routeCoordinates objectAtIndex:i];
        coordinates[i] = CLLocationCoordinate2DMake(aCoordinate.latitude, aCoordinate.longitude);
    }
    
    MAPolyline *polyline = [MAPolyline polylineWithCoordinates:coordinates count:coordianteCount];
    [self.mapView addOverlay:polyline];
    [_mapView showAnnotations:@[_mapView.userLocation,_destinationPoint] animated:YES];
}

#pragma mark - MAMapViewDelegate,AMapSearchDelegate,AMapNaviManagerDelegate

- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error{
    NSLog(@"request:%@,error:%@",request,error);
}

- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response{
    NSLog(@"response : %@", response);
    NSString *title = response.regeocode.addressComponent.city;
    if(title.length == 0){
        title = response.regeocode.addressComponent.province;
    }
    
    _mapView.userLocation.title = title;
    _mapView.userLocation.subtitle = response.regeocode.formattedAddress;
    
}

- (void)mapView:(MAMapView *)mapView didChangeUserTrackingMode:(MAUserTrackingMode)mode animated:(BOOL)animated
{
    // 修改定位按钮状态
    if (mode == MAUserTrackingModeNone)
    {
        [_locationButton setImage:[UIImage imageNamed:@"location_no"] forState:UIControlStateNormal];
    }
    else
    {
        [_locationButton setImage:[UIImage imageNamed:@"location_yes"] forState:UIControlStateNormal];
    }
}



-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation
updatingLocation:(BOOL)updatingLocation
{
    if(updatingLocation)
    {
        //取出当前位置的坐标
        _currentLocation = [userLocation.location copy];
        //NSLog(@"%@",_currentLocation);
    }
}

- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view{//标记选中时回调

    if ([view.annotation isKindOfClass:[MAUserLocation class]]){
        [self reGeoAction];
    }
    
}

- (MAAnnotationView*)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation{
    if (annotation == _destinationPoint)
    {
        static NSString *reuseIndetifier = @"startAnnotationReuseIndetifier";
        MAPinAnnotationView *annotationView = (MAPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseIndetifier];
        }
        
        annotationView.canShowCallout = YES;
        annotationView.animatesDrop = YES;
        
        return annotationView;
    }
    
    
    if ([annotation isKindOfClass:[MAPointAnnotation class]]){
        static NSString *reuseIndetifier = @"annotationReuseIndetifier";
        CustomAnnotationWidget *annotationView = (CustomAnnotationWidget *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
        
        //annotationView.delegate = self;
        if (annotationView == nil)
        {
            annotationView = [[CustomAnnotationWidget alloc] initWithAnnotation:annotation reuseIdentifier:reuseIndetifier];
        }
        
        //annotationView.ownerMapWidget = self;
        annotationView.ownerMapPage   = _ownerPage;//传输页面指针
        
        
        annotationView.canShowCallout = NO;
        //annotationView.animatesDrop = YES;
        
        
        annotationView.image = [UIImage imageNamed:@"pin.png"];
        
        // 设置为NO，用以调用自定义的calloutView
        annotationView.canShowCallout = NO;
        
        // 设置中心点偏移，使得标注底部中间点成为经纬度对应点
        annotationView.centerOffset = CGPointMake(0, -18);
        

        
        return annotationView;
    }
    
    return nil;
}


- (void)naviManagerOnCalculateRouteSuccess:(AMapNaviManager *)naviManager
{

    NSLog(@"OnCalculateRouteSuccess");
    
    [self showRouteWithNaviRoute:[[naviManager naviRoute] copy]];
    
    _calRouteSuccess = YES;
}

- (MAOverlayView *)mapView:(MAMapView *)mapView viewForOverlay:(id<MAOverlay>)overlay
{
    if ([overlay isKindOfClass:[MAPolyline class]])
    {
        MAPolylineView *polylineView = [[MAPolylineView alloc] initWithPolyline:overlay];
        
        polylineView.lineWidth   = 5.0f;
        polylineView.strokeColor = [UIColor redColor];
        
        return polylineView;
    }
    return nil;
}

#pragma mark - CalloutDelegate

//- (void)beginNavigation:(MAPointAnnotation *)annotation{
//    NSLog(@"%@",annotation.title);
//    //[self.delegate beginNavigation2MapPage:annotation];
//}

@end

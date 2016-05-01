//
//  MapWidget.m
//  WhereIs
//
//  Created by admin on 16/5/1.
//  Copyright © 2016年 ShipuW. All rights reserved.
//

#import "MapWidget.h"



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
    [self initAttributes];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (void)initMapView{
    _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds))];
    _mapView.delegate = self;
    _mapView.language = _language;
    _mapView.centerCoordinate = _centerCoordinate;
    _mapView.zoomLevel = _zoomLevel;
    _mapView.showsUserLocation = YES;
    [_mapView setUserTrackingMode:MAUserTrackingModeFollow animated:YES];
    [self.view addSubview:_mapView];
    
}


- (void)initSearch{
    _search = [[AMapSearchAPI alloc] init];
    _search.delegate = self;
}

- (void)initAttributes{
    _annotations = [NSMutableArray array];
    self.listData = nil;
}

- (void)reGeoAction{//逆地理编码搜索请求
    if(_currentLocation){
        AMapReGeocodeSearchRequest *request = [[AMapReGeocodeSearchRequest alloc] init];
        request.location = [AMapGeoPoint locationWithLatitude:_currentLocation.coordinate.latitude longitude:_currentLocation.coordinate.longitude];
        [_search AMapReGoecodeSearch:request];
    }
}



#pragma mark - MAMapViewDelegate,AMapSearchDelegate

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



-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation
updatingLocation:(BOOL)updatingLocation
{
    if(updatingLocation)
    {
        //取出当前位置的坐标
        NSLog(@"latitude : %f,longitude: %f",userLocation.coordinate.latitude,userLocation.coordinate.longitude);
        _currentLocation = [userLocation.location copy];
    }
}

- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view{//标记选中时回调

    if ([view.annotation isKindOfClass:[MAUserLocation class]]){
        [self reGeoAction];
    }
    
}

@end

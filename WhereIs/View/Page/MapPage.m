//
//  MapPage.m
//  WhereIs
//
//  Created by admin on 16/5/1.
//  Copyright © 2016年 ShipuW. All rights reserved.
//

#import "MapPage.h"
#import "CameraPage.h"
#import "SearchPage.h"

@implementation MapPage

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initControls];
    [self addMapView];
    [self initSearch];

    [self initAttributes];
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    if ([_searchKeyword isEqualToString:@""]){
    }else{
//        MAMapPoint point;
//        point.x = 0;
//        point.y = 0;
//        MAMapSize size;
//        size.width = self.view.frame.size.width;
//        size.height = self.view.frame.size.height * 0.5;
//        MAMapRect rect;
//        rect.origin = point;
//        rect.size = size;
//        [_mapWidget reSizeMap:rect];

        [self beginSearch];
    }
            
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)addMapView{
    
    _mapWidget = [[MapWidget alloc] init];
    //_mapWidget.language = MAMapLanguageEn;
    _mapWidget.zoomLevel = kDefaultLocationZoomLevel;
    _mapWidget.ownerPage = self;
    _mapWidget.locationButton = _locationButton;

    
    _mapWidget.view.frame = _mapView.bounds;//赋值要放在这句之前
    [_mapView addSubview:_mapWidget.view];
    [_mapView sendSubviewToBack:_mapWidget.view];//加上widget后放到底部，使原本的subview显示出来
    
}

- (void)addPositionTableViewWithArray:(NSArray *)array{
    [_positionTableView setHidden:NO];
    _positionTableWidget = [[PositionTableWidget alloc] init];
    _positionTableWidget.delegate = self;
    
    _positionTableWidget.listData = array;
    _positionTableWidget.view.frame = _positionTableView.bounds;//赋值要放在这句之前
    [_positionTableView addSubview:_positionTableWidget.view];
}


- (void)initSearch{
    _search = [[AMapSearchAPI alloc] init];
    _search.delegate = self;
}

//- (void)initNaviManager
//{
//    if (_naviManager == nil)
//    {
//        _naviManager = [[AMapNaviManager alloc] init];
//        [_naviManager setDelegate:self];
//    }
//}

- (void)initControls{
    _searchButton.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
    [_positionTableView setHidden:YES];
    self.title = @"在哪";
}

- (void)initAttributes{
    
    _searchKeyword = @"";
}

- (IBAction)searchAction:(id)sender{
    SearchPage *page = [[SearchPage alloc] init];
    
    page.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:page animated:YES];
    
    [_mapWidget clearAllAnnotations];

}

- (IBAction)locateAction:(id)sender{
    if (_mapWidget.mapView.userTrackingMode != MAUserTrackingModeFollow)
    {
        _mapWidget.mapView.userTrackingMode = MAUserTrackingModeFollow;
        [_mapWidget.mapView setZoomLevel:kDefaultLocationZoomLevel animated:YES];
    }

}

- (IBAction)pathAction:(id)sender{
    if (_mapWidget.destinationPoint == nil || _mapWidget.currentLocation == nil || _search == nil)
    {
        NSLog(@"path search failed");
        return;
    }
    [_mapWidget setPathRequest];
//    AMapNavigationSearchRequest *request = [[AMapNavigationSearchRequest alloc] init];
//    
//    // 设置为步行路径规划
//    request.searchType = AMapSearchType_NaviWalking;
//    
//    request.origin = [AMapGeoPoint locationWithLatitude:_currentLocation.coordinate.latitude longitude:_currentLocation.coordinate.longitude];
//    request.destination = [AMapGeoPoint locationWithLatitude:_destinationPoint.coordinate.latitude longitude:_destinationPoint.coordinate.longitude];
//    
//    [_search AMapNavigationSearch:request];

}

- (void)beginSearch{
    [_mapWidget clearAllAnnotations];
    
    if (_mapWidget.currentLocation == nil || _search == nil){
        NSLog(@"search failed");
        return;
    }
    
    AMapPOIAroundSearchRequest *request = [[AMapPOIAroundSearchRequest alloc] init];
    request.location = [AMapGeoPoint locationWithLatitude:_mapWidget.currentLocation.coordinate.latitude longitude:_mapWidget.currentLocation.coordinate.longitude];
    request.keywords = _searchKeyword;
    request.types = @"餐饮服务|生活服务";
    request.sortrule = 0;
    request.requireExtension = YES;
    
    //发起周边搜索
    [_search AMapPOIAroundSearch: request];
}

#pragma mark - AMapSearchDelegate,PositionTableDelegate,MapWidgetDelegate,CalloutDelegate




- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{
    if(response.pois.count == 0)
    {
        [self showIndicator:@"没有找到，请重新输入" autoHide:YES afterDelay:YES];
        return;
    }
    
    //通过 AMapPOISearchResponse 对象处理搜索结果
    NSString *strCount = [NSString stringWithFormat:@"count: %ld",(long)response.count];
    NSString *strSuggestion = [NSString stringWithFormat:@"Suggestion: %@", response.suggestion];
    NSString *strPoi = @"";
    for (AMapPOI *p in response.pois) {
        strPoi = [NSString stringWithFormat:@"%@\nPOI: %@", strPoi, p.description];
    }
    NSString *result = [NSString stringWithFormat:@"%@ \n %@ \n %@", strCount, strSuggestion, strPoi];
    NSLog(@"Place: %@", result);
    
    [self addPositionTableViewWithArray:response.pois];
    
}

- (void)didSelect:(MAPointAnnotation *)annotation{
    [_mapWidget addPoiAnnotation:annotation];
}

- (void)beginNavigation:(MAPointAnnotation *)annotation{
    //NSLog(@"%@",annotation.title);
    CameraPage *page = [[CameraPage alloc] init];
    
    page.myLocation = _mapWidget.currentLocation;
    page.targetAnnotation = annotation;
    page.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:page animated:YES];
}

@end



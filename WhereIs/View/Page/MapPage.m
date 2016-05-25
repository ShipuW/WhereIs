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
#import "MyPage.h"


@interface MapPage(){
    CGFloat originMoveViewCenterY;
    CGFloat originTableViewCenterY;
    CGPoint curMoveCenter;
    CGPoint curPositionTableView;
    UIView *codeTableView;
    UIView *codeMoveView;
}

@end

@implementation MapPage

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initControls];
    [self addMapView];

    [self initSearch];
    

    [self initAttributes];
}

- (void)viewWillAppear:(BOOL)animated{
    curMoveCenter = codeMoveView.center;
    curPositionTableView = codeTableView.center;
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

- (void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
    [codeTableView removeFromSuperview];
    [codeMoveView removeFromSuperview];
    _searchKeyword = @"";
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

- (void)addMoveView{
    codeMoveView = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.height - self.view.width - MoveWidgetHeight, self.view.width, MoveWidgetHeight)];
    originMoveViewCenterY = codeMoveView.centerY;
    codeMoveView.backgroundColor = [UIColor whiteColor];
    codeMoveView.alpha = 0.5;
    _moveWidget = [[MoveWidget alloc] init];
    _moveWidget.delegate = self;

    _moveWidget.view.frame = codeMoveView.bounds;//赋值要放在这句之前
    [codeMoveView addSubview:_moveWidget.view];
    [codeMoveView sendSubviewToBack:_moveWidget.view];
    originMoveViewCenterY = codeMoveView.center.y;
    [self.view addSubview:codeMoveView];

}

- (void)addPositionTableViewWithArray:(NSArray *)array{

    codeTableView = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.height - self.view.width , self.view.width, self.view.width)];
    originTableViewCenterY = codeTableView.centerY;
    _positionTableWidget = [[PositionTableWidget alloc] init];
    _positionTableWidget.delegate = self;
    
    _positionTableWidget.listData = array;
    _positionTableWidget.view.frame = codeTableView.bounds;//赋值要放在这句之前
    [codeTableView addSubview:_positionTableWidget.view];
    curPositionTableView.y = codeTableView.center.y;
    [self.view addSubview:codeTableView];
    
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
    [codeTableView setHidden:YES];
    [codeMoveView setHidden:YES];
    self.title = AppTitle; 
}

- (void)initAttributes{
    
    _searchKeyword = @"";
}

- (IBAction)searchAction:(id)sender{
    SearchPage *page = [[SearchPage alloc] init];
    
    [self.navigationController pushViewController:page animated:YES];
    
    [_mapWidget clearAllAnnotations];

}

- (IBAction)locateAction:(id)sender{
//    float tempy = _moveView.y;
    if (_mapWidget.mapView.userTrackingMode != MAUserTrackingModeFollow)
    {
        _mapWidget.mapView.userTrackingMode = MAUserTrackingModeFollow;
        [_mapWidget.mapView setZoomLevel:kDefaultLocationZoomLevel animated:YES];
    }
//    [_moveView setY:tempy];
    codeMoveView.center = curMoveCenter;
    codeTableView.center = curPositionTableView;
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

- (IBAction)myAction:(id)sender{
    MyPage *page = [[MyPage alloc] init];
    
    [self.navigationController pushViewController:page animated:YES];
    
    [_mapWidget clearAllAnnotations];
}

- (void)beginSearch{
    if([self isConnectionAvailable ]){
        [self showIndicator:@"搜索中" autoHide:NO afterDelay:NO];
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
        
    //    AMapPlaceSearchRequest *request = [[AMapPlaceSearchRequest alloc] init];
    //    request.searchType = AMapSearchType_PlaceAround;
    //    request.location = [AMapGeoPoint locationWithLatitude:_currentLocation.coordinate.latitude longitude:_currentLocation.coordinate.longitude];
    //    
    //    request.keywords = @"餐饮";
    //    
    //    [_search AMapPlaceSearch:request];
    }else{
        [self showIndicator:NetworkLost autoHide:YES afterDelay:YES];
    }
}



-(BOOL) isConnectionAvailable{
    
    BOOL isExistenceNetwork = YES;
    Reachability *reach = [Reachability reachabilityWithHostName:@"www.apple.com"];
    switch ([reach currentReachabilityStatus]) {
        case NotReachable:
            isExistenceNetwork = NO;
            //NSLog(@"notReachable");
            break;
        case ReachableViaWiFi:
            isExistenceNetwork = YES;
            //NSLog(@"WIFI");
            break;
        case ReachableViaWWAN:
            isExistenceNetwork = YES;
            //NSLog(@"3G");
            break;
    }
    
    return isExistenceNetwork;
}


#pragma mark - AMapSearchDelegate,PositionTableDelegate,MapWidgetDelegate,CalloutDelegate,MoveWidgetDelegate




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
    [self addMoveView];
    [self hideIndicator];
    
    
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

- (void)beginMove:(CGFloat)moveY{
    if(codeMoveView.center.y < originMoveViewCenterY - 1){
        [_moveWidget.arrowImage setImage:[UIImage imageNamed:@"arrow_down.png"]];
        [codeMoveView setCenterY:originMoveViewCenterY];
        [codeTableView setCenterY:originTableViewCenterY];

    }else if(codeMoveView.center.y + 0.5 * codeMoveView.frame.size.height > self.view.frame.size.height + 1){
        [_moveWidget.arrowImage setImage:[UIImage imageNamed:@"arrow_up.png"]];
        [codeMoveView setCenterY:self.view.height - 0.5 * MoveWidgetHeight];
        [codeTableView setCenterY:self.view.height + 0.5 * self.view.width];
        
    }else{
        
        codeTableView.center = CGPointMake(codeTableView.center.x, codeTableView.center.y + moveY);
        codeMoveView.center = CGPointMake(codeMoveView.center.x, codeMoveView.center.y + moveY);
    }
    curPositionTableView = codeTableView.center;
    curMoveCenter = codeMoveView.center;
}

@end



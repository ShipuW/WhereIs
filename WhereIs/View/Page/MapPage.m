//
//  MapPage.m
//  WhereIs
//
//  Created by admin on 16/5/1.
//  Copyright © 2016年 ShipuW. All rights reserved.
//

#import "MapPage.h"
#import "CameraPage.h"

@implementation MapPage

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addMapView];
    [self initSearch];
    [self initControls];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)addMapView{
    
    _mapWidget = [[MapWidget alloc] init];
    //_mapWidget.language = MAMapLanguageEn;;
    //_mapWidget.zoomLevel = 11.0;
    _mapWidget.ownerPage = self;

    
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
    //[_positionTableView sendSubviewToBack:_positionTableWidget.view];//加上widget后放到底部，使原本的subview显示出来
    //[_positionTableWidget updateUI];
}


- (void)initSearch{
    _search = [[AMapSearchAPI alloc] init];
    _search.delegate = self;
}

- (void)initControls{
    _searchButton.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
    [_positionTableView setHidden:YES];
    self.title = @"在哪";
}

- (IBAction)searchAction:(id)sender{
    [_mapWidget clearAllAnnotations];
    
    if (_mapWidget.currentLocation == nil || _search == nil){
        NSLog(@"search failed");
        return;
    }
    
    AMapPOIAroundSearchRequest *request = [[AMapPOIAroundSearchRequest alloc] init];
    request.location = [AMapGeoPoint locationWithLatitude:_mapWidget.currentLocation.coordinate.latitude longitude:_mapWidget.currentLocation.coordinate.longitude];
    request.keywords = @"重庆";
    request.types = @"餐饮服务|生活服务";
    request.sortrule = 0;
    request.requireExtension = YES;
    
    //发起周边搜索
    [_search AMapPOIAroundSearch: request];
//    _positionTableWidget.view.frame = CGRectMake(_positionTableView.frame.origin.x, _positionTableView.frame.origin.y, _positionTableView.frame.size.width, _positionTableView.frame.size.width * 0.5);
}

#pragma mark - AMapSearchDelegate,PositionTableDelegate,MapWidgetDelegate,CalloutDelegate


- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{
    if(response.pois.count == 0)
    {
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
    
    page.targetAnnotation = annotation;
    page.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:page animated:YES];
}

@end



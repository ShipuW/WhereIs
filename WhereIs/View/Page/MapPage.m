//
//  MapPage.m
//  WhereIs
//
//  Created by admin on 16/5/1.
//  Copyright © 2016年 ShipuW. All rights reserved.
//

#import "MapPage.h"

@interface MapPage ()

@end

@implementation MapPage

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addMapView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)addMapView{
    
    _mapWidget = [[MapWidget alloc] init];
    //_mapWidget.language = MAMapLanguageEn;;
    //_mapWidget.zoomLevel = 11.0;
    
    _mapWidget.view.frame = _mapView.bounds;//赋值要放在这句之前
    [_mapView addSubview:_mapWidget.view];
    [_mapView sendSubviewToBack:_mapWidget.view];//加上widget后放到底部，使原本的subview显示出来
    
}


@end

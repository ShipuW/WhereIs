//
//  SearchPage.m
//  WhereIs
//
//  Created by admin on 16/5/2.
//  Copyright © 2016年 ShipuW. All rights reserved.
//

#import "SearchPage.h"
#import "MapPage.h"

@implementation SearchPage

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addSearchBar];
    [self addSearchTable];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)addSearchBar{
    _searchWidget = [[SearchWidget alloc] init];
    _searchWidget.delegate = self;
    
    
    _searchWidget.view.frame = _searchBarView.bounds;//赋值要放在这句之前
    [_searchBarView addSubview:_searchWidget.view];
    [_searchBarView sendSubviewToBack:_searchWidget.view];//加上widget后放到底部，使原本的subview显示出来
}

-(void)addSearchTable{

}

#pragma mark - SearchWidgetDelegate

- (void)searchString:(NSString *)keyword{
    MapPage *mapPage = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-2];
    mapPage.searchKeyword = keyword;
    [self.navigationController popToViewController:mapPage animated:true];
    
}

@end

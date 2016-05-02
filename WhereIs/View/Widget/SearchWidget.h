//
//  SearchWidget.h
//  WhereIs
//
//  Created by admin on 16/5/1.
//  Copyright © 2016年 ShipuW. All rights reserved.
//

#import "BaseWidget.h"
@protocol SearchWidgetDelegate;
@interface SearchWidget : BaseWidget<UISearchBarDelegate>


@property (nonatomic) NSString                      *keyword;
@property (retain, nonatomic) IBOutlet UISearchBar  *searchBar;
@property(nonatomic, assign) id<SearchWidgetDelegate> delegate;


@end


@protocol SearchWidgetDelegate <NSObject>

- (void)searchString:(NSString *)keyword;

@end
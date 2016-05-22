//
//  SearchPage.h
//  WhereIs
//
//  Created by admin on 16/5/2.
//  Copyright © 2016年 ShipuW. All rights reserved.
//

#import "BaseNavPage.h"
#import "SearchWidget.h"
#import "SearchTableWidget.h"

@interface SearchPage : BaseNavPage<SearchWidgetDelegate,SearchTableDelegate>
{
    SearchWidget        *_searchWidget;
    IBOutlet UIView     *_searchBarView;
    
    SearchTableWidget   *_searchTableWidget;
    IBOutlet UIView     *_searchTableView;


}

@end

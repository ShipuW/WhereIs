//
//  PositionTableWidget.h
//  WhereIs
//
//  Created by admin on 16/5/2.
//  Copyright © 2016年 ShipuW. All rights reserved.
//

#import "TableWidget.h"
#import "PositionCell.h"

@interface PositionTableWidget : TableWidget {
    BOOL        _hasNextPage;
    NSInteger   _pageIndex;
}
- (void)updateUI;

@end

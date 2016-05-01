//
//  PositionTableWidget.h
//  WhereIs
//
//  Created by admin on 16/5/2.
//  Copyright © 2016年 ShipuW. All rights reserved.
//

#import "TableWidget.h"
#import "PositionCell.h"
@protocol PositionTableDelegate;
@interface PositionTableWidget : TableWidget {
    BOOL        _hasNextPage;
    NSInteger   _pageIndex;
}
- (void)updateUI;

@property(nonatomic, assign) id<PositionTableDelegate> delegate;

@end

@protocol PositionTableDelegate <NSObject>

- (void)didSelect:(MAPointAnnotation *)annotation;

@end

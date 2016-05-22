//
//  SearchTableWidget.h
//  WhereIs
//
//  Created by admin on 16/5/2.
//  Copyright © 2016年 ShipuW. All rights reserved.
//

#import "TableWidget.h"
#import "SearchCell.h"
@protocol SearchTableDelegate;

@interface SearchTableWidget : TableWidget


@property (nonatomic) NSString                      *keyword;
@property(nonatomic, assign) id<SearchTableDelegate> delegate;

@end

@protocol SearchTableDelegate <NSObject>

- (void)searchStringFromRecord:(NSString *)keyword;


@end

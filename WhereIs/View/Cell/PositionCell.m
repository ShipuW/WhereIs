//
//  PostionCell.m
//  WhereIs
//
//  Created by admin on 16/5/2.
//  Copyright © 2016年 ShipuW. All rights reserved.
//

#import "PositionCell.h"

@implementation PositionCell

- (void)setCellData:(AMapPOI *)info
{
    [super setCellData:info];
    _subTitleLabel.text = info.address;
}

@end

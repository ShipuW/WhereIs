//
//  SearchCell.m
//  WhereIs
//
//  Created by admin on 16/5/22.
//  Copyright © 2016年 ShipuW. All rights reserved.
//

#import "SearchCell.h"

@implementation SearchCell

- (void)setCellData:(RecordInfo *)record{
    _titleLabel.text = record.name;
}

@end

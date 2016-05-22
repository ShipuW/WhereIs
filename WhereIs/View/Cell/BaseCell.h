//
//  BaseCell.h
//  WhereIs
//
//  Created by admin on 16/5/1.
//  Copyright © 2016年 ShipuW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseCell : UITableViewCell {
    IBOutlet UILabel        *_titleLabel;
}

//@property(nonatomic, strong) BaseInfo   *cellInfo;

- (void)initCell;

- (void)setCellData:(AMapPOI *)info;

@end

//
//  TableWidget.h
//  WhereIs
//
//  Created by admin on 16/5/2.
//  Copyright © 2016年 ShipuW. All rights reserved.
//

#import "BaseWidget.h"

@interface TableWidget : BaseWidget{
    IBOutlet UITableView    *_tableView;
    CGFloat                 _cellHeight;
}

@property(nonatomic, strong) NSString   *cellIdentifier;
@end

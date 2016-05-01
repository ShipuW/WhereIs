//
//  PositionTableWidget.m
//  WhereIs
//
//  Created by admin on 16/5/2.
//  Copyright © 2016年 ShipuW. All rights reserved.
//

#import "PositionTableWidget.h"


@implementation PositionTableWidget

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTableView];
    [self initAttributes];
//    [self updateUI];
}

//- (void)updateUI
//{
//    [_tableView reloadData];
//}

- (void)initTableView{
    self.cellIdentifier = @"PositionCell";
    _cellHeight = 80;
    _pageIndex = 0;//[[FxDate getWeekDay:[NSDate date]] intValue] - 1;;
    _hasNextPage = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)initAttributes{
    //self.listData = nil;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PositionCell *cell = (PositionCell*)[tableView dequeueReusableCellWithIdentifier:self.cellIdentifier];
    if (cell == nil) {
        NSArray* Objects = [[NSBundle mainBundle] loadNibNamed:self.cellIdentifier owner:tableView options:nil];
        
        cell = [Objects objectAtIndex:0];
        [cell initCell];
    }
    
    [cell setCellData:[self.listData objectAtIndex:indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PositionCell *cell = [tableView cellForRowAtIndexPath:indexPath];
}


@end

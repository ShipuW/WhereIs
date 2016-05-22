//
//  SearchTableWidget.m
//  WhereIs
//
//  Created by admin on 16/5/2.
//  Copyright © 2016年 ShipuW. All rights reserved.
//

#import "SearchTableWidget.h"
#import "DBManager.h"
@interface SearchTableWidget ()

@end

@implementation SearchTableWidget

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initTableView];

}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

}

- (void)initTableView{
    self.cellIdentifier = @"SearchCell";
    _cellHeight = 43;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSString *userToken = [FxAppSetting getValue:@"token"];
    if (userToken){
        self.listData = [DBManager fetchRecords:userToken];
        return self.listData.count;
    }
    else
        return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SearchCell *cell = (SearchCell*)[tableView dequeueReusableCellWithIdentifier:self.cellIdentifier];
    if (cell == nil) {
        NSArray* Objects = [[NSBundle mainBundle] loadNibNamed:self.cellIdentifier owner:tableView options:nil];
        
        cell = [Objects objectAtIndex:0];
        [cell initCell];
    }
    NSString *userToken = [FxAppSetting getValue:@"token"];
    if (userToken)
        self.listData = [DBManager fetchRecords:userToken];
    else
        self.listData = nil;
    
    [cell setCellData:[self.listData objectAtIndex:indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];


    RecordInfo *record = [self.listData objectAtIndex:indexPath.row];
    _keyword = record.name;
    [self.delegate searchStringFromRecord:_keyword];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end

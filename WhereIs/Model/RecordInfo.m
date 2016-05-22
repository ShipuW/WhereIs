//
//  RecordInfo.m
//  WhereIs
//
//  Created by admin on 16/5/21.
//  Copyright © 2016年 ShipuW. All rights reserved.
//

#import "RecordInfo.h"

@implementation RecordInfo

+ (instancetype)infoFromDict:(NSDictionary *)dict
{
    RecordInfo *info = [[RecordInfo alloc] init];
    
    info.ID = [dict objectForKey:@"id"];
    info.name = [dict objectForKey:@"name"];
    info.searchTime = [dict objectForKey:@"searchtime"];
    info.searchUser = [dict objectForKey:@"searchuser"];
    
    return info;
}

@end

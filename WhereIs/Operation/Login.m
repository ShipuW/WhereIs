//
//  Login.m
//  WhereIs
//
//  Created by admin on 16/5/4.
//  Copyright © 2016年 ShipuW. All rights reserved.
//

#import "Login.h"
#import "UserInfo.h"


@implementation Login



- (void)parseSuccess:(NSDictionary *)dict jsonString:jsonString
{
    NSDictionary *dictData = [dict objectForKey:NetData];
    UserInfo *info = [UserInfo infoFromDict:dictData];
    
    [_delegate opSuccess:info];
}

@end

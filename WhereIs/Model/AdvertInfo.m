//
//  AdvertInfo.m
//  WhereIs
//
//  Created by admin on 16/5/21.
//  Copyright © 2016年 ShipuW. All rights reserved.
//

#import "AdvertInfo.h"

@implementation AdvertInfo

+ (instancetype)infoFromDict:(NSDictionary *)dict
{
    AdvertInfo *info = [[AdvertInfo alloc] init];
    
    info.ID = [dict objectForKey:@"id"];
    info.name = [dict objectForKey:@"name"];
    info.imageUrl = [dict objectForKey:@"imageurl"];
    info.linkUrl = [dict objectForKey:@"linkurl"];
    
    return info;
}


@end

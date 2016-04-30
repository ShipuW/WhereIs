//
//  GetImage.m
//  WhereIs
//
//  Created by admin on 16/5/1.
//  Copyright © 2016年 ShipuW. All rights reserved.
//

#import "GetImage.h"

@implementation GetImage

- (void)parseData:(NSData *)data
{
    [_delegate opSuccessEx:data opinfo:_opInfo];
}

@end

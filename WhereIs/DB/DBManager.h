//
//  FxDBManager.h
//  FxHejinbo
//
//  Created by hejinbo on 15/5/13.
//  Copyright (c) 2015年 MyCos. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfo.h"
#import "AdvertInfo.h"
#import "RecordInfo.h"

@interface DBManager : NSObject



+ (void)saveUsers:(NSDictionary *)dictInfo;
+ (UserInfo *)fetchUser:(NSString *)userID;

+ (void)saveRecords:(NSDictionary *)dictInfo;
+ (NSArray *)fetchRecords:(NSString *)userToken;

+ (void)saveAdverts:(NSDictionary *)dictInfo;
+ (AdvertInfo *)fetchAdvert:(NSString *)AdvertID;

@end

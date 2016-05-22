//
//  FxDBManager.m
//  FxHejinbo
//
//  Created by hejinbo on 15/5/13.
//  Copyright (c) 2015年 MyCos. All rights reserved.
//

#import "DBManager.h"
#import "DBManager+Private.h"

@implementation DBManager

#define TableColumns    @"FxColumns"
#define TableNews       @"FxNews"
#define TableUsers      @"User "
#define TableRecords    @"Records"
#define TableAdverts    @"Adverts"




+ (void)saveUsers:(NSDictionary *)dictInfo
{
    NSString *dbFile = [Global getUserDBFile];
    
    //存储
    [DBManager save:dictInfo
           primaryKey:@"id"
              inTable:TableUsers
             inDBFile:dbFile];
}

+ (UserInfo *)fetchUser:(NSString *)userID
{
    NSString *dbFile = [Global getUserDBFile];
    NSDictionary *dict = @{@"id":userID};
    NSArray *fields = @[@"id",@"name",@"token"];
    NSArray *contents = [DBManager fetchWithCondition:dict
                                              forFields:fields
                                                inTable:TableUsers
                                               inDBFile:dbFile];
    
    if (contents.count > 0) {
        dict = [contents objectAtIndex:0];
        return [UserInfo infoFromDict:dict];
        
    }
    
    return nil;
}

+ (void)saveRecords:(NSDictionary *)dictInfo
{   
    NSString *dbFile = [Global getUserDBFile];
    
    //存储
    [DBManager save:dictInfo
           primaryKey:@"id"
              inTable:TableRecords
             inDBFile:dbFile];
}

+ (NSArray *)fetchRecords:(NSString *)userToken
{
    NSString *dbFile = [Global getUserDBFile];
    NSDictionary *dict = @{@"searchuser":userToken};
    NSArray *fields = @[@"id",@"name",@"searchtime",@"searchuser"];
    NSArray *contents = [DBManager fetchWithCondition:dict
                                              forFields:fields
                                                inTable:TableRecords
                                               inDBFile:dbFile];
    
    if (contents.count > 0) {
//        dict = [contents objectAtIndex:0];
//        dict = [FxJsonUtility jsonValueFromString:[dict objectForKey:@"json"]];
        
        NSMutableArray *recordArray = [NSMutableArray array];
        for (NSDictionary *record in contents) {
            [recordArray addObject:record];
        }
        return [RecordInfo arrayFromArray:recordArray];
    }
    
    return nil;
    
}

+ (void)saveAdverts:(NSDictionary *)dictInfo
{
    NSString *dbFile = [Global getUserDBFile];
    
    //存储
    [DBManager save:dictInfo
           primaryKey:@"id"
              inTable:TableUsers
             inDBFile:dbFile];
}

+ (AdvertInfo *)fetchAdvert:(NSString *)AdvertID
{
    NSString *dbFile = [Global getUserDBFile];
    NSDictionary *dict = @{@"id":AdvertID};
    NSArray *fields = @[@"id",@"name",@"imageurl",@"contenturl"];
    NSArray *contents = [DBManager fetchWithCondition:dict
                                              forFields:fields
                                                inTable:TableAdverts
                                               inDBFile:dbFile];
    
    if (contents.count > 0) {
        dict = [contents objectAtIndex:0];
        return [AdvertInfo infoFromDict:dict];
        
    }
    
    
    return nil;
}

@end

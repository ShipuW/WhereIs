//
//  URLDefine.h
//  WhereIs
//
//  Created by admin on 16/5/1.
//  Copyright © 2016年 ShipuW. All rights reserved.
//

// 0正式版，1测试版
#define ProductType 1

// 正式版自动使用正式环境
#ifdef OFFICIAL
#undef ProductType
#define ProductType 0
#endif


#if ProductType == 0
#define BaseHost    @"http://wangshipu001.eicp.net"
#define BasePort    @":80"
#else
#define BaseHost    @"http://wangshipu001.eicp.net" //127.0.0.1/192.168.191.1/wangshipu001.eicp.net
#define BasePort    @""//此处若为172或192需要加:80 wangshipu001不用.80
#endif

#define BaseServer  BaseHost BasePort
#define BaseURLPath "/WhereIs/"
#define BaseURL     BaseServer BaseURLPath
#define BaseServer2 @"http://c.m.163.com/nc/article/"

#define LoginURL    BaseURL "login.json"
#define AdvertURL   BaseURL "advert.json?width=%ld&height=%ld"
#define ColumnURL   BaseURL "column.json"
#define CategoryURL BaseURL "category.json"
#define NewsURLFmt  BaseURL "news_%@.json"
#define IconURLFmt  BaseURL "icons.json"
#define CategoryURLFmt  BaseURL "category_%@.json"
#define DetailURLFmt BaseServer2 "%@/full.html"

//
//  FxAppSetting.h
//  MyCos
//
//  Created by hejinbo on 14-4-29.
//  Copyright (c) 2014年 KingCloud. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FxAppSetting : NSObject

+ (NSString *)getValue:(NSString *)key;
+ (void)setValue:(id)value forKey:(NSString *)key;
+ (void)removeValue:(NSString *)key;


@end

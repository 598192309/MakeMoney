//
//  MangHuaItem.m
//  MakeMoney
//
//  Created by 黎芹 on 2020/8/18.
//  Copyright © 2020 lqq. All rights reserved.
//

#import "MangHuaItem.h"

@implementation MangHuaDetailItem
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"ID":@"id",
             @"Description":@"description"
             };
    
}
@end

@implementation MangHuaItem
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"NewLists":@"newLists"
             
    };
    
}
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"hotLists" :[MangHuaDetailItem class],
             @"NewLists" :[MangHuaDetailItem class],
             @"guessLists" :[MangHuaDetailItem class],
             };
}
@end

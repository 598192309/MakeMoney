//
//  HomeItem.m
//  MakeMoney
//
//  Created by rabi on 2020/2/26.
//  Copyright © 2020 lqq. All rights reserved.
//

#import "HomeItem.h"


@implementation GongGaoItem
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"ID":@"id"
             };
}

@end

@implementation AdsItem
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"ID":@"id"
             };
}

@end


@implementation HotItem
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"ID":@"id"
             };
}

@end


@implementation HomeInfoItem
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"most_new" :[HotItem class],
             @"most_play" :[HotItem class],
             @"most_love" :[HotItem class],
             @"ads" :[AdsItem class],
             @"video" :[HotItem class],

             };
}
@end

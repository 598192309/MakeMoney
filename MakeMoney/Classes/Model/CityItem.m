//
//  CityItem.m
//  MakeMoney
//
//  Created by rabi on 2020/2/26.
//  Copyright © 2020 lqq. All rights reserved.
//

#import "CityItem.h"

@implementation CityListItem
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"ID":@"id"
             };
}

@end

@implementation CityInfoItem
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"theNewLists" :[CityListItem class],
             @"hotLists" :[CityListItem class],
             @"upmarketLists" :[CityListItem class],
             };
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"theNewLists":@"newLists"
             };
}
@end

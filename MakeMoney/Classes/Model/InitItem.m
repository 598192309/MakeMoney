//
//  InitItem.m
//  MakeMoney
//
//  Created by rabi on 2020/2/26.
//  Copyright © 2020 lqq. All rights reserved.
//

#import "InitItem.h"

@implementation InitItem

@end

@implementation TabItem

@end
@implementation BasicItem

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"ID":@"id",
             @"New_user_free_hour":@"new_user_free_hour"

             };
}
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"bottomTabs" :[TabItem class]};
}

@end

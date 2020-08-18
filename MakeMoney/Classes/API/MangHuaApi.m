//
//  MangHuaApi.m
//  MakeMoney
//
//  Created by 黎芹 on 2020/8/18.
//  Copyright © 2020 lqq. All rights reserved.
//

#import "MangHuaApi.h"

@implementation MangHuaApi
/*******************漫画首页
 *********************/
+ (NetworkTask *)requestCartoonHomeDataSuccess:(void(^)(NSInteger status,NSString *msg,MangHuaItem *mangHuaItem))successBlock error:(ErrorBlock)errorBlock{
    return [NET POST:@"/api/cartoon/data" parameters:nil criticalValue:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
         NSInteger status = [[resultObject safeObjectForKey:@"status"] integerValue];
         NSString *msg = [resultObject safeObjectForKey:@"msg"];
        MangHuaItem *mangHuaItem = [MangHuaItem mj_objectWithKeyValues:[resultObject safeObjectForKey:@"data"]];

         if (successBlock) {
             successBlock(status,msg,mangHuaItem);
         }
     } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, id _Nonnull resultObject) {
         if (errorBlock) {
             errorBlock(error,resultObject);
         }
     }];
}
@end

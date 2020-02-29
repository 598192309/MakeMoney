//
//  InitApi.m
//  MakeMoney
//
//  Created by rabi on 2020/2/26.
//  Copyright © 2020 lqq. All rights reserved.
//

#import "InitApi.h"
#import "InitItem.h"
@implementation InitApi
/** 初始化   先请求Basic  再Init。 确保都请求成功 失败的话 推出app */

+ (NetworkTask *)requestBasicInfoSuccess:(void(^)(BasicItem *basicItem,NSString *msg))successBlock error:(ErrorBlock)errorBlock{
    
    return [NET POST:@"/api/basic" parameters:nil criticalValue:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        BasicItem *basicItem = [BasicItem mj_objectWithKeyValues:[resultObject safeObjectForKey:@"data"]];
        NSString *msg = [resultObject safeObjectForKey:@"msg"];
        if (successBlock) {
            successBlock(basicItem,msg);
        }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, id _Nonnull resultObject) {
        if (errorBlock) {
            errorBlock(error,resultObject);
        }
    }];
}

/** 初始化   先请求Basic  再Init。 确保都请求成功 失败的话 推出app */+ (NetworkTask *)initWithSyste:(NSString *)system  Success:(void(^)(InitItem *initItem,NSString *msg))successBlock error:(ErrorBlock)errorBlock{
    return [NET POST:@"/api/init" parameters:@{@"system":SAFE_NIL_STRING(system)} criticalValue:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        InitItem *initItem = [InitItem mj_objectWithKeyValues:[resultObject safeObjectForKey:@"data"]];
        NSString *msg = [resultObject safeObjectForKey:@"msg"];
        if (successBlock) {
            successBlock(initItem,msg);
        }


    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, id _Nonnull resultObject) {
        if (errorBlock) {
            errorBlock(error,resultObject);
        }
    }];
}
@end

//
//  ZhuanTiApi.m
//  MakeMoney
//
//  Created by rabi on 2020/2/26.
//  Copyright © 2020 lqq. All rights reserved.
//

#import "ZhuanTiApi.h"
#import "ZhuanTiItem.h"
@implementation ZhuanTiApi
/** z专题 首页  */

+ (NetworkTask *)requestZhuanTiHomeInfowithPageIndex:(NSString *)page_index page_size:(NSString *)page_size Success:(void(^)(NSArray *zhuanTiHomeItemArr,NSString *msg))successBlock error:(ErrorBlock)errorBlock{
    return [NET POST:@"/api/subject/find" parameters:@{@"page_index":SAFE_NIL_STRING(page_index),@"page_size" : SAFE_NIL_STRING(page_size)} criticalValue:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        NSArray *zhuanTiHomeItemArr = [ZhuanTiHomeItem mj_objectArrayWithKeyValuesArray:[resultObject safeObjectForKey:@"data"]];
        NSString *msg = [resultObject safeObjectForKey:@"msg"];
        if (successBlock) {
            successBlock(zhuanTiHomeItemArr,msg);
        }


    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, id _Nonnull resultObject) {
        if (errorBlock) {
            errorBlock(error,resultObject);
        }
    }];
}
@end

//
//  AblumApi.m
//  MakeMoney
//
//  Created by rabi on 2020/3/6.
//  Copyright © 2020 lqq. All rights reserved.
//

#import "AblumApi.h"
#import "AblumItem.h"
@implementation AblumApi
/*******************写真列表
 page_index
 page_size

 成功返回： (非VIP，imgs返回10条，VIP返回全集，自己拿集合分页加载)
 *********************/
+ (NetworkTask *)requestAblumWithPageIndex:(NSString *)page_index page_size:(NSString *)page_size Success:(void(^)(NSInteger status,NSString *msg,NSArray *ablumItemArr))successBlock error:(ErrorBlock)errorBlock{
    return [NET POST:@"/api/album/find" parameters:@{@"page_index":SAFE_NIL_STRING(page_index),@"page_size":SAFE_NIL_STRING(page_size)} criticalValue:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        NSInteger status = [[resultObject safeObjectForKey:@"status"] integerValue];
        NSString *msg = [resultObject safeObjectForKey:@"msg"];

        NSArray *ablumItemArr = [AblumItem mj_objectArrayWithKeyValuesArray:[resultObject safeObjectForKey:@"data"]];
        if (successBlock) {
            successBlock(status,msg,ablumItemArr);
        }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, id _Nonnull resultObject) {
        if (errorBlock) {
            errorBlock(error,resultObject);
        }
    }];
}

/*******************写真收藏和取消

 *********************/
+ (NetworkTask *)loveAblumWithAblumId:(NSString *)album_id Success:(void(^)(NSInteger status,NSString *msg))successBlock error:(ErrorBlock)errorBlock{
    return [NET POST:@"/api/album_love" parameters:@{@"album_id":SAFE_NIL_STRING(album_id)} criticalValue:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        NSInteger status = [[resultObject safeObjectForKey:@"status"] integerValue];
        NSString *msg = [resultObject safeObjectForKey:@"msg"];
        if (successBlock) {
            successBlock(status,msg);
        }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, id _Nonnull resultObject) {
        if (errorBlock) {
            errorBlock(error,resultObject);
        }
    }];
}


/*******************写真用金币购买

 *********************/
+ (NetworkTask *)buyAblumWithGoldWithAblumId:(NSString *)album_id gold:(NSString *)gold Success:(void(^)(NSInteger status,NSString *msg))successBlock error:(ErrorBlock)errorBlock{
    return [NET POST:@"/api/album/buy" parameters:@{@"album_id":SAFE_NIL_STRING(album_id),@"gold":SAFE_NIL_STRING(gold)} criticalValue:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        NSInteger status = [[resultObject safeObjectForKey:@"status"] integerValue];
        NSString *msg = [resultObject safeObjectForKey:@"msg"];
        if (successBlock) {
            successBlock(status,msg);
        }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, id _Nonnull resultObject) {
        if (errorBlock) {
            errorBlock(error,resultObject);
        }
    }];
}

@end

//
//  AVApi.m
//  MakeMoney
//
//  Created by rabi on 2020/2/26.
//  Copyright © 2020 lqq. All rights reserved.
//

#import "AVApi.h"
#import "HomeItem.h"
@implementation AVApi
/*******************AV页
 page_index
 page_size
 *********************/
+ (NetworkTask *)requestAVExtendwithPageIndex:(NSString *)page_index page_size:(NSString *)page_size  Success:(void(^)(NSArray *hotItemArr,NSString *msg))successBlock error:(ErrorBlock)errorBlock{
    return [NET POST:@"/api/av_video/new" parameters:@{@"page_index":SAFE_NIL_STRING(page_index),@"page_size":SAFE_NIL_STRING(page_size)} criticalValue:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        NSArray *hotItemArr = [HotItem mj_objectArrayWithKeyValuesArray:[resultObject safeObjectForKey:@"data"]];
        NSString *msg = [resultObject safeObjectForKey:@"msg"];
        if (successBlock) {
            successBlock(hotItemArr,msg);
        }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, id _Nonnull resultObject) {
        if (errorBlock) {
            errorBlock(error,resultObject);
        }
    }];
}


/*******************AV播放页推荐视频
 vId        视频id
 *********************/
+ (NetworkTask *)requestAVExtendwithID:(NSString *)ID  Success:(void(^)(NSArray *hotItemArr,NSString *msg))successBlock error:(ErrorBlock)errorBlock{
    return [NET POST:@"/api/av_video/tuijian" parameters:@{@"vId":SAFE_NIL_STRING(ID)} criticalValue:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        NSArray *hotItemArr = [HotItem mj_objectArrayWithKeyValuesArray:[resultObject safeObjectForKey:@"data"]];
        NSString *msg = [resultObject safeObjectForKey:@"msg"];
        if (successBlock) {
            successBlock(hotItemArr,msg);
        }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, id _Nonnull resultObject) {
        if (errorBlock) {
            errorBlock(error,resultObject);
        }
    }];
}


/********************短视频的收藏*********************/
+ (NetworkTask *)loveVedioWithVedioId:(NSString *)video_id Success:(void(^)(NSInteger status,NSString *msg))successBlock error:(ErrorBlock)errorBlock{
    return [NET POST:@"/api/love" parameters:@{@"video_id":SAFE_NIL_STRING(video_id)} criticalValue:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
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

/********************短视频的取消*********************/
+ (NetworkTask *)cancleLoveVedioWithVedioId:(NSString *)video_id Success:(void(^)(NSInteger status,NSString *msg))successBlock error:(ErrorBlock)errorBlock{
    return [NET POST:@"/api/clear" parameters:@{@"video_id":SAFE_NIL_STRING(video_id)} criticalValue:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
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
/********************AV的收藏 与取消 *********************/
+ (NetworkTask *)loveAVWithVedioId:(NSString *)video_id Success:(void(^)(NSInteger status,NSString *msg))successBlock error:(ErrorBlock)errorBlock{
    return [NET POST:@"/api/av_love" parameters:@{@"video_id":SAFE_NIL_STRING(video_id)} criticalValue:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
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

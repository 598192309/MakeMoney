//
//  AVApi.h
//  MakeMoney
//
//  Created by rabi on 2020/2/26.
//  Copyright © 2020 lqq. All rights reserved.
//

#import "BaseApi.h"

NS_ASSUME_NONNULL_BEGIN

@interface AVApi : BaseApi
/*******************AV页
 page_index
 page_size
 *********************/
+ (NetworkTask *)requestAVExtendwithPageIndex:(NSString *)page_index page_size:(NSString *)page_size  Success:(void(^)(NSArray *hotItemArr,NSString *msg))successBlock error:(ErrorBlock)errorBlock;


/*******************AV播放页推荐视频
 vId        视频id
 *********************/
+ (NetworkTask *)requestAVExtendwithID:(NSString *)ID  Success:(void(^)(NSArray *hotItemArr,NSString *msg))successBlock error:(ErrorBlock)errorBlock;

/********************短视频的收藏*********************/
+ (NetworkTask *)loveVedioWithVedioId:(NSString *)video_id Success:(void(^)(NSInteger status,NSString *msg))successBlock error:(ErrorBlock)errorBlock;

/********************短视频的取消*********************/
+ (NetworkTask *)cancleLoveVedioWithVedioId:(NSString *)video_id Success:(void(^)(NSInteger status,NSString *msg))successBlock error:(ErrorBlock)errorBlock;

/********************AV的收藏*********************/
+ (NetworkTask *)loveAVWithVedioId:(NSString *)video_id Success:(void(^)(NSInteger status,NSString *msg))successBlock error:(ErrorBlock)errorBlock;


@end

NS_ASSUME_NONNULL_END

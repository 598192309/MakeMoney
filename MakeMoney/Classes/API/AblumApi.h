//
//  AblumApi.h
//  MakeMoney
//
//  Created by rabi on 2020/3/6.
//  Copyright © 2020 lqq. All rights reserved.
//

#import "BaseApi.h"

NS_ASSUME_NONNULL_BEGIN

@interface AblumApi : BaseApi
/*******************写真列表
 page_index
 page_size

 成功返回： (非VIP，imgs返回10条，VIP返回全集，自己拿集合分页加载)
 *********************/
+ (NetworkTask *)requestAblumWithPageIndex:(NSString *)page_index page_size:(NSString *)page_size Success:(void(^)(NSInteger status,NSString *msg,NSArray *ablumItemArr))successBlock error:(ErrorBlock)errorBlock;

/*******************写真收藏和取消

 *********************/
+ (NetworkTask *)loveAblumWithAblumId:(NSString *)album_id Success:(void(^)(NSInteger status,NSString *msg))successBlock error:(ErrorBlock)errorBlock;


@end

NS_ASSUME_NONNULL_END

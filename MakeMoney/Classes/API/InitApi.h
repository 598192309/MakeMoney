//
//  InitApi.h
//  MakeMoney
//
//  Created by rabi on 2020/2/26.
//  Copyright © 2020 lqq. All rights reserved.
//

#import "BaseApi.h"

NS_ASSUME_NONNULL_BEGIN
@class InitItem,BasicItem;
@interface InitApi : BaseApi

/** 初始化   先请求Basic  再Init。 确保都请求成功 失败的话 推出app */

+ (NetworkTask *)requestBasicInfoSuccess:(void(^)(BasicItem *basicItem,NSString *msg))successBlock error:(ErrorBlock)errorBlock;

/** 初始化   先请求Basic  再Init。 确保都请求成功 失败的话 推出app */

+ (NetworkTask *)initWithosversion:(NSString *)os_version app_version:(NSString *)app_version lat:(NSString *)lat lang:(NSString *)lang   Success:(void(^)(InitItem *initItem,NSString *msg))successBlock error:(ErrorBlock)errorBlock;
@end

NS_ASSUME_NONNULL_END

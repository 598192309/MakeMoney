//
//  ZhuanTiApi.h
//  MakeMoney
//
//  Created by rabi on 2020/2/26.
//  Copyright © 2020 lqq. All rights reserved.
//

#import "BaseApi.h"
@class ZhuanTiHomeItem;

NS_ASSUME_NONNULL_BEGIN

@interface ZhuanTiApi : BaseApi
/** z专题 首页  */

+ (NetworkTask *)requestZhuanTiHomeInfowithPageIndex:(NSString *)page_index page_size:(NSString *)page_size Success:(void(^)(NSArray *zhuanTiHomeItemArr,NSString *msg))successBlock error:(ErrorBlock)errorBlock;
@end

NS_ASSUME_NONNULL_END

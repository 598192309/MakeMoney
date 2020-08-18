//
//  MangHuaApi.h
//  MakeMoney
//
//  Created by 黎芹 on 2020/8/18.
//  Copyright © 2020 lqq. All rights reserved.
//

#import "BaseApi.h"
#import "MangHuaItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface MangHuaApi : BaseApi
/*******************漫画首页
 *********************/
+ (NetworkTask *)requestCartoonHomeDataSuccess:(void(^)(NSInteger status,NSString *msg,MangHuaItem *mangHuaItem))successBlock error:(ErrorBlock)errorBlock;
@end

NS_ASSUME_NONNULL_END

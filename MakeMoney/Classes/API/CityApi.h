//
//  CityApi.h
//  MakeMoney
//
//  Created by rabi on 2020/2/26.
//  Copyright © 2020 lqq. All rights reserved.
//

#import "BaseApi.h"

NS_ASSUME_NONNULL_BEGIN
@class CityInfoItem;
@interface CityApi : BaseApi
/*******************同城首页

 *********************/
+ (NetworkTask *)requestCityInfoSuccess:(void(^)(CityInfoItem *cityInfoItem,NSString *msg))successBlock error:(ErrorBlock)errorBlock;


/*******************同城列表
 region_id       分类id
 page_index
 page_size
 *********************/
+ (NetworkTask *)requestCityListwithRegionId:(NSString *)region_id pageIndex:(NSString *)page_index page_size:(NSString *)page_size Success:(void(^)(NSArray *cityItemArr,NSString *msg))successBlock error:(ErrorBlock)errorBlock;
@end

NS_ASSUME_NONNULL_END

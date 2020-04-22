//
//  CityApi.h
//  MakeMoney
//
//  Created by rabi on 2020/2/26.
//  Copyright © 2020 lqq. All rights reserved.
//

#import "BaseApi.h"

NS_ASSUME_NONNULL_BEGIN
@class CityInfoItem,CityListItem;
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

/*******************同城详情
 
 *********************/
+ (NetworkTask *)requestCityDetailwithId:(NSString *)Id pageIndex:(NSString *)page_index page_size:(NSString *)page_size Success:(void(^)(CityListItem *cityItem,NSString *msg))successBlock error:(ErrorBlock)errorBlock;


/*******************同城列表  qm分类里 点击查询 获取的查询列表
 
 *********************/
+ (NetworkTask *)requestCityListQMSearchListSuccess:(void(^)(NSArray *cityItemArr,NSString *msg))successBlock error:(ErrorBlock)errorBlock;
/*******************同城列表  高端分类 点击查询 获取的查询列表
 
 *********************/
+ (NetworkTask *)requestCityListHighSearchListSuccess:(void(^)(NSArray *cityItemArr,NSString *msg))successBlock error:(ErrorBlock)errorBlock;

/*******************同城列表  qm 和最新分类 列表页
 type         0-最新 1 qm
 page_index
 page_size
 *********************/
+ (NetworkTask *)requestQMNewCityListWithType:(NSString *)type pageIndex:(NSString *)page_index page_size:(NSString *)page_size Success:(void(^)(NSArray *cityItemArr,NSString *msg))successBlock error:(ErrorBlock)errorBlock;
/*******************同城列表  高端
 region_id       分类id //100.全部
 page_index
 page_size
 *********************/
+ (NetworkTask *)requestQMNewCityListWithRegionID:(NSString *)region_id pageIndex:(NSString *)page_index page_size:(NSString *)page_size Success:(void(^)(NSArray *cityItemArr,NSString *msg))successBlock error:(ErrorBlock)errorBlock;


/*******************同城列表  按地区查QM
 region_id           0.全部
 page_index
 page_size
 *********************/
+ (NetworkTask *)requestQMCityListWithRegionID:(NSString *)region_id pageIndex:(NSString *)page_index page_size:(NSString *)page_size Success:(void(^)(NSArray *cityItemArr,NSString *msg))successBlock error:(ErrorBlock)errorBlock;
@end

NS_ASSUME_NONNULL_END

//
//  CityApi.m
//  MakeMoney
//
//  Created by rabi on 2020/2/26.
//  Copyright © 2020 lqq. All rights reserved.
//

#import "CityApi.h"
#import "CityItem.h"
@implementation CityApi

/*******************同城首页

 *********************/
+ (NetworkTask *)requestCityInfoSuccess:(void(^)(CityInfoItem *cityInfoItem,NSString *msg))successBlock error:(ErrorBlock)errorBlock{
    return [NET POST:@"/api/qm_home/find" parameters:nil criticalValue:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        CityInfoItem *cityInfoItem = [CityInfoItem mj_objectWithKeyValues:[resultObject safeObjectForKey:@"data"]];
        NSString *msg = [resultObject safeObjectForKey:@"msg"];
        if (successBlock) {
            successBlock(cityInfoItem,msg);
        }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, id _Nonnull resultObject) {
        if (errorBlock) {
            errorBlock(error,resultObject);
        }
    }];
}
/*******************同城列表
 region_id       分类id
 page_index
 page_size
 *********************/
+ (NetworkTask *)requestCityListwithRegionId:(NSString *)region_id pageIndex:(NSString *)page_index page_size:(NSString *)page_size Success:(void(^)(NSArray *cityItemArr,NSString *msg))successBlock error:(ErrorBlock)errorBlock{
    return [NET POST:@"/api/qm/find" parameters:@{@"region_id":SAFE_NIL_STRING(region_id),@"page_index":SAFE_NIL_STRING(page_index),@"page_size":SAFE_NIL_STRING(page_size)} criticalValue:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        NSArray *cityItemArr = [CityListItem mj_objectArrayWithKeyValuesArray:[resultObject safeObjectForKey:@"data"]];
        NSString *msg = [resultObject safeObjectForKey:@"msg"];
        if (successBlock) {
            successBlock(cityItemArr,msg);
        }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, id _Nonnull resultObject) {
        if (errorBlock) {
            errorBlock(error,resultObject);
        }
    }];
}



/*******************同城详情
 
 *********************/
+ (NetworkTask *)requestCityDetailwithId:(NSString *)Id pageIndex:(NSString *)page_index page_size:(NSString *)page_size Success:(void(^)(CityListItem *cityItem,NSString *msg))successBlock error:(ErrorBlock)errorBlock{
    return [NET POST:@"/api/qm/find" parameters:@{@"id":SAFE_NIL_STRING(Id)} criticalValue:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        CityListItem *cityItem = [CityListItem mj_objectWithKeyValues:[resultObject safeObjectForKey:@"data"]];
        NSString *msg = [resultObject safeObjectForKey:@"msg"];
        if (successBlock) {
            successBlock(cityItem,msg);
        }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, id _Nonnull resultObject) {
        if (errorBlock) {
            errorBlock(error,resultObject);
        }
    }];
}

/*******************同城列表  qm分类查询列表

 *********************/
+ (NetworkTask *)requestCityListQMSearchListSuccess:(void(^)(NSArray *cityItemArr,NSString *msg))successBlock error:(ErrorBlock)errorBlock{
    return [NET POST:@"/api/qm/region" parameters:nil criticalValue:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        NSArray *cityItemArr = [CityListItem mj_objectArrayWithKeyValuesArray:[resultObject safeObjectForKey:@"data"]];
        NSString *msg = [resultObject safeObjectForKey:@"msg"];
        if (successBlock) {
            successBlock(cityItemArr,msg);
        }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, id _Nonnull resultObject) {
        if (errorBlock) {
            errorBlock(error,resultObject);
        }
    }];
}
/*******************同城列表  高端分类查询列表

 *********************/
+ (NetworkTask *)requestCityListHighSearchListSuccess:(void(^)(NSArray *cityItemArr,NSString *msg))successBlock error:(ErrorBlock)errorBlock{
    return [NET POST:@"/api/highend/region" parameters:nil criticalValue:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        NSArray *cityItemArr = [CityListItem mj_objectArrayWithKeyValuesArray:[resultObject safeObjectForKey:@"data"]];
        NSString *msg = [resultObject safeObjectForKey:@"msg"];
        if (successBlock) {
            successBlock(cityItemArr,msg);
        }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, id _Nonnull resultObject) {
        if (errorBlock) {
            errorBlock(error,resultObject);
        }
    }];
}

/*******************同城列表  qm 和最新分类 列表页
 type         0-最新 1 qm
 page_index
 page_size
 *********************/
+ (NetworkTask *)requestQMNewCityListWithType:(NSString *)type pageIndex:(NSString *)page_index page_size:(NSString *)page_size Success:(void(^)(NSArray *cityItemArr,NSString *msg))successBlock error:(ErrorBlock)errorBlock{
    return [NET POST:@"/api/qm/find" parameters:@{@"type":SAFE_NIL_STRING(type),@"page_index":SAFE_NIL_STRING(page_index),@"page_size":SAFE_NIL_STRING(page_size)} criticalValue:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        NSArray *cityItemArr = [CityListItem mj_objectArrayWithKeyValuesArray:[resultObject safeObjectForKey:@"data"]];
        NSString *msg = [resultObject safeObjectForKey:@"msg"];
        if (successBlock) {
            successBlock(cityItemArr,msg);
        }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, id _Nonnull resultObject) {
        if (errorBlock) {
            errorBlock(error,resultObject);
        }
    }];
}
/*******************同城列表  高端
 region_id       分类id //100.全部
 page_index
 page_size
 *********************/
+ (NetworkTask *)requestQMNewCityListWithRegionID:(NSString *)region_id pageIndex:(NSString *)page_index page_size:(NSString *)page_size  Success:(void(^)(NSArray *cityItemArr,NSString *msg))successBlock error:(ErrorBlock)errorBlock{
    return [NET POST:@"/api/highend_region_id/find" parameters:@{@"region_id":SAFE_NIL_STRING(region_id ),@"page_index":SAFE_NIL_STRING(page_index),@"page_size":SAFE_NIL_STRING(page_size)} criticalValue:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        NSArray *cityItemArr = [CityListItem mj_objectArrayWithKeyValuesArray:[resultObject safeObjectForKey:@"data"]];
        NSString *msg = [resultObject safeObjectForKey:@"msg"];
        if (successBlock) {
            successBlock(cityItemArr,msg);
        }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, id _Nonnull resultObject) {
        if (errorBlock) {
            errorBlock(error,resultObject);
        }
    }];
}

/*******************同城列表  按地区查QM
 region_id           0.全部
 page_index
 page_size
 *********************/
+ (NetworkTask *)requestQMCityListWithRegionID:(NSString *)region_id pageIndex:(NSString *)page_index page_size:(NSString *)page_size Success:(void(^)(NSArray *cityItemArr,NSString *msg))successBlock error:(ErrorBlock)errorBlock{
    return [NET POST:@"/api/qm_region_id/find" parameters:@{@"region_id":SAFE_NIL_STRING(region_id ),@"page_index":SAFE_NIL_STRING(page_index),@"page_size":SAFE_NIL_STRING(page_size)} criticalValue:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        NSArray *cityItemArr = [CityListItem mj_objectArrayWithKeyValuesArray:[resultObject safeObjectForKey:@"data"]];
        NSString *msg = [resultObject safeObjectForKey:@"msg"];
        if (successBlock) {
            successBlock(cityItemArr,msg);
        }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, id _Nonnull resultObject) {
        if (errorBlock) {
            errorBlock(error,resultObject);
        }
    }];
}
@end

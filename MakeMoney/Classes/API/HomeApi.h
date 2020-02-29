//
//  HomeApi.h
//  MakeMoney
//
//  Created by rabi on 2020/2/26.
//  Copyright © 2020 lqq. All rights reserved.
//

#import "BaseApi.h"

NS_ASSUME_NONNULL_BEGIN
@class GongGaoItem,HomeInfoItem;
@interface HomeApi : BaseApi
/******************热门页视频列表  就是首页

 *********************/
+ (NetworkTask *)requestHotListSuccess:(void(^)(HomeInfoItem * homeInfoItem,NSString *msg))successBlock error:(ErrorBlock)errorBlock;


/********************公告*********************/
+ (NetworkTask *)requestGongGaoSuccess:(void(^)(GongGaoItem *gongGaoItem,NSString *msg))successBlock error:(ErrorBlock)errorBlock;

/********************广告
 type：
  
 0;   //热门页banner
 1;    //同城banner
 2;  //短视频列表
 3;  //av列表
 4;  //av详情页
 5;  //同城底部
 6;   //同城详情
 7;   //热门页列表
 8;  //video详情播放
 9;  //av详情播放
 100;   //启动页
 
 *********************/
+ (NetworkTask *)requestAdWithType:(NSString *)type Success:(void(^)(NSArray *adsItemArr,NSString *msg))successBlock error:(ErrorBlock)errorBlock;


/*******************分类视频列表
 type_id        热门页全部分类 获取的tag
 page_index
 page_size
 *********************/
+ (NetworkTask *)requestHotCategoryListwithType_id:(NSString *)type_id pageIndex:(NSString *)page_index page_size:(NSString *)page_size Success:(void(^)(NSArray *hotItemArr,NSString *msg))successBlock error:(ErrorBlock)errorBlock;


/*******************热门视频列表更多
 tag        默认传 0           热门页视频列表 获取
 text       默认传 51778       热门页视频列表 获取
 type       0 短视频   1 AV    热门页视频列表 获取
 page_index
 page_size
 *********************/
+ (NetworkTask *)requestHotListMorewithTag:(NSString *)tag text:(NSString *)text type:(NSString *)type pageIndex:(NSString *)page_index page_size:(NSString *)page_size Success:(void(^)(NSArray *hotItemArr,NSString *msg))successBlock error:(ErrorBlock)errorBlock;


/*******************热门页全部分类
 {
     "create_time": 1582362067,
     "id": 1,
     "img": "",
     "sort": 1,
     "status": 0,
     "tag": 1,
     "text": "",
     "title": "成人自拍",
     "type": 0
 }
 *********************/
+ (NetworkTask *)requestAllHotListwithPageIndex:(NSString *)page_index page_size:(NSString *)page_size Success:(void(^)(NSArray *hotItemArr,NSString *msg))successBlock error:(ErrorBlock)errorBlock;


/*******************人气榜详情列表
 video_type     1001 最新视频    1002 最多播放     1003 最多点赞
 page_index
 page_size
 *********************/
+ (NetworkTask *)requestPopularityListwithVideoType:(NSString *)video_type pageIndex:(NSString *)page_index page_size:(NSString *)page_size Success:(void(^)(NSArray *hotItemArr,NSString *msg))successBlock error:(ErrorBlock)errorBlock;


/*******************下载图片
 video_type: 是拼接在后的host 有v_imgs a_imgs
 *********************/
+ (NetworkTask *)downImageWithType:(NSString *)video_type paramTitle:(NSString *)paramTitle ID:(NSString *)ID Success:(void(^)(NSString *img))successBlock error:(ErrorBlock)errorBlock;
@end

NS_ASSUME_NONNULL_END

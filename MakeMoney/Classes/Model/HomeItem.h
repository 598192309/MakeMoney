//
//  HomeItem.h
//  MakeMoney
//
//  Created by rabi on 2020/2/26.
//  Copyright © 2020 lqq. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//typedef NS_ENUM(NSInteger, AdType) {
//    AdType_HotBanner = 0,//热点页banner
//    AdType_QM = 1,//同城Banner
//    AdType_SVList=2,//短视频列表
//    AdType_AVList=3,//AV列表
//    AdType_AVDetail=4,//AV详情页
//    AdType_QMBottom=5,//同城底部
//    AdType_QMDetail=6,//
//};

typedef NS_ENUM(NSInteger,AdTag) {
    AdTag_Defult,//默认
    AdTag_Safari = 1,//跳转URL
    AdTag_AVDetailVC=2,//跳转AV详情页
    AdTag_QMDetailVC=3,//跳转同城详情页
};



/**公告 */
@interface GongGaoItem : NSObject
@property (nonatomic,strong)NSString *btn;
@property (nonatomic,strong)NSString *content;
@property (nonatomic,strong)NSString *create_time;
@property (nonatomic,strong)NSString *ID;
@property (nonatomic,assign)NSInteger status;
@property (nonatomic,strong)NSString *title;
@property (nonatomic,assign)NSInteger type;
@property (nonatomic,strong)NSString *img;
@property (nonatomic,strong)NSString *url;

@end


/**热门视频 */
@interface HotItem : NSObject
@property (nonatomic,strong)NSString *fan_hao;
@property (nonatomic,strong)NSString *create_time;
@property (nonatomic,assign)NSInteger free_day;
@property (nonatomic,strong)NSString *ID;
@property (nonatomic,strong)NSString *img_url;
@property (nonatomic,strong)NSString *love;
@property (nonatomic,strong)NSString *play;
@property (nonatomic,strong)NSString *price;

@property (nonatomic,assign)NSInteger status;
@property (nonatomic,assign)NSInteger tag;
@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong)NSString *total_time;

@property (nonatomic,assign)NSInteger v_channel;
@property (nonatomic,strong)NSString *video_tag;
@property (nonatomic,strong)NSString *video_url;
@property (nonatomic,strong)NSString *vip_video_url;

//热门页全部分类
@property (nonatomic,strong)NSString *sort;
@property (nonatomic,strong)NSString *text;

@end
/**广告 */
@interface AdsItem : NSObject
@property (nonatomic,strong)NSString *av_url;
@property (nonatomic,strong)NSString *create_time;
@property (nonatomic,strong)NSString *desc;
@property (nonatomic,strong)NSString *end_time;
@property (nonatomic,strong)NSString *ID;
@property (nonatomic,strong)NSString *img;
@property (nonatomic,strong)NSString *qm_id;
@property (nonatomic,assign)NSInteger status;
@property (nonatomic,assign)AdTag tag;
@property (nonatomic,assign)NSInteger time;
@property (nonatomic,strong)NSString *title;
@property (nonatomic,assign)NSInteger type;
@property (nonatomic,strong)NSString *url;
@property (nonatomic, assign) int width;
@property (nonatomic, assign) int height;

@end



//视频类型
typedef NS_ENUM(NSInteger, VideoType) {
    VideoType_ShortVideo,//短视频
    VideoType_AV,//AV
};

@interface HomeVideoList : NSObject
@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)NSString *text;

@property (nonatomic, assign) int tag;
@property (nonatomic, assign) VideoType type;
@property (nonatomic, copy) NSArray<HotItem *> *lists;
@end


/********************首页 *********************/
@interface HomeInfoItem : NSObject
@property (nonatomic,strong)NSArray<HotItem *> *most_new;
@property (nonatomic,strong)NSArray<HotItem *> *most_play;
@property (nonatomic,strong)NSArray<HotItem *> *most_love;
@property (nonatomic,strong)NSArray<AdsItem *> *ads;
@property (nonatomic,strong)NSArray<HomeVideoList *> *video;

@end

NS_ASSUME_NONNULL_END

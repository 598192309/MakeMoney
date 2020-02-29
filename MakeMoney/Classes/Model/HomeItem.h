//
//  HomeItem.h
//  MakeMoney
//
//  Created by rabi on 2020/2/26.
//  Copyright © 2020 lqq. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN



/**公告 */
@interface GongGaoItem : NSObject
@property (nonatomic,strong)NSString *btn;
@property (nonatomic,strong)NSString *content;
@property (nonatomic,strong)NSString *create_time;
@property (nonatomic,strong)NSString *ID;
@property (nonatomic,assign)NSInteger status;
@property (nonatomic,strong)NSString *title;
@property (nonatomic,assign)NSInteger type;
@end


/**广告 */
@interface AdsItem : NSObject
@property (nonatomic,strong)NSString *av_url;
@property (nonatomic,strong)NSString *create_time;
@property (nonatomic,strong)NSString *end_time;
@property (nonatomic,strong)NSString *ID;
@property (nonatomic,strong)NSString *img;
@property (nonatomic,assign)NSInteger qm_id;
@property (nonatomic,assign)NSInteger status;
@property (nonatomic,assign)NSInteger tag;
@property (nonatomic,assign)NSInteger time;
@property (nonatomic,strong)NSString *title;
@property (nonatomic,assign)NSInteger type;
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


/********************首页 *********************/
@interface HomeInfoItem : NSObject
@property (nonatomic,strong)NSArray *most_new;
@property (nonatomic,strong)NSArray *most_play;
@property (nonatomic,strong)NSArray *most_love;
@property (nonatomic,strong)NSArray *video;

@end

NS_ASSUME_NONNULL_END

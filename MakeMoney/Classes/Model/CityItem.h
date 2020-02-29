//
//  CityItem.h
//  MakeMoney
//
//  Created by rabi on 2020/2/26.
//  Copyright © 2020 lqq. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**同城 列表 */
@interface CityListItem : NSObject
@property (nonatomic,strong)NSString *address;
@property (nonatomic,strong)NSString *click;
@property (nonatomic,strong)NSString *cover;
@property (nonatomic,strong)NSString *create_time;
@property (nonatomic,strong)NSString *end_time;
@property (nonatomic,strong)NSString *ID;
@property (nonatomic,strong)NSString *img1;
@property (nonatomic,strong)NSString *img2;
@property (nonatomic,strong)NSString *img3;
@property (nonatomic,strong)NSString *img4;
@property (nonatomic,strong)NSString *img5;
@property (nonatomic,assign)NSInteger is_vip;
@property (nonatomic,strong)NSString *mobile;
@property (nonatomic,strong)NSString *qq;
@property (nonatomic,strong)NSString *region_id;
@property (nonatomic,strong)NSString *reply;
@property (nonatomic,assign)NSInteger status;
@property (nonatomic,strong)NSString *text;
@property (nonatomic,strong)NSString *title;
@property (nonatomic,assign)NSInteger type;
@property (nonatomic,strong)NSString *video;
@property (nonatomic,strong)NSString *wechat;


@end


/********************同城 首页 *********************/
@interface CityInfoItem : NSObject
@property (nonatomic,strong)NSArray *theNewLists;
@property (nonatomic,strong)NSArray *hotLists;
@property (nonatomic,strong)NSArray *upmarketLists;

@end

NS_ASSUME_NONNULL_END

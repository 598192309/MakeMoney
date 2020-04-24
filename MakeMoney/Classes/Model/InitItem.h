//
//  InitItem.h
//  MakeMoney
//
//  Created by rabi on 2020/2/26.
//  Copyright © 2020 lqq. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface InitItem : NSObject
@property (nonatomic,assign)NSInteger is_safe_code;
@property (nonatomic,assign)NSInteger is_vip;//视频
@property (nonatomic,assign)NSInteger is_qm_vip;//同城
@property (nonatomic,assign)NSInteger is_album_vip;//写真

@property (nonatomic,strong)NSString *mobile;
@property (nonatomic,strong)NSString *avatar;
@property (nonatomic,strong)NSString *sex_id;
@property (nonatomic,strong)NSString *vip_end_time;
@property (nonatomic,strong)NSString *qm_vip_end_time;
@property (nonatomic,strong)NSString *album_vip_end_time;


@property (nonatomic,strong)NSString *user_id;
@property (nonatomic,assign)NSInteger is_new_user;
@property (nonatomic,assign)NSInteger rest_free_times;
@property (nonatomic,strong)NSString *invite_code;

@property (nonatomic,assign)NSInteger vip_level;
@property (nonatomic,assign)NSInteger is_login;
@property (nonatomic,assign)NSInteger status;
@property (nonatomic,assign)NSInteger max_free_times;
@property (nonatomic,strong)NSString *username;
@property (nonatomic,assign)NSInteger new_user_free_day;

@property (nonatomic,assign)NSInteger new_user_free_hour;
@property (nonatomic,assign)NSInteger sign_in;

@end


@interface BasicItem : NSObject
@property (nonatomic,strong)NSString *av_video_url;
@property (nonatomic,strong)NSString *contact;
@property (nonatomic,strong)NSString *email;
@property (nonatomic,strong)NSString *ID;
@property (nonatomic,strong)NSString *img_url;

@property (nonatomic,assign)NSInteger is_code;
@property (nonatomic,strong)NSString *share_text;
@property (nonatomic,strong)NSString *share_url;
@property (nonatomic,assign)NSInteger video_free_times;
@property (nonatomic,strong)NSString *video_url;
@property (nonatomic,assign)NSInteger vip_day;
@property (nonatomic,strong)NSString *vip_video_url;

@property (nonatomic,strong)NSString *potato_name;
@property (nonatomic,strong)NSString *potato_url;
@property (nonatomic,strong)NSString *album_url;

@end
NS_ASSUME_NONNULL_END

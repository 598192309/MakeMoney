//
//  RunInfo.h
//  stock
//
//  Created by Jaykon on 14-2-9.
//  Copyright (c) 2014年 Maxicn. All rights reserved.
//
#import <CoreLocation/CoreLocation.h>
#import "InitItem.h"

#define RI ([RunInfo sharedInstance])
@class CommonUserInfoItem;
extern NSString* const STAPPErrorDomain;
@interface RunInfo : NSObject



@property(nonatomic,assign)BOOL is_logined;//是否登录 以这个为标准判断 不以上面判断


@property (nonatomic,strong)BasicItem *basicItem;
@property (nonatomic,strong)NSString *basicItemJasonStr;//不能保存item 转json保存

@property (nonatomic,strong)InitItem *infoInitItem;
@property (nonatomic,strong)NSString *yaoqingren_code;
//@property (nonatomic,strong)NSString *shallinstallCode;//从shallinstall sdk 回调的邀请码 

@property (nonatomic,strong)NSString *infoInitItemJasonStr;//不能保存item 转json保存

@property (nonatomic,strong)NSString *tradeNo;//支付订单

+ (RunInfo *)sharedInstance;
//检测是否需要自动登录
- (void)checkLogin;
//登录
- (void)loginWithMobile:(NSString *)mobile pwd:(NSString *)pwd;
//退出
- (void)loginOut;

//跟新用户信息
- (void)updateUserInfo;


@end

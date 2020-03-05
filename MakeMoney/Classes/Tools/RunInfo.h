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
//@property (nonatomic,strong)NSString *authorization;//在客户端第一次被打开的时候，需要主动获取JWT的Token信息。获取成功后，将返回的JWT保存到本地，之后每次请求都需要在Request的Header上添加验证信息。在服务器上Response的Header，每次都会返回JWT信息，因为这个JWT信息在一定时间会有变化，所以，客户端每次手动Response的时候，都应该拿来与本地的JWT比较一下，如果存在不同，则需要更新本地的JWT。

//@property(nonatomic,assign)BOOL is_shiming;//是否实名
//
//@property (strong,nonatomic  ) NSString *mobile;//手机号
//@property (strong,nonatomic  )NSString * real_name;//
//@property (strong,nonatomic  )NSString * sex;//性别
//@property (strong,nonatomic  )NSString * nick_name;//昵称
//@property (strong,nonatomic  )NSString * version;// 版本号

@property (nonatomic,strong)BasicItem *basicItem;
@property (nonatomic,strong)NSString *basicItemJasonStr;//不能保存item 转json保存

@property (nonatomic,strong)InitItem *infoInitItem;
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

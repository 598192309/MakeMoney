//
//  MineApi.h
//  MakeMoney
//
//  Created by rabi on 2020/2/26.
//  Copyright © 2020 lqq. All rights reserved.
//

#import "BaseApi.h"

NS_ASSUME_NONNULL_BEGIN
@class UpdateItem,InitItem,ExtendDetailItem,PayDetailItem;
@interface MineApi : BaseApi
/**版本升级 */
+ (NetworkTask *)updateSuccess:(void(^)(UpdateItem *updateItem,NSString *msg))successBlock error:(ErrorBlock)errorBlock;


/********************充值记录 *********************/
+ (NetworkTask *)requestPayRecordswithPageIndex:(NSString *)page_index page_size:(NSString *)page_size Success:(void(^)(NSArray *payRecordItemArr,NSString *msg))successBlock error:(ErrorBlock)errorBlock;


/********************充值中心 *********************/
+ (NetworkTask *)requestPayCenterInfoSuccess:(void(^)(NSArray *payCenterInfotemArr,NSString *msg))successBlock error:(ErrorBlock)errorBlock;





/********************更新短视频的播放次数*********************/
+ (NetworkTask *)requestShortVedioInfoWithVedioId:(NSString *)video_id is_vip:(NSInteger)is_vip type:(NSInteger)type Success:(void(^)(InitItem *initItem,NSString *msg))successBlock error:(ErrorBlock)errorBlock;


/********************更新AV的播放次数*********************/
+ (NetworkTask *)requestAVInfoWithVedioId:(NSString *)video_id  Success:(void(^)(InitItem *initItem,NSString *msg))successBlock error:(ErrorBlock)errorBlock;

/*******************获取余额*********************/
+ (NetworkTask *)requestBalanceSuccess:(void(^)(NSInteger status,NSString *msg))successBlock error:(ErrorBlock)errorBlock;

/*******************推广明细*********************/
+ (NetworkTask *)requestExtendDetailwithVideoInviteCode:(NSString *)invite_code pageIndex:(NSString *)page_index page_size:(NSString *)page_size Success:(void(^)(NSArray *extendArr,NSString *msg))successBlock error:(ErrorBlock)errorBlock;

/*******************推广赚钱*********************/
+ (NetworkTask *)requestExtendIncomeSuccess:(void(^)(ExtendDetailItem *extendDetailItem,NSString *msg))successBlock error:(ErrorBlock)errorBlock;


/*******************卡密兑换
 card_pwd
 sex_id
 invite_code
 
 *********************/
+ (NetworkTask *)buyVipWithCard_pwd:(NSString *)card_pwd sex_id:(NSString *)sex_id invite_code:(NSString *)invite_code Success:(void(^)(NSInteger status,NSString *msg))successBlock error:(ErrorBlock)errorBlock;


/*******************卡密兑换2  自动兑换 跟在订单查询后 请求
 card_pwd
 sex_id
 invite_code
 
 *********************/
+ (NetworkTask *)autobuyVipWithCard_pwd:(NSString *)card_pwd sex_id:(NSString *)sex_id invite_code:(NSString *)invite_code Success:(void(^)(NSInteger status,NSString *msg))successBlock error:(ErrorBlock)errorBlock;


/*******************提现
 type   1银行卡   2.支付宝    3.微信  暂时只支持银行卡
 rate   手续费
 account
 bankcard
 money
 safe_code    安全码
 
 *********************/
+ (NetworkTask *)cashWithType:(NSString *)type rate:(NSString *)rate account:(NSString *)account bankcard:(NSString *)bankcard money:(NSString *)money safe_code:(NSString *)safe_code Success:(void(^)(NSInteger status,NSString *msg))successBlock error:(ErrorBlock)errorBlock;

/*******************获取支付方式
 
 *********************/
+ (NetworkTask *)requestPayWaysSuccess:(void(^)(NSInteger status,NSString *msg,NSArray *payWayItemArr))successBlock error:(ErrorBlock)errorBlock;

/*******************获取提现明细
 
 *********************/
+ (NetworkTask *)requestCashDetailwithPageIndex:(NSString *)page_index page_size:(NSString *)page_size Success:(void(^)(NSInteger status,NSString *msg,NSArray *tixianDetailItemArr))successBlock error:(ErrorBlock)errorBlock;


/*******************获取邀请记录
 
 *********************/
+ (NetworkTask *)requestShareRecordsWithInviteCode:(NSString *)invite_code  Success:(void(^)(NSInteger status,NSString *msg,NSArray *extendDetailItemArr))successBlock error:(ErrorBlock)errorBlock;


/*******************用户信息
 
 *********************/
+ (NetworkTask *)requestUserInfoSuccess:(void(^)(NSInteger status,NSString *msg,InitItem *initItem))successBlock error:(ErrorBlock)errorBlock;


/*******************请求支付
 channel_id      渠道号
 goods_id        商品id     支付列表返回
 sex_id          用户ID
 pay_type       支付类型
 
 type 1     跳转到webview加载 data
 Type  3或4    跳转到新的扫码支付界面
 *********************/
+ (NetworkTask *)goPayWithInviteChannelId:(NSString *)channel_id goods_id:(NSString *)goods_id sex_id:(NSString *)sex_id pay_type:(NSString *)pay_type  Success:(void(^)(NSInteger status,NSString *msg,PayDetailItem *payDetailItem))successBlock error:(ErrorBlock)errorBlock;


/*******************订单查询 查询支付结果 返回卡密
 
 *********************/
+ (NetworkTask *)requestPayResultWithTradeNo:(NSString *)trade_no Success:(void(^)(NSInteger status,NSString *msg,NSString *secret))successBlock error:(ErrorBlock)errorBlock;

/*******************添加邀请码
 sex_id
 invite_code      被邀请人的
 invite_code2     自己的
 *********************/
+ (NetworkTask *)requestPayResultWithsexID:(NSString *)sex_id invite_code:(NSString *)invite_code invite_code2:(NSString *)invite_code2 Success:(void(^)(NSInteger status,NSString *msg))successBlock error:(ErrorBlock)errorBlock;


/*******************检查安全码
 
 *********************/
+ (NetworkTask *)checkSecurityWithsafeCode:(NSString *)safe_code  Success:(void(^)(NSInteger status,NSString *msg))successBlock error:(ErrorBlock)errorBlock;

/*******************检查安全码
 
 *********************/
+ (NetworkTask *)checkSecurityWithsafeCode:(NSString *)safe_code  Success:(void(^)(NSInteger status,NSString *msg))successBlock error:(ErrorBlock)errorBlock;

/*******************添加安全码
 
 *********************/
+ (NetworkTask *)addSecurityWithsafeCode:(NSString *)safe_code  Success:(void(^)(NSInteger status,NSString *msg))successBlock error:(ErrorBlock)errorBlock;

/*******************重置安全码
 
 *********************/
+ (NetworkTask *)resetSecuritySuccess:(void(^)(NSInteger status,NSString *msg))successBlock error:(ErrorBlock)errorBlock;

/*******************获取验证码
 
 *********************/
+ (NetworkTask *)requestCodeWithMobile:(NSString *)mobile  Success:(void(^)(NSInteger status,NSString *msg))successBlock error:(ErrorBlock)errorBlock;

/*******************检查验证码
 
 *********************/
+ (NetworkTask *)checkCodeWithMobile:(NSString *)mobile code:(NSString *)code Success:(void(^)(NSInteger status,NSString *msg))successBlock error:(ErrorBlock)errorBlock;
@end

NS_ASSUME_NONNULL_END

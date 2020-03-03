//
//  MineApi.h
//  MakeMoney
//
//  Created by rabi on 2020/2/26.
//  Copyright © 2020 lqq. All rights reserved.
//

#import "BaseApi.h"

NS_ASSUME_NONNULL_BEGIN
@class UpdateItem,InitItem,ExtendDetailItem;
@interface MineApi : BaseApi
/**版本升级 */
+ (NetworkTask *)updateSuccess:(void(^)(UpdateItem *updateItem,NSString *msg))successBlock error:(ErrorBlock)errorBlock;


/********************充值记录 *********************/
+ (NetworkTask *)requestPayRecordsSuccess:(void(^)(NSArray *payRecordItemArr,NSString *msg))successBlock error:(ErrorBlock)errorBlock;


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


/*******************提现
 type   1银行卡   2.支付宝    3.微信  暂时只支持银行卡
 rate   手续费
 account
 bankcard
 money
 safe_code    安全码
 
 *********************/
+ (NetworkTask *)cashWithType:(NSString *)type rate:(NSString *)rate account:(NSString *)account bankcard:(NSString *)bankcard money:(NSString *)money safe_code:(NSString *)safe_code Success:(void(^)(NSInteger status,NSString *msg))successBlock error:(ErrorBlock)errorBlock;


@end

NS_ASSUME_NONNULL_END

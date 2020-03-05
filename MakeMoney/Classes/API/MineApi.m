//
//  MineApi.m
//  MakeMoney
//
//  Created by rabi on 2020/2/26.
//  Copyright © 2020 lqq. All rights reserved.
//

#import "MineApi.h"
#import "MineItem.h"
#import "InitItem.h"
@implementation MineApi
/**版本升级 */
+ (NetworkTask *)updateSuccess:(void(^)(UpdateItem *updateItem,NSString *msg))successBlock error:(ErrorBlock)errorBlock{
    return [NET POST:@"/api/version" parameters:nil criticalValue:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        UpdateItem *updateItem = [UpdateItem mj_objectWithKeyValues:[resultObject safeObjectForKey:@"data"]];
        NSString *msg = [resultObject safeObjectForKey:@"msg"];
        if (successBlock) {
            successBlock(updateItem,msg);
        }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, id _Nonnull resultObject) {
        if (errorBlock) {
            errorBlock(error,resultObject);
        }
    }];
}

/********************充值记录 *********************/
+ (NetworkTask *)requestPayRecordsSuccess:(void(^)(NSArray *payRecordItemArr,NSString *msg))successBlock error:(ErrorBlock)errorBlock{
    return [NET POST:@"/api/version" parameters:nil criticalValue:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        NSArray *payRecordItemArr = [PayRecordItem mj_objectArrayWithKeyValuesArray:[resultObject safeObjectForKey:@"data"]];
        NSString *msg = [resultObject safeObjectForKey:@"msg"];
        if (successBlock) {
            successBlock(payRecordItemArr,msg);
        }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, id _Nonnull resultObject) {
        if (errorBlock) {
            errorBlock(error,resultObject);
        }
    }];
}

/********************充值中心 *********************/
+ (NetworkTask *)requestPayCenterInfoSuccess:(void(^)(NSArray *payCenterInfotemArr,NSString *msg))successBlock error:(ErrorBlock)errorBlock{
    return [NET POST:@"/api/pay_type" parameters:nil criticalValue:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        NSArray *payCenterInfotemArr = [PayCenterInfotem mj_objectArrayWithKeyValuesArray:[resultObject safeObjectForKey:@"data"]];
        NSString *msg = [resultObject safeObjectForKey:@"msg"];
        if (successBlock) {
            successBlock(payCenterInfotemArr,msg);
        }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, id _Nonnull resultObject) {
        if (errorBlock) {
            errorBlock(error,resultObject);
        }
    }];
}


/********************短视频的播放次数
 {
     "status": 1,
     "msg": "",
     "rest_free_times": 8,
     "max_free_times": 10,
     "is_vip": 1,
     "vip_end_time": 1612237803
 }
 
 *********************/
+ (NetworkTask *)requestShortVedioInfoWithVedioId:(NSString *)video_id is_vip:(NSInteger)is_vip type:(NSInteger)type Success:(void(^)(InitItem *initItem,NSString *msg))successBlock error:(ErrorBlock)errorBlock{
    return [NET POST:@"/api/update_play" parameters:@{@"video_id":SAFE_NIL_STRING(video_id),@"is_vip":@(is_vip),@"type":@(type)} criticalValue:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        InitItem *initItem = [InitItem mj_objectWithKeyValues:[resultObject safeObjectForKey:@"data"]];

        NSString *msg = [resultObject safeObjectForKey:@"msg"];
        if (successBlock) {
            successBlock(initItem,msg);
        }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, id _Nonnull resultObject) {
        if (errorBlock) {
            errorBlock(error,resultObject);
        }
    }];
}

/********************更新AV的播放次数*********************/
+ (NetworkTask *)requestAVInfoWithVedioId:(NSString *)video_id  Success:(void(^)(InitItem *initItem,NSString *msg))successBlock error:(ErrorBlock)errorBlock{
    return [NET POST:@"/api/av_video/play" parameters:@{@"video_id":SAFE_NIL_STRING(video_id)} criticalValue:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        InitItem *initItem = [InitItem mj_objectWithKeyValues:[resultObject safeObjectForKey:@"data"]];

        NSString *msg = [resultObject safeObjectForKey:@"msg"];
        if (successBlock) {
            successBlock(initItem,msg);
        }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, id _Nonnull resultObject) {
        if (errorBlock) {
            errorBlock(error,resultObject);
        }
    }];
}

/*******************获取余额*********************/
+ (NetworkTask *)requestBalanceSuccess:(void(^)(NSInteger status,NSString *msg))successBlock error:(ErrorBlock)errorBlock{
    return [NET POST:@"/api/user/balance" parameters:nil criticalValue:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        NSInteger status = [[resultObject safeObjectForKey:@"status"] integerValue];

        NSString *msg = [[resultObject safeObjectForKey:@"msg"] stringValue];
        if (successBlock) {
            successBlock(status,msg);
        }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, id _Nonnull resultObject) {
        if (errorBlock) {
            errorBlock(error,resultObject);
        }
    }];
}

/*******************推广明细*********************/
+ (NetworkTask *)requestExtendDetailwithVideoInviteCode:(NSString *)invite_code pageIndex:(NSString *)page_index page_size:(NSString *)page_size Success:(void(^)(NSArray *extendArr,NSString *msg))successBlock error:(ErrorBlock)errorBlock{
    return [NET POST:@"/api/agent_detail/find" parameters:@{@"invite_code":SAFE_NIL_STRING(invite_code),@"page_index":SAFE_NIL_STRING(page_index),@"page_size":SAFE_NIL_STRING(page_size)} criticalValue:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        NSArray *extendArr = [ExtendDetailItem mj_objectArrayWithKeyValuesArray:[resultObject safeObjectForKey:@"data"]];
        NSString *msg = [resultObject safeObjectForKey:@"msg"];
        if (successBlock) {
            successBlock(extendArr,msg);
        }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, id _Nonnull resultObject) {
        if (errorBlock) {
            errorBlock(error,resultObject);
        }
    }];
}

/*******************推广赚钱*********************/
+ (NetworkTask *)requestExtendIncomeSuccess:(void(^)(ExtendDetailItem *extendDetailItem,NSString *msg))successBlock error:(ErrorBlock)errorBlock{
    return [NET POST:@"/api/user/agent" parameters:nil criticalValue:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        ExtendDetailItem *extendDetailItem = [ExtendDetailItem mj_objectWithKeyValues:[resultObject safeObjectForKey:@"data"]];

        NSString *msg = [resultObject safeObjectForKey:@"msg"];
        if (successBlock) {
            successBlock(extendDetailItem,msg);
        }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, id _Nonnull resultObject) {
        if (errorBlock) {
            errorBlock(error,resultObject);
        }
    }];
}

/*******************卡密兑换
 card_pwd
 sex_id
 invite_code
 
 *********************/
+ (NetworkTask *)buyVipWithCard_pwd:(NSString *)card_pwd sex_id:(NSString *)sex_id invite_code:(NSString *)invite_code Success:(void(^)(NSInteger status,NSString *msg))successBlock error:(ErrorBlock)errorBlock{
    return [NET POST:@"/api/check_card_pwd" parameters:@{@"card_pwd":SAFE_NIL_STRING(card_pwd),@"sex_id":SAFE_NIL_STRING(sex_id),@"invite_code":SAFE_NIL_STRING(invite_code)} criticalValue:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        NSInteger status = [[resultObject safeObjectForKey:@"status"] integerValue];

        NSString *msg = [resultObject safeObjectForKey:@"msg"];
        if (successBlock) {
            successBlock(status,msg);
        }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, id _Nonnull resultObject) {
        if (errorBlock) {
            errorBlock(error,resultObject);
        }
    }];
}

/*******************提现
 type   1银行卡   2.支付宝    3.微信  暂时只支持银行卡
 rate   手续费
 account
 bankcard
 money
 safe_code    安全码
 
 *********************/
+ (NetworkTask *)cashWithType:(NSString *)type rate:(NSString *)rate account:(NSString *)account bankcard:(NSString *)bankcard money:(NSString *)money safe_code:(NSString *)safe_code Success:(void(^)(NSInteger status,NSString *msg))successBlock error:(ErrorBlock)errorBlock{
    return [NET POST:@"/api/withdraw/add" parameters:@{@"type":SAFE_NIL_STRING(type),@"rate":SAFE_NIL_STRING(rate),@"account":SAFE_NIL_STRING(account),@"bankcard":SAFE_NIL_STRING(bankcard),@"money":SAFE_NIL_STRING(money),@"safe_code":SAFE_NIL_STRING(safe_code)} criticalValue:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        NSInteger status = [[resultObject safeObjectForKey:@"status"] integerValue];

        NSString *msg = [resultObject safeObjectForKey:@"msg"];
        if (successBlock) {
            successBlock(status,msg);
        }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, id _Nonnull resultObject) {
        if (errorBlock) {
            errorBlock(error,resultObject);
        }
    }];
}

/*******************获取支付方式
 
 *********************/
+ (NetworkTask *)requestPayWaysSuccess:(void(^)(NSInteger status,NSString *msg,NSArray *payWayItemArr))successBlock error:(ErrorBlock)errorBlock{
    return [NET POST:@"/api/pay_method" parameters:nil criticalValue:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        NSInteger status = [[resultObject safeObjectForKey:@"status"] integerValue];

        NSString *msg = [resultObject safeObjectForKey:@"msg"];
        NSArray *payWayItemArr = [PayWayItem mj_objectArrayWithKeyValuesArray:[resultObject safeObjectForKey:@"data"]];

        if (successBlock) {
            successBlock(status,msg,payWayItemArr);
        }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, id _Nonnull resultObject) {
        if (errorBlock) {
            errorBlock(error,resultObject);
        }
    }];
}

/*******************获取提现明细
 
 *********************/
+ (NetworkTask *)requestCashDetailSuccess:(void(^)(NSInteger status,NSString *msg,NSArray *tixianDetailItemArr))successBlock error:(ErrorBlock)errorBlock;{
    return [NET POST:@"/api/withdraw/find" parameters:nil criticalValue:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        NSInteger status = [[resultObject safeObjectForKey:@"status"] integerValue];

        NSString *msg = [resultObject safeObjectForKey:@"msg"];
        NSArray *tixianDetailItemArr = [TixianDetailItem mj_objectArrayWithKeyValuesArray:[resultObject safeObjectForKey:@"data"]];

        if (successBlock) {
            successBlock(status,msg,tixianDetailItemArr);
        }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, id _Nonnull resultObject) {
        if (errorBlock) {
            errorBlock(error,resultObject);
        }
    }];
}

/*******************获取邀请记录
 
 *********************/
+ (NetworkTask *)requestShareRecordsWithInviteCode:(NSString *)invite_code  Success:(void(^)(NSInteger status,NSString *msg,NSArray *extendDetailItemArr))successBlock error:(ErrorBlock)errorBlock{
    return [NET POST:@"/api/invite_record/find" parameters:@{@"invite_code":SAFE_NIL_STRING(invite_code)} criticalValue:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        NSInteger status = [[resultObject safeObjectForKey:@"status"] integerValue];

        NSString *msg = [resultObject safeObjectForKey:@"msg"];
        NSArray *extendDetailItemArr = [ExtendDetailItem mj_objectArrayWithKeyValuesArray:[resultObject safeObjectForKey:@"data"]];

        if (successBlock) {
            successBlock(status,msg,extendDetailItemArr);
        }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, id _Nonnull resultObject) {
        if (errorBlock) {
            errorBlock(error,resultObject);
        }
    }];
}

/*******************用户信息
 
 *********************/
+ (NetworkTask *)requestUserInfoSuccess:(void(^)(NSInteger status,NSString *msg,InitItem *initItem))successBlock error:(ErrorBlock)errorBlock{
    return [NET POST:@"/api/user/info" parameters:nil criticalValue:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        NSInteger status = [[resultObject safeObjectForKey:@"status"] integerValue];

        NSString *msg = [resultObject safeObjectForKey:@"msg"];
        InitItem *initItem = [InitItem mj_objectWithKeyValues:[resultObject safeObjectForKey:@"data"]];

        if (successBlock) {
            successBlock(status,msg,initItem);
        }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, id _Nonnull resultObject) {
        if (errorBlock) {
            errorBlock(error,resultObject);
        }
    }];
}

/*******************请求支付
 channel_id      渠道号
 goods_id        商品id     支付列表返回
 sex_id          用户ID
 pay_type       支付类型
 
 type 1     跳转到webview加载 data
 Type  3或4    跳转到新的扫码支付界面
 *********************/
+ (NetworkTask *)goPayWithInviteChannelId:(NSString *)channel_id goods_id:(NSString *)goods_id sex_id:(NSString *)sex_id pay_type:(NSString *)pay_type  Success:(void(^)(NSInteger status,NSString *msg,PayDetailItem *payDetailItem))successBlock error:(ErrorBlock)errorBlock{
    
    return [NET POST:@"/api/jz_getpay" parameters:@{@"channel_id":SAFE_NIL_STRING(channel_id),@"goods_id":SAFE_NIL_STRING(goods_id),@"sex_id":SAFE_NIL_STRING(sex_id),@"pay_type":SAFE_NIL_STRING(pay_type)} criticalValue:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        NSInteger status = [[resultObject safeObjectForKey:@"status"] integerValue];
        NSString *msg = [resultObject safeObjectForKey:@"msg"];
        PayDetailItem *payDetailItem = [PayDetailItem mj_objectWithKeyValues:[resultObject safeObjectForKey:@"data"]];

        if (successBlock) {
            successBlock(status,msg,payDetailItem);
        }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, id _Nonnull resultObject) {
        if (errorBlock) {
            errorBlock(error,resultObject);
        }
    }];
}
@end

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

/*******************分享*********************/
+ (NetworkTask *)shareSuccess:(void(^)(NSString *msg))successBlock error:(ErrorBlock)errorBlock{
    return [NET POST:@"/api/check_card_pwd" parameters:@{@"code":SAFE_NIL_STRING(RI.infoInitItem.invite_code)} criticalValue:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {

        NSString *msg = [resultObject safeObjectForKey:@"msg"];
        if (successBlock) {
            successBlock(msg);
        }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, id _Nonnull resultObject) {
        if (errorBlock) {
            errorBlock(error,resultObject);
        }
    }];
}
@end

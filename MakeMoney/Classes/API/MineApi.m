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
#import "AblumItem.h"
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
+ (NetworkTask *)requestPayRecordswithPageIndex:(NSString *)page_index page_size:(NSString *)page_size Success:(void(^)(NSArray *payRecordItemArr,NSString *msg))successBlock error:(ErrorBlock)errorBlock{
    return [NET POST:@"/api/pay_detail/find" parameters:@{@"page_index":SAFE_NIL_STRING(page_index),@"page_size":SAFE_NIL_STRING(page_size)} criticalValue:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
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

/********************充值中心
//tag : 0 视频 1同城2写真
 *********************/

+ (NetworkTask *)requestPayCenterInfoWithTag:(NSString *)tag Success:(void(^)(NSArray *payCenterInfotemArr,NSString *msg))successBlock error:(ErrorBlock)errorBlock{
    return [NET POST:@"/api/pay_type_new" parameters:@{@"tag":SAFE_NIL_STRING(tag)} criticalValue:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
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
+ (NetworkTask *)requestBalanceSuccess:(void(^)(NSInteger status,NSString *msg,NSString *balance,NSString *gold))successBlock error:(ErrorBlock)errorBlock{
    return [NET POST:@"/api/user/balance2" parameters:nil criticalValue:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        NSInteger status = [[resultObject safeObjectForKey:@"status"] integerValue];

        NSString *msg = [resultObject safeObjectForKey:@"msg"] ;
        NSString *balance = [[resultObject safeObjectForKey:@"balance"] stringValue];
        NSString *gold = [[resultObject safeObjectForKey:@"gold"] stringValue];

        if (successBlock) {
            successBlock(status,msg,balance,gold);
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

/*******************卡密兑换 手动
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

/*******************卡密兑换2  自动兑换 跟在订单查询后 请求
 card_pwd
 sex_id
 invite_code
 
 *********************/
+ (NetworkTask *)autobuyVipWithCard_pwd:(NSString *)card_pwd sex_id:(NSString *)sex_id invite_code:(NSString *)invite_code Success:(void(^)(NSInteger status,NSString *msg))successBlock error:(ErrorBlock)errorBlock{
    return [NET POST:@"/api/check_card_pwd2" parameters:@{@"card_pwd":SAFE_NIL_STRING(card_pwd),@"sex_id":SAFE_NIL_STRING(sex_id),@"invite_code":SAFE_NIL_STRING(invite_code)} criticalValue:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
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
+ (NetworkTask *)requestCashDetailwithPageIndex:(NSString *)page_index page_size:(NSString *)page_size Success:(void(^)(NSInteger status,NSString *msg,NSArray *tixianDetailItemArr))successBlock error:(ErrorBlock)errorBlock;{
    return [NET POST:@"/api/withdraw/find" parameters:@{@"page_index":SAFE_NIL_STRING(page_index),@"page_size":SAFE_NIL_STRING(page_size)} criticalValue:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
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
        //is_new_user = 1 && mobile ！= nil    新账号
        if (initItem.is_new_user == 1 && initItem.mobile.length != 0) {
            initItem.is_new_user = 1;
        }else{
            //is_new_user = 1 && mobile == nil    可能是设备变了
              //is_new_user = 0 && mobile ！= nil    老用户
            initItem.is_new_user = NO;
        }
        
        RI.infoInitItem = initItem;
        RI.infoInitItemJasonStr = [initItem mj_JSONString];

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
        RI.tradeNo = payDetailItem.trade_no;
        if (successBlock) {
            successBlock(status,msg,payDetailItem);
        }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, id _Nonnull resultObject) {
        if (errorBlock) {
            errorBlock(error,resultObject);
        }
    }];
}


/*******************订单查询 查询支付结果 返回卡密
 
 *********************/
+ (NetworkTask *)requestPayResultWithTradeNo:(NSString *)trade_no Success:(void(^)(NSInteger status,NSString *msg,NSString *secret))successBlock error:(ErrorBlock)errorBlock{
        return [NET POST:@"/api/jz_verpay" parameters:@{@"trade_no":SAFE_NIL_STRING(trade_no)} criticalValue:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
            NSInteger status = [[resultObject safeObjectForKey:@"status"] integerValue];
            NSString *msg = [resultObject safeObjectForKey:@"msg"];
            NSString *secret = [[resultObject safeObjectForKey:@"data"] safeObjectForKey:@"secret"];

            if (successBlock) {
                successBlock(status,msg,secret);
            }
        } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, id _Nonnull resultObject) {
            if (errorBlock) {
                errorBlock(error,resultObject);
            }
        }];        
}


/*******************添加邀请码
 sex_id
 invite_code      被邀请人的
 invite_code2     自己的
 *********************/
+ (NetworkTask *)requestPayResultWithsexID:(NSString *)sex_id invite_code:(NSString *)invite_code invite_code2:(NSString *)invite_code2 Success:(void(^)(NSInteger status,NSString *msg))successBlock error:(ErrorBlock)errorBlock{
    return [NET POST:@"/api/invite_record/add" parameters:@{@"sex_id":SAFE_NIL_STRING(sex_id),@"invite_code":SAFE_NIL_STRING(invite_code),@"invite_code2":SAFE_NIL_STRING(invite_code2)} criticalValue:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
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

/*******************检查安全码
 
 *********************/
+ (NetworkTask *)checkSecurityWithsafeCode:(NSString *)safe_code  Success:(void(^)(NSInteger status,NSString *msg))successBlock error:(ErrorBlock)errorBlock{
    return [NET POST:@"/api/check_safe_code" parameters:@{@"safe_code":SAFE_NIL_STRING(safe_code)} criticalValue:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
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

/*******************添加安全码
 
 *********************/
+ (NetworkTask *)addSecurityWithsafeCode:(NSString *)safe_code  Success:(void(^)(NSInteger status,NSString *msg))successBlock error:(ErrorBlock)errorBlock{
    return [NET POST:@"/api/safe_code/update" parameters:@{@"safe_code":SAFE_NIL_STRING(safe_code)} criticalValue:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
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

/*******************重置安全码
 
 *********************/
+ (NetworkTask *)resetSecuritySuccess:(void(^)(NSInteger status,NSString *msg))successBlock error:(ErrorBlock)errorBlock{
    return [NET POST:@"/api/reset_safe_code" parameters:nil criticalValue:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
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


/*******************获取验证码
 
 *********************/
+ (NetworkTask *)requestCodeWithMobile:(NSString *)mobile  Success:(void(^)(NSInteger status,NSString *msg))successBlock error:(ErrorBlock)errorBlock{
    return [NET POST:@"/api/get_code" parameters:@{@"mobile":SAFE_NIL_STRING(mobile)} criticalValue:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
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

/*******************检查验证码
 
 *********************/
+ (NetworkTask *)checkCodeWithMobile:(NSString *)mobile code:(NSString *)code Success:(void(^)(NSInteger status,NSString *msg))successBlock error:(ErrorBlock)errorBlock{
    return [NET POST:@"/api/check_code" parameters:@{@"mobile":SAFE_NIL_STRING(mobile),@"code":SAFE_NIL_STRING(code)} criticalValue:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
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

/******************获取设置信息  返回已绑定的手机号和邀请码
 
 *********************/
+ (NetworkTask *)requestSetInfoWithCode:(NSString *)invite_code Success:(void(^)(NSInteger status,NSString *msg,NSString *mobile,NSString *invite_code))successBlock error:(ErrorBlock)errorBlock{
    return [NET POST:@"/api/setting" parameters:@{@"invite_code":SAFE_NIL_STRING(invite_code)} criticalValue:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
         NSInteger status = [[resultObject safeObjectForKey:@"status"] integerValue];
         NSString *msg = [resultObject safeObjectForKey:@"msg"];
        NSString *mobile = [[resultObject safeObjectForKey:@"data"] safeObjectForKey:@"mobile"];
        NSString *invite_code = [[resultObject safeObjectForKey:@"data"] safeObjectForKey:@"invite_code"];

         if (successBlock) {
             successBlock(status,msg,mobile,invite_code);
         }
     } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, id _Nonnull resultObject) {
         if (errorBlock) {
             errorBlock(error,resultObject);
         }
     }];
}

/*******************AV  收藏列表
 page_index
 page_size

 *********************/
+ (NetworkTask *)requestAVLoveListWithPageIndex:(NSString *)page_index page_size:(NSString *)page_size Success:(void(^)(NSInteger status,NSString *msg,NSArray *hotItemArr))successBlock error:(ErrorBlock)errorBlock{
    return [NET POST:@"/api/video/av_love" parameters:@{@"page_index":SAFE_NIL_STRING(page_index),@"page_size":SAFE_NIL_STRING(page_size)} criticalValue:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        NSInteger status = [[resultObject safeObjectForKey:@"status"] integerValue];
        NSString *msg = [resultObject safeObjectForKey:@"msg"];

        NSArray *hotItemArr = [HotItem mj_objectArrayWithKeyValuesArray:[resultObject safeObjectForKey:@"data"]];
        if (successBlock) {
            successBlock(status,msg,hotItemArr);
        }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, id _Nonnull resultObject) {
        if (errorBlock) {
            errorBlock(error,resultObject);
        }
    }];
    
}

/*******************视频  收藏列表
 page_index
 page_size

 *********************/
+ (NetworkTask *)requestVideoLoveListWithPageIndex:(NSString *)page_index page_size:(NSString *)page_size Success:(void(^)(NSInteger status,NSString *msg,NSArray *hotItemArr))successBlock error:(ErrorBlock)errorBlock{
    return [NET POST:@"/api/video/love" parameters:@{@"page_index":SAFE_NIL_STRING(page_index),@"page_size":SAFE_NIL_STRING(page_size)} criticalValue:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        NSInteger status = [[resultObject safeObjectForKey:@"status"] integerValue];
        NSString *msg = [resultObject safeObjectForKey:@"msg"];

        NSArray *hotItemArr = [HotItem mj_objectArrayWithKeyValuesArray:[resultObject safeObjectForKey:@"data"]];
        if (successBlock) {
            successBlock(status,msg,hotItemArr);
        }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, id _Nonnull resultObject) {
        if (errorBlock) {
            errorBlock(error,resultObject);
        }
    }];
}


/*******************写真  收藏列表
 page_index
 page_size

 成功返回： (非VIP，imgs返回10条，VIP返回全集，自己拿集合分页加载)
 *********************/
+ (NetworkTask *)requestAblumLoveListWithPageIndex:(NSString *)page_index page_size:(NSString *)page_size Success:(void(^)(NSInteger status,NSString *msg,NSArray *ablumItemArr))successBlock error:(ErrorBlock)errorBlock{
    return [NET POST:@"/api/album/love" parameters:@{@"page_index":SAFE_NIL_STRING(page_index),@"page_size":SAFE_NIL_STRING(page_size)} criticalValue:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        NSInteger status = [[resultObject safeObjectForKey:@"status"] integerValue];
        NSString *msg = [resultObject safeObjectForKey:@"msg"];

        NSArray *ablumItemArr = [AblumItem mj_objectArrayWithKeyValuesArray:[resultObject safeObjectForKey:@"data"]];
        if (successBlock) {
            successBlock(status,msg,ablumItemArr);
        }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, id _Nonnull resultObject) {
        if (errorBlock) {
            errorBlock(error,resultObject);
        }
    }];
}

/*******************签到
 *********************/
+ (NetworkTask *)requestQiandaoSuccess:(void(^)(NSInteger status,NSString *msg))successBlock error:(ErrorBlock)errorBlock{
    return [NET POST:@"/api/sign_in" parameters:nil criticalValue:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
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
/**  登录  检查密码
 "msg": "58e17cf5d2952bdb91251c3c8bc4c504",   //返回token保存到请求头

 */

+ (NetworkTask *)loginWithMobile:(NSString *)mobile password:(NSString *)password success:(void(^)(NSInteger status,NSString *msg,NSString *token))successBlock error:(ErrorBlock)errorBlock{
    NSString *md5password = [RSAEncryptor MD5WithString:SAFE_NIL_STRING(password)];

    return [NET POST:@"/api/check_pwd2" parameters:@{@"mobile":SAFE_NIL_STRING(mobile),@"password":SAFE_NIL_STRING(md5password)} criticalValue:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
         NSInteger status = [[resultObject safeObjectForKey:@"status"] integerValue];
         NSString *msg = [resultObject safeObjectForKey:@"msg"];
        NSString *token = [resultObject safeObjectForKey:@"token"];

         if (successBlock) {
             successBlock(status,msg,token);
         }
     } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, id _Nonnull resultObject) {
         if (errorBlock) {
             errorBlock(error,resultObject);
         }
     }];
}
/**  设置密码  */

+ (NetworkTask *)setPwdWithMobile:(NSString *)mobile password:(NSString *)password success:(void(^)(NSInteger status,NSString *msg))successBlock error:(ErrorBlock)errorBlock{
    NSString *md5password = [RSAEncryptor MD5WithString:SAFE_NIL_STRING(password)];

    return [NET POST:@"/api/set_pwd2" parameters:@{@"mobile":SAFE_NIL_STRING(mobile),@"password":SAFE_NIL_STRING(md5password)} criticalValue:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
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
/**  更新密码  */

+ (NetworkTask *)updatePwdWithMobile:(NSString *)mobile password:(NSString *)password success:(void(^)(NSInteger status,NSString *msg))successBlock error:(ErrorBlock)errorBlock{
    NSString *md5password = [RSAEncryptor MD5WithString:SAFE_NIL_STRING(password)];

    return [NET POST:@"/api/update_pwd2" parameters:@{@"mobile":SAFE_NIL_STRING(mobile),@"password":SAFE_NIL_STRING(md5password)} criticalValue:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
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

/** 检查手机号是否存在
 "status": 0,      1.手机号不存在(自动获取验证码)      2.手机号已存在（进入输入i密码界面）

 */

+ (NetworkTask *)checkMobileRealWithMobile:(NSString *)mobile  success:(void(^)(NSInteger status,NSString *msg))successBlock error:(ErrorBlock)errorBlock{
    return [NET POST:@"/api/check_mobile2" parameters:@{@"mobile":SAFE_NIL_STRING(mobile)} criticalValue:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
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

@end

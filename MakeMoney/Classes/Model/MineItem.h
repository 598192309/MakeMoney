//
//  MineItem.h
//  MakeMoney
//
//  Created by rabi on 2020/2/26.
//  Copyright © 2020 lqq. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/********版本升级 */
@interface UpdateItem : NSObject
/**"1、添加好友推广赚钱。\\n2、添加提现功能。\\n3、VIP专区添加限时免费。", */
@property (nonatomic,strong)NSString *ios_content;
@property (nonatomic,strong)NSString *ios_download_url;
@property (nonatomic,strong)NSString *ID;
@property (nonatomic,assign)NSInteger status;
@property (nonatomic,strong)NSString *ios_version_code;
@property (nonatomic,strong)NSString *ios_version_name;
@end


/********************充值记录 *********************/
@interface PayRecordItem : NSObject
@property (nonatomic,strong)NSString *create_time;
@property (nonatomic,strong)NSString *device_id;
@property (nonatomic,strong)NSString *ID;
@property (nonatomic,strong)NSString *order_no;
@property (nonatomic,strong)NSString *price;
@property (nonatomic,assign)NSInteger status;
@property (nonatomic,assign)NSInteger type;
@property (nonatomic,strong)NSString * unit;
@property (nonatomic,strong)NSString *user_id;
@end

/********************充值中心 *********************/
@interface PayCenterInfotem : NSObject
@property (nonatomic,assign)NSInteger day;
@property (nonatomic,strong)NSString *ID;

@property (nonatomic,strong)NSString *img;
@property (nonatomic,strong)NSString *name;
@property (nonatomic,strong)NSString *old_price;
@property (nonatomic,strong)NSString *pay_type;
@property (nonatomic,strong)NSString *pay_url;
@property (nonatomic,strong)NSString *price;
@property (nonatomic,assign)NSInteger status;
@property (nonatomic,assign)NSInteger tag;
@property (nonatomic,strong)NSString *text;
@property (nonatomic,assign)NSInteger type;
@property (nonatomic,strong)NSString *unit;
@property (nonatomic,strong)NSString *goods_id;
@end

/********************推广明细 *********************/
@interface ExtendDetailItem : NSObject

@property (nonatomic,strong)NSString *balance;
@property (nonatomic,strong)NSString *three_level;
@property (nonatomic,strong)NSString *total_money;
@property (nonatomic,strong)NSString *one_level;
@property (nonatomic,strong)NSString *two_level;

//收益
@property (nonatomic,strong)NSString *create_time;
@property (nonatomic,strong)NSString *ID;
@property (nonatomic,strong)NSString *invite_code;
@property (nonatomic,strong)NSString *invite_code2;
@property (nonatomic,strong)NSString *money;
@property (nonatomic,strong)NSString *reward;
@property (nonatomic,strong)NSString *type;
//邀请记录
@property (nonatomic,strong)NSString *sex_id;
@property (nonatomic,assign)NSInteger status;


@end

/********************支付方式 *********************/
@interface PayWayItem : NSObject

@property (nonatomic,strong)NSString *channel_id;
@property (nonatomic,strong)NSString *create_time;
@property (nonatomic,strong)NSString *ID;
@property (nonatomic,strong)NSString *name;
@property (nonatomic,strong)NSString *type;
@end

/********************提现明细*********************/
@interface TixianDetailItem : NSObject

@property (nonatomic,strong)NSString *account;
@property (nonatomic,strong)NSString *arrive_money;
@property (nonatomic,strong)NSString *bankcard;
@property (nonatomic,strong)NSString *create_time;
@property (nonatomic,strong)NSString *device_id;
@property (nonatomic,strong)NSString *ID;
@property (nonatomic,strong)NSString *rate;
@property (nonatomic,strong)NSString *type;
@property (nonatomic,strong)NSString *withdraw_money;

@end


/********************请求支付返回的数据********************/
@interface PayDetailItem : NSObject

@property (nonatomic,strong)NSString *channel_id;
@property (nonatomic,strong)NSString *create_at;
@property (nonatomic,strong)NSString *data;
@property (nonatomic,strong)NSString *goods_id;
@property (nonatomic,strong)NSString *goods_name;
@property (nonatomic,strong)NSString *goods_price;
@property (nonatomic,strong)NSString *number;
@property (nonatomic,strong)NSString *price;
@property (nonatomic,strong)NSString *quantity;
@property (nonatomic,strong)NSString *secret;
@property (nonatomic,strong)NSString *timestamp;
@property (nonatomic,strong)NSString *total_price;
@property (nonatomic,strong)NSString *trade_no;

@end

NS_ASSUME_NONNULL_END

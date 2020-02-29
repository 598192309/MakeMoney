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
@property (nonatomic,assign)NSInteger content;
@property (nonatomic,strong)NSString *download_url;
@property (nonatomic,strong)NSString *ID;
@property (nonatomic,assign)NSInteger status;
@property (nonatomic,strong)NSString *version_code;
@property (nonatomic,strong)NSString *version_name;
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

@end

/********************推广明细 *********************/
@interface ExtendDetailItem : NSObject

@property (nonatomic,strong)NSString *balance;
@property (nonatomic,strong)NSString *three_level;
@property (nonatomic,strong)NSString *total_money;
@property (nonatomic,strong)NSString *one_level;
@property (nonatomic,strong)NSString *two_level;
@end



NS_ASSUME_NONNULL_END

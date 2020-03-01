//
//  LqToolKit.h
//  LqTool
//
//  Created by lqq on 2019/12/21.
//  Copyright © 2019 lqq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "HomeItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface LqToolKit : NSObject
/**
 *  获取应用版本号
 *
 *  @return 应用版本号字符串
 */
+ (NSString *)appVersionNo;


/**
 *  整形判断
 */
+ (BOOL)isPureInt:(NSString *)string;
/**
 *  浮点形判断
 */
+ (BOOL)isPureFloat:(NSString *)string;

/**
 *  检查手机号是否合法(只判断了是否为11位数字)
 */
+ (BOOL)checkIfPhoneNumberIsSuit:(NSString *)phoneNumber;


/**
 *  隐藏键盘
 */
+ (void)hiddenKeyboard;


/**
 获取状态栏高度
 */
+ (CGFloat)getStatusBarHeight;


/**
 获取系统导航栏和状态栏的高度
 */
+ (CGFloat)getSystemNavHeight;

/**
 NSString转NSDate
 
 @param string 时间字符串
 @param fmtStr 格式
 @return NSDate
 */
+ (NSDate *)dateFromString:(NSString *)string formatterString:(NSString *)fmtStr;

/**
 NSDate转NSString
 
 @param date NSDate
 @param fmtStr 格式
 @return 字符串
 */
+ (NSString *)stringFromDate:(NSDate *)date formatterString:(NSString *)fmtStr;


/**
 获取最顶层的视图控制器
 不论中间采用了 push->push->present还是present->push->present,或是其它交互
 */
+ (UIViewController *)topViewController;


/**
 打开设置
 */
+ (void)openAppSettings;

/**
 去往评论页面
 */
+ (void)goToAppStoreWriteReview;


/**
 判断用户是否允许接收通知
 */
+ (BOOL)isUserNotificationEnable;


/**
 防止UITableView刷新的时候跳动
 */
+ (void)preventTableViewJumpWhenReload:(UITableView *)tableView;


//下面两个方法为了RSAEncryptor里的
+ (NSString *)parseByte2HexString:(Byte *) bytes  :(int)len;
+  (NSData *)convertHexStrToData:(NSString *)str ;



#pragma MakeMoney

/// 广告i跳转
/// @param item 广告
+ (void)jumpAdventWithItem:(AdsItem *)item;
@end

NS_ASSUME_NONNULL_END

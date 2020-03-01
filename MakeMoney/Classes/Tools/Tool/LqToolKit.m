//
//  LqToolKit.m
//  LqTool
//
//  Created by lqq on 2019/12/21.
//  Copyright © 2019 lqq. All rights reserved.
//

#import "LqToolKit.h"
@implementation LqToolKit

/**
 *  获取应用版本号
 *
 *  @return 应用版本号字符串
 */
+ (NSString *)appVersionNo{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}



/**
 *  整形判断
 */
+ (BOOL)isPureInt:(NSString *)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

/**
 *  浮点形判断
 */
+ (BOOL)isPureFloat:(NSString *)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return [scan scanFloat:&val] && [scan isAtEnd];
}

/**
 *  检查手机号是否合法(只判断了是否为11位数字)
 */
+ (BOOL)checkIfPhoneNumberIsSuit:(NSString *)phoneNumber
{
    NSString *phoneRegex = @"[0-9]{11}";
    
    NSPredicate *phonePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    
    return [phonePredicate evaluateWithObject:phoneNumber];
    
}
/**
 *  隐藏键盘
 */
+ (void)hiddenKeyboard
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

/**
 获取状态栏高度
 */
+ (CGFloat)getStatusBarHeight
{
    return [UIApplication sharedApplication].statusBarFrame.size.height;
}

/**
 获取系统导航栏和状态栏的高度
 */
+ (CGFloat)getSystemNavHeight
{
    return [LqToolKit getStatusBarHeight] + 44;
}

/**
 NSString转NSDate
 
 @param string 时间字符串
 @param fmtStr 格式
 @return NSDate
 */
+ (NSDate *)dateFromString:(NSString *)string formatterString:(NSString *)fmtStr{
    NSDateFormatter *inputFmt = [[NSDateFormatter alloc] init];
    inputFmt.dateFormat = fmtStr;
    return [inputFmt dateFromString:string];
}

/**
 NSDate转NSString
 
 @param date NSDate
 @param fmtStr 格式
 @return 字符串
 */
+ (NSString *)stringFromDate:(NSDate *)date formatterString:(NSString *)fmtStr{
    NSDateFormatter *inputFmt = [[NSDateFormatter alloc] init];
    inputFmt.dateFormat = fmtStr;
    return [inputFmt stringFromDate:date];
}

/**
 获取最顶层的视图控制器
 不论中间采用了 push->push->present还是present->push->present,或是其它交互
 */
+ (UIViewController*)topViewController {
    return [self topViewControllerWithRootViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
}
+ (UIViewController*)topViewControllerWithRootViewController:(UIViewController*)rootViewController {
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController* tabBarController = (UITabBarController*)rootViewController;
        return [self topViewControllerWithRootViewController:tabBarController.selectedViewController];
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController* nav = (UINavigationController*)rootViewController;
        return [self topViewControllerWithRootViewController:nav.visibleViewController];
    } else if (rootViewController.presentedViewController) {
        UIViewController* presentedViewController = rootViewController.presentedViewController;
        return [self topViewControllerWithRootViewController:presentedViewController];
    } else {
        return rootViewController;
    }
}


/**
 打开设置
 */
+ (void)openAppSettings
{
    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }
}


/**
 去往评论页面
 */
+ (void)goToAppStoreWriteReview

{
    
    NSString *itunesurl = @"itms-apps://itunes.apple.com/cn/app/id1399471514?mt=8&action=write-review";
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:itunesurl]];
    
}



/**
 判断用户是否允许接收通知
 */
+ (BOOL)isUserNotificationEnable {
    BOOL isEnable = NO;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0f) { // iOS版本 >=8.0 处理逻辑
        UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
        isEnable = (UIUserNotificationTypeNone == setting.types) ? NO : YES;
    } else { // iOS版本 <8.0 处理逻辑
        UIRemoteNotificationType type = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
        isEnable = (UIRemoteNotificationTypeNone == type) ? NO : YES;
    }
    return isEnable;
}

/**
 防止UITableView刷新的时候跳动
 */
+ (void)preventTableViewJumpWhenReload:(UITableView *)tableView
{
    tableView.estimatedRowHeight = 0;
    tableView.estimatedSectionHeaderHeight = 0;
    tableView.estimatedSectionFooterHeight = 0;
}


+ (NSString *)parseByte2HexString:(Byte *) bytes  :(int)len{
    
    
    NSString *hexStr = @"";
    
    if(bytes)
    {
        for(int i=0;i<len;i++)
        {
            NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff]; ///16进制数
            if([newHexStr length]==1)
                hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
            else
            {
                hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
            }
            
            NSLog(@"%@",hexStr);
        }
    }
    
    return hexStr;
}
+  (NSData *)convertHexStrToData:(NSString *)str {
    if (!str || [str length] == 0) {
        return nil;
    }
    
    NSMutableData *hexData = [[NSMutableData alloc] initWithCapacity:8];
    NSRange range;
    if ([str length] % 2 == 0) {
        range = NSMakeRange(0, 2);
    } else {
        range = NSMakeRange(0, 1);
    }
    for (NSInteger i = range.location; i < [str length]; i += 2) {
        unsigned int anInt;
        NSString *hexCharStr = [str substringWithRange:range];
        NSScanner *scanner = [[NSScanner alloc] initWithString:hexCharStr];
        
        [scanner scanHexInt:&anInt];
        NSData *entity = [[NSData alloc] initWithBytes:&anInt length:1];
        [hexData appendData:entity];
        
        range.location += range.length;
        range.length = 2;
    }
    
    NSLog(@"hexdata: %@", hexData);
    return hexData;
}


#pragma MakeMoney

/// 广告i跳转
/// @param item 广告
+ (void)jumpAdventWithItem:(AdsItem *)item {
    switch (item.tag) {
        case AdTag_Defult:
        {
            
        }
            break;
        case AdTag_Safari:
        {
            NSURL *url = [NSURL URLWithString:item.url];
            [[UIApplication sharedApplication] openURL:url];
        }
            break;
        case AdTag_AVDetailVC:
        {
            [LSVProgressHUD showInfoWithStatus:@"跳转到AV详情页面"];
        }
            break;
        case AdTag_QMDetailVC:
        {
            [LSVProgressHUD showInfoWithStatus:@"跳转到同城详情页面"];

        }
            break;
            
        default:
            break;
    }
}
@end

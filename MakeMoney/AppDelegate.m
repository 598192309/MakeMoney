//
//  AppDelegate.m
//  Encropy
//
//  Created by Lqq on 2019/4/24.
//  Copyright © 2019年 Lq. All rights reserved.
//

#import "AppDelegate.h"
#import "MainTabBarController.h"
#import "BaseNavigationController.h"
#import "LorginViewController.h"
#import "IQKeyboardManager.h"
#import <UMCommon/UMCommon.h>

#import "LaunchingViewController.h"
#import "MineApi.h"
#import "MineItem.h"

#import "JANALYTICSService.h"
#import "ShareInstallSDK.h"

static BOOL isProduction = YES;

static NSString  *YouMengKey = @"5e551f1c0cafb2fd5a00017b";
static NSString  *JiguangKey = @"5c8cf6e4604a4d52bdc42ae4";


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
//
//    MainTabBarController *tabbarVC = [[MainTabBarController alloc]init];
//    self.rootTabbar = tabbarVC;
//    self.window.rootViewController = tabbarVC;
    self.window.rootViewController = [LaunchingViewController new];
    
    
    //    // 判断下用户有没有最新的版本
    //    NSDictionary *dict =  [NSBundle mainBundle].infoDictionary;
    //
    //    // 获取最新的版本号
    //    NSString *curVersion = dict[@"CFBundleShortVersionString"];
    //
    //    // 获取上一次的版本号
    //    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:VersionKey];
    //
    //    // 之前的最新的版本号 lastVersion
    //    if ([curVersion isEqualToString:lastVersion]) {
    //        [[NSUserDefaults standardUserDefaults] setObject:curVersion forKey:VersionKey];
    //
    //        self.window.rootViewController  = [[LaunchingViewController alloc] init];
    //        [self.window makeKeyAndVisible];
    //
    //
    //    }else{ // 有最新的版本号
    //
    //        // 保存最新的版本号
    //        // 保存到偏好设置
    //        [[NSUserDefaults standardUserDefaults] setObject:curVersion forKey:VersionKey];
    //        self.window.rootViewController = [[NewfeatureViewController alloc] init];
    //        [self.window makeKeyAndVisible];
    //
    //        NewFeatureScrollView *scrollView = [[NewFeatureScrollView alloc] init];
    //        [scrollView showInView:self.window animation:nil completion:^(BOOL finished) {
    //
    //        }];
    //
    //    }
    
    
    [self.window makeKeyAndVisible];
    //友盟 统计
    [UMConfigure initWithAppkey:YouMengKey channel:@"App Store"];

    //极光统计
   JANALYTICSLaunchConfig * config = [[JANALYTICSLaunchConfig alloc] init];

   config.appKey = JiguangKey;
    
   config.channel = @"ios";
    
   [JANALYTICSService setupWithConfig:config];
    
    //IQKeyboardManager
    [self IQKeyboardManagerConfig];
    
    //ShareInstallSDK   推广的，推链接出去，别人通过连接注册就能自动成为好友
//    [ShareInstallSDK setAppKey:@"7RBKREB67B6RHB" withDelegate:self WithOptions:launchOptions clearCustomParams:NO];


    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
//    //请求 看看有没有订单
//    [self requestOrder];
    
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark ShareInstallDelegate
////通过ShareInstall获取自定义参数，数据为空时也会调用此方法
//- (void)getInstallParamsFromSmartInstall:(id) params withError: (NSError *) error{
//    NSLog(@"安装参数params=%@",params);
//    //绑定邀请人
//
//}

#pragma mark - 自定义

+ (AppDelegate* )shareAppDelegate {
    return (AppDelegate*)[UIApplication sharedApplication].delegate;
}
+ (void)presentLoginViewContrller
{
    AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;
    BaseNavigationController*nav = [[BaseNavigationController alloc] initWithRootViewController:[[LorginViewController alloc] init]];
    
    [del.window.rootViewController presentViewController:nav animated:YES completion:nil];
}

-(void)IQKeyboardManagerConfig{
    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager]; // 获取类库的单例变量
    keyboardManager.enable = YES; // 控制整个功能是否启用
    keyboardManager.shouldResignOnTouchOutside = YES; // 控制点击背景是否收起键盘
    keyboardManager.shouldToolbarUsesTextFieldTintColor = YES; // 控制键盘上的工具条文字颜色是否用户自定义
    keyboardManager.toolbarManageBehaviour = IQAutoToolbarBySubviews; // 有多个输入框时，可以通过点击Toolbar 上的“前一个”“后一个”按钮来实现移动到不同的输入框
    keyboardManager.enableAutoToolbar = YES; // 控制是否显示键盘上的工具条
    keyboardManager.shouldShowTextFieldPlaceholder = YES; // 是否显示占位文字
    keyboardManager.placeholderFont = RegularFONT(15); // 设置占位文字的字体
    keyboardManager.keyboardDistanceFromTextField = 10.0f; // 输入框距离键盘的距离
}



#pragma  mark - net
- (void)requestOrder{
    if (RI.tradeNo.length == 0) {
        return;
    }
    [LSVProgressHUD show];
    [MineApi requestPayResultWithTradeNo:RI.tradeNo Success:^(NSInteger status, NSString * _Nonnull msg, NSString * _Nonnull secret) {
        InitItem *item = [InitItem mj_objectWithKeyValues:[RI.infoInitItemJasonStr mj_JSONObject]] ;
        //兑换卡密
        [MineApi autobuyVipWithCard_pwd:secret sex_id:item.sex_id invite_code:item.invite_code Success:^(NSInteger status, NSString * _Nonnull msg) {
            RI.tradeNo = @"";
            [LSVProgressHUD showInfoWithStatus:msg];
        } error:^(NSError *error, id resultObject) {
            [LSVProgressHUD showError:error];
        }];
    } error:^(NSError *error, id resultObject) {
        [LSVProgressHUD showError:error];

    }];
}


@end

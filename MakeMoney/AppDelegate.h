//
//  AppDelegate.h
//  Encropy
//
//  Created by Lqq on 2019/4/24.
//  Copyright © 2019年 Lq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainTabBarController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;


@property (strong, nonatomic) MainTabBarController *rootTabbar;


+ (AppDelegate* )shareAppDelegate;

+ (void)presentLoginViewContrller;

@end


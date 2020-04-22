//
//  BindMobileSecStepViewController.h
//  MakeMoney
//
//  Created by rabi on 2020/3/6.
//  Copyright © 2020 lqq. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface BindMobileSecStepViewController : BaseViewController
@property (nonatomic,strong)NSString *mobile;
@property (nonatomic,assign)BOOL isFindBackPwd;//找回密码
@property (nonatomic,assign)BOOL isFisrtlogin;//是第一次登录

@end

NS_ASSUME_NONNULL_END

//
//  BindMobileSetPwdViewController.h
//  MakeMoney
//
//  Created by 黎芹 on 2020/4/20.
//  Copyright © 2020 lqq. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface BindMobileSetPwdViewController : BaseViewController
@property (nonatomic,strong)NSString *mobile;
@property (nonatomic,assign)BOOL islogin;//是登录 还是更新密码
@property (nonatomic,assign)BOOL isFisrtlogin;//是第一次登录

@end

NS_ASSUME_NONNULL_END

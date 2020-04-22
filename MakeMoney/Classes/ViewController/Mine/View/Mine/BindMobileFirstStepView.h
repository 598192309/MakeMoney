//
//  BindMobileFirstStepView.h
//  MakeMoney
//
//  Created by rabi on 2020/3/6.
//  Copyright © 2020 lqq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BindMobileFirstStepView : UIView
/**点击确定*/
@property(nonatomic,copy)void(^confirmBtnClickBlock)(UIButton * sender,UITextField *tf);
@property (nonatomic,assign)BOOL isFindBackPwd;//找回密码

@end

NS_ASSUME_NONNULL_END

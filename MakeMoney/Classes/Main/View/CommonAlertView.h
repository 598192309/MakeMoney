//
//  CommonAlertView.h
//  MakeMoney
//
//  Created by rabi on 2020/3/4.
//  Copyright © 2020 lqq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommonAlertView : UIView
@property(nonatomic,copy)void(^commonAlertViewBlock)(NSInteger index,NSString *str);
- (void)refreshUIWithTitle:(NSString *)title firstBtnTitle:(NSString *)firstBtnTitle secBtnTitle:(NSString *)secBtnTitle singleBtnTitle:(NSString *)singleBtnTitle;

- (void)refreshUIWithTitle:(NSString *)title titlefont:(UIFont *)titlefont titleColor:(UIColor *)titleColor firstBtnTitle:(NSString *)firstBtnTitle secBtnTitle:(NSString *)secBtnTitle singleBtnTitle:(NSString *)singleBtnTitle;

- (void)refreshUIWithTitle:(NSString *)title titlefont:(UIFont *)titlefont titleColor:(UIColor *)titleColor subtitle:(NSString *)subTitle subTitleFont:(UIFont *)subTitleFont subtitleColor:(UIColor *)subtitleColor firstBtnTitle:(NSString *)firstBtnTitle secBtnTitle:(NSString *)secBtnTitle singleBtnTitle:(NSString *)singleBtnTitle;
@end

NS_ASSUME_NONNULL_END

//
//  UIButton+LqExtension.h
//  LqTool
//
//  Created by rabi on 2019/12/24.
//  Copyright © 2019 lqq. All rights reserved.
//



#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (LqExtension)

/** 创建普通按钮 */
+ (instancetype)buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor titleFont:(UIFont *)titleFont backGroundColor:(UIColor *)color Target:(id)target action:(SEL)action rect:(CGRect)rect;

+ (instancetype)buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor titleFont:(UIFont *)titleFont backGroundColor:(UIColor *)color normalImage:(UIImage *)normalImage selectedImage:(UIImage *)selectedImage Target:(id)target action:(SEL)action rect:(CGRect)rect;


/**
 *  倒计时按钮
 *
 *  @param timeLine 倒计时总时间
 *  @param title    还没倒计时的title
 *  @param subTitle 倒计时中的子名字，如时、分
 *  @param mColor   还没倒计时的颜色
 *  @param color    倒计时中的颜色
 */
- (void)startWithTime:(NSInteger)timeLine title:(NSString *)title countDownTitle:(NSString *)subTitle mainColor:(UIColor *)mColor countColor:(UIColor *)color;

/**
 *  倒计时按钮
 *
 *  @param timeLine 倒计时总时间
 *  @param title    还没倒计时的title
 *  @param subTitle 倒计时中的子名字，如时、分
 *  @param cColor   倒计时的文字的颜色

 *  @param mColor   还没倒计时的按钮颜色
 *  @param color    倒计时中的按钮颜色
 */
- (void)startWithTime:(NSInteger)timeLine title:(NSString *)title titleColor:(UIColor *)tColor countDownTitle:(NSString *)subTitle countDownTitleColor:(UIColor *)cColor mainColor:(UIColor *)mColor countColor:(UIColor *)color;

- (void)countBtnReset;



/**********************************************************自定义位置***************/
/** 图片在左，标题在右 */
- (void)setIconInLeft;
/** 图片在右，标题在左 */
- (void)setIconInRight;
/** 图片在上，标题在下 */
- (void)setIconInTop;
/** 图片在下，标题在上 */
- (void)setIconInBottom;

//** 可以自定义图片和标题间的间隔 */
- (void)setIconInLeftWithSpacing:(CGFloat)Spacing;
- (void)setIconInRightWithSpacing:(CGFloat)Spacing;
- (void)setIconInTopWithSpacing:(CGFloat)Spacing;
- (void)setIconInBottomWithSpacing:(CGFloat)Spacing;
@end

NS_ASSUME_NONNULL_END

//
//  UILabel+LqExtension.h
//  LqTool
//
//  Created by rabi on 2019/12/24.
//  Copyright © 2019 lqq. All rights reserved.
//



#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (LqExtension)
+ (UILabel *)lableWithText:(NSString *)text textColor:(UIColor *)color fontSize:(UIFont *)fontSize lableSize:(CGRect)rect  textAliment:(NSTextAlignment)alignment;
+ (UILabel *)lableWithText:(NSString *)text textColor:(UIColor *)color fontSize:(UIFont *)fontSize lableSize:(CGRect)rect  textAliment:(NSTextAlignment)alignment numberofLines:(NSInteger)lines;
@end

NS_ASSUME_NONNULL_END

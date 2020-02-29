//
//  UIColor+LqExtension.h
//  LqTool
//
//  Created by lqq on 2019/12/20.
//  Copyright © 2019 lqq. All rights reserved.
//



#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (LqExtension)
// 默认alpha位1
+ (UIColor *)lq_colorWithHexString:(NSString *)color;

//从十六进制字符串获取颜色，
//color:支持@“#123456”、 @“0X123456”、 @“123456”三种格式
+ (UIColor *)lq_colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

+ (UIColor *)lq_colorWithHex:(int)hexValue;

+ (UIColor *)lq_colorWithHex:(int)hexValue alpha:(CGFloat)alpha;

+ (UIColor *)lq_averageColorFrom:(UIColor *)fromColor to:(UIColor *)toColor percent:(CGFloat)percent;
@end

NS_ASSUME_NONNULL_END

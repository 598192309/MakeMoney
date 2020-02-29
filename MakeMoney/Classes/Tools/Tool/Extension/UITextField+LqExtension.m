//
//  UITextField+LqExtension.m
//  LqTool
//
//  Created by rabi on 2019/12/24.
//  Copyright © 2019 lqq. All rights reserved.
//

#import "UITextField+LqExtension.h"



@implementation UITextField (LqExtension)
- (void)setPlaceholderColor:(UIColor *)color font:(nullable UIFont *)font
{
    NSMutableAttributedString *arrStr;
    if (font) {
        arrStr = [[NSMutableAttributedString alloc]initWithString:self.placeholder attributes:@{NSForegroundColorAttributeName : color,NSFontAttributeName:font}];
    }else{
        arrStr = [[NSMutableAttributedString alloc]initWithString:self.placeholder attributes:@{NSForegroundColorAttributeName : color}];
    }
    self.attributedPlaceholder = arrStr;

}
@end

//
//  UILabel+LqExtension.m
//  LqTool
//
//  Created by rabi on 2019/12/24.
//  Copyright © 2019 lqq. All rights reserved.
//

#import "UILabel+LqExtension.h"



@implementation UILabel (LqExtension)
+ (UILabel *)lableWithText:(NSString *)text textColor:(UIColor *)color fontSize:(UIFont *)fontSize lableSize:(CGRect)rect  textAliment:(NSTextAlignment)alignment{
    UILabel *label = [[UILabel alloc] init];
    label.textColor =color;
    label.text = text;
    label.font = fontSize;
    label.textAlignment = alignment ? alignment : NSTextAlignmentLeft;
    if (rect.size.width > 0) {
        label.frame = rect;
    }else{
        [label sizeToFit];
    }
    
    return label;

}
+ (UILabel *)lableWithText:(NSString *)text textColor:(UIColor *)color fontSize:(UIFont *)fontSize lableSize:(CGRect)rect  textAliment:(NSTextAlignment)alignment numberofLines:(NSInteger)lines{
    UILabel *label = [[UILabel alloc] init];
    label.textColor =color;
    label.text = text;
    label.font = fontSize;
    label.textAlignment = alignment ? alignment : NSTextAlignmentLeft;
    if (rect.size.width > 0) {
        label.frame = rect;
    }else{
        [label sizeToFit];
    }
    label.numberOfLines = lines;
    return label;
    
    
}
@end

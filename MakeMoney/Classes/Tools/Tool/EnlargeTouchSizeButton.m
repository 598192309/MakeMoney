//
//  EnlargeTouchSizeButton.m
//  Encropy
//
//  Created by Lqq on 2019/10/31.
//  Copyright © 2019 Lq. All rights reserved.
//
/**
 放大按钮的点击热区 响应热区
 
 touchSize为放大后的使用热区 放大规则为均匀向四周延展
 当touchisize 小于原frame时  热区值为原frame
 
 
 */

#import "EnlargeTouchSizeButton.h"

@implementation EnlargeTouchSizeButton

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    CGRect bounds = self.bounds;
    CGFloat widthDelta = MAX(self.touchSize.width - bounds.size.width, 0);
    CGFloat heightDelta = MAX(self.touchSize.height - bounds.size.height, 0);
    CGRect newBounds = CGRectInset(bounds, -0.5 * widthDelta, -0.5*heightDelta);
    return CGRectContainsPoint(newBounds, point);
}
@end

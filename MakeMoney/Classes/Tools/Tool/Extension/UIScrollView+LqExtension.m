//
//  UIScrollView+LqExtension.m
//  LqTool
//
//  Created by lqq on 2019/12/20.
//  Copyright © 2019 lqq. All rights reserved.
//

#import "UIScrollView+LqExtension.h"
@implementation UIScrollView (LqExtension)

- (void)setLq_insetTop:(CGFloat)lq_insetTop
{
    UIEdgeInsets inset = self.contentInset;
    inset.top = lq_insetTop;
    self.contentInset = inset;
}

- (CGFloat)lq_insetTop
{
    return self.contentInset.top;
}

- (void)setLq_insetBottom:(CGFloat)lq_insetBottom
{
    UIEdgeInsets inset = self.contentInset;
    inset.bottom = lq_insetBottom;
    self.contentInset = inset;
}

- (CGFloat)lq_insetBottom
{
    return self.contentInset.bottom;
}

- (void)setLq_insetLeft:(CGFloat)lq_insetLeft
{
    UIEdgeInsets inset = self.contentInset;
    inset.left = lq_insetLeft;
    self.contentInset = inset;
}

- (CGFloat)lq_insetLeft
{
    return self.contentInset.left;
}

- (void)setLq_insetRight:(CGFloat)lq_insetRight
{
    UIEdgeInsets inset = self.contentInset;
    inset.right = lq_insetRight;
    self.contentInset = inset;
}

- (CGFloat)lq_insetRight
{
    return self.contentInset.right;
}

- (void)setLq_contentOffsetX:(CGFloat)lq_contentOffsetX
{
    CGPoint offset = self.contentOffset;
    offset.x = lq_contentOffsetX;
    self.contentOffset = offset;
}

- (CGFloat)lq_contentOffsetX
{
    return self.contentOffset.x;
}

- (void)setLq_contentOffsetY:(CGFloat)lq_contentOffsetY
{
    CGPoint offset = self.contentOffset;
    offset.y = lq_contentOffsetY;
    self.contentOffset = offset;
}

- (CGFloat)lq_contentOffsetY
{
    return self.contentOffset.y;
}

- (void)setLq_contentWidth:(CGFloat)lq_contentWidth
{
    CGSize size = self.contentSize;
    size.width = lq_contentWidth;
    self.contentSize = size;
}

- (CGFloat)lq_contentWidth
{
    return self.contentSize.width;
}

- (void)setLq_contentHeight:(CGFloat)lq_contentHeight
{
    CGSize size = self.contentSize;
    size.height = lq_contentHeight;
    self.contentSize = size;
}

- (CGFloat)lq_contentHeight
{
    return self.contentSize.height;
}



@end

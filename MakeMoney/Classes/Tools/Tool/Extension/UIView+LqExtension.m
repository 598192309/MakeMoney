//
//  UIView+LqExtension.m
//  LqTool
//
//  Created by lqq on 2019/12/20.
//  Copyright © 2019 lqq. All rights reserved.
//

#import "UIView+LqExtension.h"


@implementation UIView (LqExtension)

- (CGFloat)lq_left {
    return self.frame.origin.x;
}

- (void)setLq_left:(CGFloat)lq_left {
    CGRect frame = self.frame;
    frame.origin.x = lq_left;
    self.frame = frame;
    return;
}

- (void)setLq_x:(CGFloat)lq_x
{
    CGRect frame = self.frame;
    frame.origin.x = lq_x;
    self.frame = frame;

}
- (CGFloat)lq_x
{
    return self.frame.origin.x;
}

- (void)setLq_y:(CGFloat)lq_y
{
    CGRect frame = self.frame;
    frame.origin.y = lq_y;
    self.frame = frame;
}
- (CGFloat)lq_y
{
    return self.frame.origin.y;
}

- (CGFloat)lq_top {
    return self.frame.origin.y;
}

- (void)setLq_top:(CGFloat)lq_top {
    CGRect frame = self.frame;
    frame.origin.y = lq_top;
    self.frame = frame;
    return;
}

- (CGFloat)lq_right {
    return [self lq_left] + [self lq_width];
}

- (void)setLq_right:(CGFloat)lq_right {
    CGRect frame = self.frame;
    frame.origin.x = lq_right - [self lq_width];
    self.frame = frame;
    return;
}

- (CGFloat)lq_bottom {
    return [self lq_top] + [self lq_height];
}

- (void)setLq_bottom:(CGFloat)lq_bottom {
    CGRect frame = self.frame;
    frame.origin.y = lq_bottom - [self lq_height];
    self.frame = frame;
    return;
}

- (CGFloat)lq_centerX {
    return self.center.x;
}

- (void)setLq_centerX:(CGFloat)lq_centerX {
    self.center = CGPointMake(lq_centerX, self.center.y);
    return;
}

- (CGFloat)lq_centerY {
    return self.center.y;
}

- (void)setLq_centerY:(CGFloat)lq_centerY {
    self.center = CGPointMake(self.center.x, lq_centerY);
    return;
}

- (CGFloat)lq_width {
    return self.frame.size.width;
}

- (void)setLq_width:(CGFloat)lq_width {
    CGRect frame = self.frame;
    frame.size.width = lq_width;
    self.frame = frame;
    return;
}

- (CGFloat)lq_height {
    return self.frame.size.height;
}

- (void)setLq_height:(CGFloat)lq_height {
    CGRect frame = self.frame;
    frame.size.height = lq_height;
    self.frame = frame;
    return;
}

- (CGPoint)lq_origin {
    return self.frame.origin;
}

- (void)setLq_origin:(CGPoint)lq_origin {
    CGRect frame = self.frame;
    frame.origin = lq_origin;
    self.frame = frame;
    return;
}

- (CGSize)lq_size {
    return self.frame.size;
}

- (void)setLq_size:(CGSize)lq_size {
    CGRect frame = self.frame;
    frame.size = lq_size;
    self.frame = frame;
    return;
}


/**
 移除此view上的所有子视图
 */
- (void)lq_removeAllSubviews {
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    return;
}


/**
 *  找到view上的第一响应者
 */
- (UIView *)lq_findFirstResponder {
    if (self.isFirstResponder)
    {
        return self;
    }
    for (UIView *subView in self.subviews)
    {
        UIView *firstResponder = [subView lq_findFirstResponder];
        if (firstResponder != nil)
        {
            return firstResponder;
        }
    }
    return nil;
}


/** 获取当前View的控制器对象 */
-(UIViewController *)lq_getCurrentViewController{
    UIResponder *next = [self nextResponder];
    do {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        next = [next nextResponder];
    } while (next != nil);
    return nil;
}



#pragma mark - 设置部分圆角
/**
 *  设置部分圆角(绝对布局)
 *
 *  @param corners 需要设置为圆角的角 UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerAllCorners
 *  @param radii   需要设置的圆角大小 例如 CGSizeMake(20.0f, 20.0f)
 */
- (void)lq_addRoundedCorners:(UIRectCorner)corners
                withRadii:(CGSize)radii {
    
    UIBezierPath* rounded = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:radii];
    CAShapeLayer* shape = [[CAShapeLayer alloc] init];
    [shape setPath:rounded.CGPath];
    
    self.layer.mask = shape;
    
}

/**
 *  设置部分圆角(相对布局)
 *
 *  @param corners 需要设置为圆角的角 UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerAllCorners
 *  @param radii   需要设置的圆角大小 例如 CGSizeMake(20.0f, 20.0f)
 *  @param rect    需要设置的圆角view的rect
 */
- (void)lq_addRoundedCorners:(UIRectCorner)corners
                withRadii:(CGSize)radii
                 viewRect:(CGRect)rect {
    
    UIBezierPath* rounded = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:radii];
    CAShapeLayer* shape = [[CAShapeLayer alloc] init];
    [shape setPath:rounded.CGPath];
    
    self.layer.mask = shape;
}

-(UIImage *)lq_saveImage {
    CGRect mainRect = [[UIScreen mainScreen] bounds];
    
    //    UIGraphicsBeginImageContext(self.frame.size);
    UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 3);
    CGContextRef context = UIGraphicsGetCurrentContext();
    //    [[UIColor blackColor] set];
    
    CGContextFillRect(context, mainRect);
    [self.layer renderInContext:context];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}



#pragma mark 设置边框
- (void)lq_addBorderWithBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor
{
    self.layer.borderColor = borderColor.CGColor;
    self.layer.borderWidth = borderWidth;
    self.layer.masksToBounds = YES;
}


/**
 遍历父视图的所有子视图，包括嵌套的子视图
 */
- (NSMutableArray *)lq_getAllSubViews
{
    NSMutableArray *allSubViews = [NSMutableArray array];
    
    for (UIView *subView in self.subviews) {
        [allSubViews addObject:subView];
        if (subView.subviews.count) {
            [allSubViews addObjectsFromArray:[subView lq_getAllSubViews]];
        }
    }
    
    return allSubViews;
}

@end

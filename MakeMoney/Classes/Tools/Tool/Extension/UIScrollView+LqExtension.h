//
//  UIScrollView+LqExtension.h
//  LqTool
//
//  Created by lqq on 2019/12/20.
//  Copyright © 2019 lqq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (LqExtension)
@property (assign, nonatomic) CGFloat lq_insetTop;
@property (assign, nonatomic) CGFloat lq_insetBottom;
@property (assign, nonatomic) CGFloat lq_insetLeft;
@property (assign, nonatomic) CGFloat lq_insetRight;

@property (assign, nonatomic) CGFloat lq_contentOffsetX;
@property (assign, nonatomic) CGFloat lq_contentOffsetY;

@property (assign, nonatomic) CGFloat lq_contentWidth;
@property (assign, nonatomic) CGFloat lq_contentHeight;
@end

NS_ASSUME_NONNULL_END

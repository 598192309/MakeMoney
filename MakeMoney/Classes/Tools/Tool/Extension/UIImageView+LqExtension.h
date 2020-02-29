//
//  UIImageView+LqExtension.h
//  LqTool
//
//  Created by lqq on 2019/12/20.
//  Copyright © 2019 lqq. All rights reserved.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (LqExtension)
/**
 根据颜色渲染图片
 */
- (void)lq_setImageWithName:(NSString *)imageName renderingImageWithColor:(UIColor *)color;
@end

NS_ASSUME_NONNULL_END

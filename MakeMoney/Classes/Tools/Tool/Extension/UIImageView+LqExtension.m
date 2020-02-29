//
//  UIImageView+LqExtension.m
//  LqTool
//
//  Created by lqq on 2019/12/20.
//  Copyright © 2019 lqq. All rights reserved.
//

#import "UIImageView+LqExtension.h"


@implementation UIImageView (LqExtension)
/**
 根据颜色渲染图片
 */
- (void)lq_setImageWithName:(NSString *)imageName renderingImageWithColor:(UIColor *)color
{
    UIImage *image = [UIImage imageNamed:imageName];
    self.image  =[image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.tintColor = color;
}
@end

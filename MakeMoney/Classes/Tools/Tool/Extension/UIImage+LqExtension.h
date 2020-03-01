//
//  UIImage+LqExtension.h
//  LqTool
//
//  Created by lqq on 2019/12/20.
//  Copyright © 2019 lqq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (LqExtension)
/**
 根据颜色 和 size 制作图片
 */
+ (UIImage *)lq_imageWithColor:(UIColor *)color size:(CGSize)size;


/**
 渲染成原图
 */
+ (UIImage *)lq_originImageWithImageName:(NSString *)imageName;


/**
 View生成图片
 */
+ (UIImage*)lq_imageWithUIView:(UIView*) view;



/**
 ScrollView生成图片
 */
+ (UIImage*)lq_getCaptureWithScrollView:(UIScrollView *)scrollView;

/**
 拼接图片
 */
+ (UIImage *)lq_combineWithTopImg:(UIImage*)topImage bottomImg:(UIImage*)bottomImage withMargin:(NSInteger)margin;


/**
 压缩图片
 */
+ (NSData *)lq_compressImage:(UIImage *)image toByte:(NSUInteger)maxLength;


/**64base字符串转图片*/
+ (UIImage *)base64stringToImage:(NSString *)str;

/**图片转64base字符串*/
+ (NSString *)imageToBase64String:(UIImage *)image;


/**
 *  根据图片url获取图片尺寸
 */
+ (CGSize)getImageSizeWithURL:(id)URL;
@end

NS_ASSUME_NONNULL_END

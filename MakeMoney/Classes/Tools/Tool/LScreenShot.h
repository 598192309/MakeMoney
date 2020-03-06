//
//  LScreenShot.h
//  xskj
//
//  Created by Lqq on 16/5/22.
//  Copyright © 2016年 lq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LScreenShot : NSObject


/**
 *  Build UIView ScreenShot
 *
 *  @param view Target UIView
 *
 *  @return UIimage
 */
+ (UIImage*)screenShotWithView:(UIView*)view size:(CGSize)size;

+(UIImage *)scaleToSize:(UIImage *)image CGRect:(CGRect)rect;

//获得某个范围内的屏幕图像
+ (UIImage *)imageFromView: (UIView *) theView   atFrame:(CGRect)r;

//裁剪某个范围内的屏幕图像  至尺寸
+ (UIImage *)cropImageFrom:(UIView *)aView inRect:(CGRect)rect;

+ (UIImage *)image:(UIImage *)image rotation:(UIImageOrientation)orientation;

@end

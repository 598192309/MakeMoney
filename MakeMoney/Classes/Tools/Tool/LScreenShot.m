//
//  LScreenShot.m
//  xskj
//
//  Created by Lqq on 16/5/22.
//  Copyright © 2016年 lq. All rights reserved.
//

#import "LScreenShot.h"
@interface LScreenShot()
@property(strong,nonatomic)NSMutableArray *imageSnippets;

@end
@implementation LScreenShot
-(id)init
{
    self=[super init];
    if(self){
        _imageSnippets=[[NSMutableArray alloc] init];
    }
    return self;
}
+ (UIImage*)screenShotWithView:(UIView*)view size:(CGSize)size
{
    CGSize newSize=CGSizeZero;
    newSize.width=size.width==0?view.bounds.size.width:size.width;
    newSize.height=size.height==0?view.bounds.size.height:size.height;
    UIGraphicsBeginImageContextWithOptions(newSize,NO,2);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *imageTem = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return imageTem;
}


+(UIImage *)scaleToSize:(UIImage *)image CGRect:(CGRect)rect
{
    //创建一个bitmap的context
    //并把他设置成当前的context
    UIGraphicsBeginImageContext(rect.size);
    //绘制图片的大小
    [image drawInRect:CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height)];
    //从当前context中创建一个改变大小后的图片
    UIImage *endImage=UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return endImage;
}

//获得某个范围内的屏幕图像  但周边会有透明的视图
+ (UIImage *)imageFromView: (UIView *) theView   atFrame:(CGRect)r
{
//    UIGraphicsBeginImageContext(theView.frame.size);
    UIGraphicsBeginImageContextWithOptions(theView.frame.size, YES, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    UIRectClip(r);
    [theView.layer renderInContext:context];
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return  theImage;//[self getImageAreaFromImage:theImage atFrame:r];
}
//裁剪某个范围内的屏幕图像  至尺寸
+ (UIImage *)cropImageFrom:(UIView *)aView inRect:(CGRect)rect
{
    CGSize cropImageSize = rect.size;
    //    UIGraphicsBeginImageContext(cropImageSize);
    UIGraphicsBeginImageContextWithOptions(cropImageSize, YES, [UIScreen mainScreen].scale);
    CGContextRef resizedContext = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(resizedContext, -(rect.origin.x), -(rect.origin.y));
    [aView.layer renderInContext:resizedContext];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

//旋转图片
+ (UIImage *)image:(UIImage *)image rotation:(UIImageOrientation)orientation
{
    long double rotate = 0.0;
    CGRect rect;
    float translateX = 0;
    float translateY = 0;
    float scaleX = 1.0;
    float scaleY = 1.0;
    
    switch (orientation) {
        case UIImageOrientationLeft:
            rotate = M_PI_2;
            rect = CGRectMake(0, 0, image.size.height, image.size.width);
            translateX = 0;
            translateY = -rect.size.width;
            scaleY = rect.size.width/rect.size.height;
            scaleX = rect.size.height/rect.size.width;
            break;
        case UIImageOrientationRight:
            rotate = 33 * M_PI_2;
            rect = CGRectMake(0, 0, image.size.height, image.size.width);
            translateX = -rect.size.height;
            translateY = 0;
            scaleY = rect.size.width/rect.size.height;
            scaleX = rect.size.height/rect.size.width;
            break;
        case UIImageOrientationDown:
            rotate = M_PI;
            rect = CGRectMake(0, 0, image.size.width, image.size.height);
            translateX = -rect.size.width;
            translateY = -rect.size.height;
            break;
        default:
            rotate = 0.0;
            rect = CGRectMake(0, 0, image.size.width, image.size.height);
            translateX = 0;
            translateY = 0;
            break;
    }
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    //做CTM变换
    CGContextTranslateCTM(context, 0.0, rect.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextRotateCTM(context, rotate);
    CGContextTranslateCTM(context, translateX, translateY);
    
    CGContextScaleCTM(context, scaleX, scaleY);
    //绘制图片
    CGContextDrawImage(context, CGRectMake(0, 0, rect.size.width, rect.size.height), image.CGImage);
    
    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
    
    return newPic;
}
@end

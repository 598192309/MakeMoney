//
//  UIImage+LqExtension.m
//  LqTool
//
//  Created by lqq on 2019/12/20.
//  Copyright © 2019 lqq. All rights reserved.
//

#import "UIImage+LqExtension.h"


@implementation UIImage (LqExtension)


/**
 根据颜色 和 size 制作图片
 */
+ (UIImage *)lq_imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}


/**
 渲染成原图
 */
+ (UIImage *)lq_originImageWithImageName:(NSString *)imageName
{
    return [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}


+ (UIImage*) lq_imageWithUIView:(UIView*) view{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 3);
    CGContextRef currnetContext = UIGraphicsGetCurrentContext();
    //[view.layer drawInContext:currnetContext];
    [view.layer renderInContext:currnetContext];
    // 从当前context中创建一个改变大小后的图片
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    return image;
}


+ (UIImage*)lq_getCaptureWithScrollView:(UIScrollView *)scrollView
{
    
    UIImage* viewImage = nil;
    UIGraphicsBeginImageContextWithOptions(scrollView.contentSize, scrollView.opaque, 0.0);
    {
        CGPoint savedContentOffset = scrollView.contentOffset;
        CGRect savedFrame = scrollView.frame;
        
        scrollView.contentOffset = CGPointZero;
        scrollView.frame = CGRectMake(0, 0, scrollView.contentSize.width, scrollView.contentSize.height);
        
        [scrollView.layer renderInContext: UIGraphicsGetCurrentContext()];
        viewImage = UIGraphicsGetImageFromCurrentImageContext();
        
        scrollView.contentOffset = savedContentOffset;
        scrollView.frame = savedFrame;
    }
    UIGraphicsEndImageContext();
    
    return viewImage;
}


+ (UIImage *) lq_combineWithTopImg:(UIImage*)topImage bottomImg:(UIImage*)bottomImage withMargin:(NSInteger)margin{
    if (bottomImage == nil) {
        return topImage;
    }
    CGFloat width = topImage.size.width;
    CGFloat bottomImageHeight = topImage.size.width * ( bottomImage.size.height / bottomImage.size.width);
    CGFloat height = topImage.size.height + bottomImageHeight + margin;
    CGSize offScreenSize = CGSizeMake(width, height);
    
    // UIGraphicsBeginImageContext(offScreenSize);用这个重绘图片会模糊
    UIGraphicsBeginImageContextWithOptions(offScreenSize, NO, [UIScreen mainScreen].scale);
    
    CGRect rectTop = CGRectMake(0, 0, topImage.size.width, topImage.size.height);
    [topImage drawInRect:rectTop];
    
    CGRect rectBottom = CGRectMake(0 , rectTop.size.height + margin ,topImage.size.width , bottomImageHeight );
    [bottomImage drawInRect:rectBottom];
    
    UIImage* imagez = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return imagez;
}


/**
 压缩图片
 */
+ (NSData *)lq_compressImage:(UIImage *)image toByte:(NSUInteger)maxLength {
    // Compress by quality
    CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(image, compression);
    if (data.length < maxLength) return data;
    
    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i < 6; ++i) {
        compression = (max + min) / 2;
        data = UIImageJPEGRepresentation(image, compression);
        if (data.length < maxLength * 0.9) {
            min = compression;
        } else if (data.length > maxLength) {
            max = compression;
        } else {
            break;
        }
    }
    UIImage *resultImage = [UIImage imageWithData:data];
    if (data.length < maxLength)
    {
        return data;
    }
    
    // Compress by size
    NSUInteger lastDataLength = 0;
    while (data.length > maxLength && data.length != lastDataLength) {
        lastDataLength = data.length;
        CGFloat ratio = (CGFloat)maxLength / data.length;
        CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)),
                                 (NSUInteger)(resultImage.size.height * sqrtf(ratio))); // Use NSUInteger to prevent white blank
        UIGraphicsBeginImageContext(size);
        [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
        resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        data = UIImageJPEGRepresentation(resultImage, compression);
    }
    
    return data;
}


// 64base字符串转图片

+ (UIImage *)base64stringToImage:(NSString *)str {

    NSData * imageData =[[NSData alloc] initWithBase64EncodedString:SAFE_NIL_STRING(str) options:NSDataBase64DecodingIgnoreUnknownCharacters];

    UIImage *photo = [UIImage imageWithData:imageData ];

    return photo;

}
// 图片转64base字符串

+ (NSString *)imageToBase64String:(UIImage *)image{
    NSData *imagedata = UIImagePNGRepresentation(image);

    NSString *image64 = [imagedata base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];

    return image64;
}

/**
 *  根据图片url获取图片尺寸
 */
+ (CGSize)getImageSizeWithURL:(id)URL{
    NSURL * url = nil;
    if ([URL isKindOfClass:[NSURL class]]) {
        url = URL;
    }
    if ([URL isKindOfClass:[NSString class]]) {
        url = [NSURL URLWithString:URL];
    }
    if (!URL) {
        return CGSizeZero;
    }
    CGImageSourceRef imageSourceRef =     CGImageSourceCreateWithURL((CFURLRef)url, NULL);
    CGFloat width = 0, height = 0;
    if (imageSourceRef) {
        CFDictionaryRef imageProperties = CGImageSourceCopyPropertiesAtIndex(imageSourceRef, 0, NULL);
      if (imageProperties != NULL) {
          CFNumberRef widthNumberRef = CFDictionaryGetValue(imageProperties, kCGImagePropertyPixelWidth);
          if (widthNumberRef != NULL) {
              CFNumberGetValue(widthNumberRef, kCFNumberFloat64Type, &width);
          }
          CFNumberRef heightNumberRef = CFDictionaryGetValue(imageProperties, kCGImagePropertyPixelHeight);
          if (heightNumberRef != NULL) {
            CFNumberGetValue(heightNumberRef, kCFNumberFloat64Type, &height);
        }
        CFRelease(imageProperties);
    }
    CFRelease(imageSourceRef);
    }
    return CGSizeMake(width, height);
}

//生成二维码
+ (UIImage *)generateQRCodeWithString:(NSString *)string Size:(CGFloat)size
{
    //创建过滤器
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    //过滤器恢复默认
    [filter setDefaults];
    //给过滤器添加数据<字符串长度893>
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    [filter setValue:data forKey:@"inputMessage"];
    //获取二维码过滤器生成二维码
    CIImage *image = [filter outputImage];
    UIImage *img = [self createNonInterpolatedUIImageFromCIImage:image WithSize:size];
    return img;
}

//二维码清晰
+ (UIImage *)createNonInterpolatedUIImageFromCIImage:(CIImage *)image WithSize:(CGFloat)size
{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    //创建bitmap
    size_t width = CGRectGetWidth(extent)*scale;
    size_t height = CGRectGetHeight(extent)*scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    //保存图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}

/**   生成带icon的二维码 */
+ (UIImage *)generateIconQRCodeWithString:(NSString *)string Size:(CGFloat)size icon:(UIImage *)icon{
    UIImage *img = [self generateQRCodeWithString:string Size:size];
    //5.把中央图片划入二维码里面
    //5.1开启图形上下文
    UIGraphicsBeginImageContext(img.size);
    //5.2将二维码的图片画入
    [img drawInRect:CGRectMake(0, 0, img.size.width, img.size.height)];
    UIImage *centerImg = icon;
    CGFloat centerW=img.size.width*0.3;
    CGFloat centerH=centerW;
    CGFloat centerX=(img.size.width-centerW)*0.5;
    CGFloat centerY=(img.size.height -centerH)*0.5;
    [centerImg drawInRect:CGRectMake(centerX, centerY, centerW, centerH)];
    //5.3获取绘制好的图片
    UIImage *finalImg=UIGraphicsGetImageFromCurrentImageContext();
    //5.4关闭图像上下文
    UIGraphicsEndImageContext();
    return finalImg;
}
@end

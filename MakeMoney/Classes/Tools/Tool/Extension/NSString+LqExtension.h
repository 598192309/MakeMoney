//
//  NSString+LqExtension.h
//  LqTool
//
//  Created by lqq on 2019/12/20.
//  Copyright © 2019 lqq. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (LqExtension)
/**
 *  @brief  根据字符串的宽(或高)和字体的大小计算字符串的size
 *  @param  size 给定字符串的宽或高
 *  @param  font 字体属性
 *  @return 字符串的宽和高
 */
- (CGSize)lq_boundingRectWithSize:(CGSize)size font:(UIFont *)font;

/**
 根据字符串的宽(或高)和字体的大小,字体的行间距计算字符串的size
 
 @param size 字符串的宽(或高)
 @param font 字体的大小
 @param lineSpacing 字体的行间距
 @return 字符串的size
 */
- (CGSize)lq_boundingRectWithSize:(CGSize)size font:(UIFont *)font lineSpacing:(CGFloat)lineSpacing;

/**
 根据字符串的宽(或高)和属性计算字符串的size
 
 @param size 给定字符串的宽或高
 @param attr 字体属性
 @return 字符串的宽和高
 */
- (CGSize)lq_boundingRectWithSize:(CGSize)size attr:(NSDictionary *)attr;

/**
 判断字符串是否包含emoji表情

 @param string 字符串
 @return bool 值
 */
+ (BOOL)lq_stringContainsEmoji:(NSString *)string;


/**
 过滤HTML标签
 */
+ (NSString *)lq_filterHTML:(NSString *)html;

/**
 *  汉字的拼音
 *
 *  @return 拼音
 */
- (NSString *)lq_pinyin;


/**
 *  截取URL中的参数
 *
 *  @return NSMutableDictionary parameters
 */
- (NSMutableDictionary *)lq_getURLParameters;

/**
 *  设置行间距和字间距
 *
 *  @param lineSpace 行间距
 *  @param kern      字间距
 *
 *  @return 富文本
 */
-(NSAttributedString*)lq_getAttributedStringWithLineSpace:(CGFloat)lineSpace kern:(CGFloat)kern;


/**
 *  设置行间距和字间距
 *
 *  @param lineSpace 行间距
 *  @param kern      字间距
 *
 *  @return 富文本
 */
-(NSAttributedString*)lq_getAttributedStringWithLineSpace:(CGFloat)lineSpace kern:(CGFloat)kern aliment:(NSTextAlignment)alignment;

//处理时间
- (NSString *)lq_dealTimeFormarter:(NSString *)formater changeFormater:(NSString *)changeFormater;

/**
 *  获取当天的年月日的字符串
 *  这里测试用
 *  @return 格式为年-月-日
 */
+(NSString *)lq_getyyyymmdd:(NSString *)formater;
#pragma mark --- 将时间转换成时间戳
/**将时间转换成时间戳*/
- (NSString *)lq_getTimestampFromTimeWithFormatter:(NSString *)fmt;
#pragma mark ---- 将时间戳转换成时间
/**将时间戳转换成时间*/
- (NSString *)lq_getTimeFromTimestampWithFormatter:(NSString *)fmt;
@end

NS_ASSUME_NONNULL_END

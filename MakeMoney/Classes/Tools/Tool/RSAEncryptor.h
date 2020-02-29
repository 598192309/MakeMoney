//
//  RSAEncryptor.h
//  FullShareTop
//
//  Created by lqq on 17/3/23.
//  Copyright © 2017年 FSB. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSAEncryptor : NSObject


/**
 *  MD5加密
 *
 *  @param string 加密字符串
 *
 *  @return 密文
 */
+ (NSString *)MD5WithString:(NSString *)string;

/**
 *  加密方法
 *
 *  @param str   需要加密的字符串
 *  @param path  '.der'格式的公钥文件路径
 */
+ (NSString *)encryptString:(NSString *)str publicKeyWithContentsOfFile:(NSString *)path;

/**
 *  解密方法
 *
 *  @param str       需要解密的字符串
 *  @param path      '.p12'格式的私钥文件路径
 *  @param password  私钥文件密码
 */
+ (NSString *)decryptString:(NSString *)str privateKeyWithContentsOfFile:(NSString *)path password:(NSString *)password;

/**
 *  加密方法
 *
 *  @param str    需要加密的字符串
 *  @param pubKey 公钥字符串
 */
+ (NSString *)encryptString:(NSString *)str publicKey:(NSString *)pubKey;

/**
 *  解密方法
 *
 *  @param str     需要解密的字符串
 *  @param privKey 私钥字符串
 */
+ (NSString *)decryptString:(NSString *)str privateKey:(NSString *)privKey;




//3DES加密
+ (NSString *)encodeDesWithString:(NSString *)str;

//3DES解密
+ (NSString *)decodeDesWithString:(NSString *)str;


@end

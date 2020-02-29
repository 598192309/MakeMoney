//
//  LqSandBox.h
//  LqTool
//
//  Created by lqq on 2019/12/20.
//  Copyright © 2019 lqq. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LqSandBox : NSObject
+ (NSString *)appPath;          // 程序目录，不能存任何东西
+ (NSString *)docPath;          // 文档目录，用户创建内容，需要ITUNES同步备份的数据存这里（ITUNES 同步）(不再使用)
+ (NSString *)docDownloadImagePath;    // 图片下载的目录
+ (NSString *)libPrefPath;      // 配置目录，置文件存这里 （ITUNES 同步）NSUserDefault所在路径
+ (NSString *)libCachePath;     // 缓存目录，系统永远不会删除这里的文件，（ITUNES 不同步）(不再使用)
+ (NSString *)libSTCachePath;    // 自己代码创建的缓存目录，系统永远不会删除这里的文件，（ITUNES 不同步）
+ (NSString *)tmpPath;          // 缓存目录，APP退出后，系统可能会删除这里的内容（ITUNES 不同步）
+ (NSString *)libPath;          // Library目录
+ (NSString *)appSupportPath;   //Library/Application Support目录，程序自动设置不备份到iCloud
+ (float)folderSizeAtPath:(NSString *)folderPath;//沙盒文件夹内容大小
+ (long long)fileSizeAtPath:(NSString*)filePath;//单个文件大小
@end


@interface NSString (LqDirectioryAuto)
- (NSString*)lq_subDirectory:(NSString*)name;
@end

NS_ASSUME_NONNULL_END

//
//  NSFileManager+LqExtension.h
//  LqTool
//
//  Created by lqq on 2019/12/20.
//  Copyright © 2019 lqq. All rights reserved.
//




#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSFileManager (LqExtension)
+ (NSArray *)lq_allFilesOfDirectoryAtPath:(NSString *)path error:(NSError **)error;

+ (BOOL)lq_addSkipBackupAttributeToItemAtPath:(NSString *)aPath;

- (BOOL)lq_createDirectoryAtPath:(NSString *)path withIntermediateDirectories:(BOOL)createIntermediates attributes:(nullable NSDictionary *)attributes error:(NSError **)error backup2iCloud:(BOOL)backup;
@end

NS_ASSUME_NONNULL_END

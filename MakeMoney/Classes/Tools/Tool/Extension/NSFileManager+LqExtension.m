//
//  NSFileManager+LqExtension.m
//  LqTool
//
//  Created by lqq on 2019/12/20.
//  Copyright © 2019 lqq. All rights reserved.
//

#import "NSFileManager+LqExtension.h"
#import <sys/xattr.h>
#import <UIKit/UIKit.h>

@implementation NSFileManager (LqExtension)
+ (NSArray *)lq_allFilesOfDirectoryAtPath:(NSString *)path error:(NSError **)error{
    NSMutableArray* array = [NSMutableArray arrayWithCapacity:10];
    NSFileManager* fileMgr = [NSFileManager defaultManager];
    NSArray* tempArray = [fileMgr contentsOfDirectoryAtPath:path error:error];
    for (NSString* fileName in tempArray) {
        BOOL flag = YES;
        NSString* fullPath = [path stringByAppendingPathComponent:fileName];
        if ([fileMgr fileExistsAtPath:fullPath isDirectory:&flag]) {
            if (!flag && fullPath) {
                [array addObject:fullPath];
            }
        }
    }
    return array;
}

+ (BOOL)lq_addSkipBackupAttributeToItemAtPath:(NSString *)aPath
{
    if(![[NSFileManager defaultManager] fileExistsAtPath:aPath]){
        return NO;
    }
    
    NSError *error = nil;
    BOOL success = NO;
    
    NSString *systemVersion = [[UIDevice currentDevice] systemVersion];
    if ([systemVersion floatValue] >= 5.1f)
    {
        success = [[NSURL fileURLWithPath:aPath] setResourceValue:[NSNumber numberWithBool:YES]
                                                           forKey:@"NSURLIsExcludedFromBackupKey"
                                                            error:&error];
    }
    else if ([systemVersion isEqualToString:@"5.0.1"])
    {
        const char* filePath = [aPath fileSystemRepresentation];
        const char* attrName = "com.apple.MobileBackup";
        u_int8_t attrValue = 1;
        
        int result = setxattr(filePath, attrName, &attrValue, sizeof(attrValue), 0, 0);
        success = (result == 0);
    }
    else
    {
        NSLog(@"Can not add 'do no back up' attribute at systems before 5.0.1");
    }
    
    if(!success)
    {
        NSLog(@"Error excluding %@ from backup %@", [aPath lastPathComponent], error);
    }
    
    return success;
}

- (BOOL)lq_createDirectoryAtPath:(NSString *)path withIntermediateDirectories:(BOOL)createIntermediates attributes:(NSDictionary *)attributes error:(NSError **)error backup2iCloud:(BOOL)backup NS_AVAILABLE(10_5, 2_0){
    BOOL bResult = [self createDirectoryAtPath:path withIntermediateDirectories:createIntermediates attributes:attributes error:error];
    if(bResult){
        if(!backup){
            [[self class] lq_addSkipBackupAttributeToItemAtPath:path];
        }
    }
    return bResult;
}

@end

//
//  LqSandBox.m
//  LqTool
//
//  Created by lqq on 2019/12/20.
//  Copyright © 2019 lqq. All rights reserved.
//

#import "LqSandBox.h"
#import "NSFileManager+LqExtension.h"

@implementation NSString(LqDirectioryAuto)
- (NSString*)lq_subDirectory:(NSString*)name
{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    NSString *path=[self stringByAppendingFormat:@"/%@",name];
    BOOL pathIsDirectiory;
    if([fileManager fileExistsAtPath:path isDirectory:&pathIsDirectiory]){
        if(!pathIsDirectiory){
            [fileManager removeItemAtPath:path error:nil];
            [fileManager createDirectoryAtPath:path withIntermediateDirectories:NO attributes:nil error:nil];
        }
    }else{
        [fileManager createDirectoryAtPath:path withIntermediateDirectories:NO attributes:nil error:nil];
    }
    return path;
}
@end


@implementation LqSandBox
+ (NSString *)appPath
{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSApplicationDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}

+ (NSString *)docPath
{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}

+ (NSString *)docRecordPath
{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path=[[paths objectAtIndex:0]  lq_subDirectory:@"FSRecord"];
    return path;
}

+ (NSString *)libPath{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}

+ (NSString *)libPrefPath
{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *path=[[paths objectAtIndex:0] stringByAppendingFormat:@"/Preferences"];
    BOOL pathIsDirectiory;
    if([fileManager fileExistsAtPath:path isDirectory:&pathIsDirectiory]){
        if(!pathIsDirectiory){
            [fileManager removeItemAtPath:path error:nil];
            [fileManager createDirectoryAtPath:path withIntermediateDirectories:NO attributes:nil error:nil];
        }
    }else{
        [fileManager createDirectoryAtPath:path withIntermediateDirectories:NO attributes:nil error:nil];
    }
    return path;
}

+ (NSString *)libCachePath
{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}

+ (NSString *)libSTCachePath
{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *path=[[[paths objectAtIndex:0] lq_subDirectory:@"Caches"] lq_subDirectory:@"STCache"];
    return path;
}

+ (NSString *)tmpPath
{
//    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSApplicationDirectory, NSUserDomainMask, YES);
//    return [[paths objectAtIndex:0] stringByAppendingFormat:@"/tmp"];
    return NSTemporaryDirectory();
}

+ (NSString *)appSupportPath
{
    static NSString * supportPath = nil;
    if(supportPath){
        return supportPath;
    }
    supportPath = [NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSFileManager *fm = [[NSFileManager alloc] init];
    BOOL bIsDirectory = NO;
    BOOL bShouldCreate = NO;
    if([fm fileExistsAtPath:supportPath isDirectory:&bIsDirectory]){
        if(!bIsDirectory){
            [fm removeItemAtPath:supportPath error:nil];
            bShouldCreate = YES;
        }
        else{
            [NSFileManager lq_addSkipBackupAttributeToItemAtPath:supportPath];
        }
    }
    else{
        bShouldCreate = YES;
    }
    if(bShouldCreate){
        [fm lq_createDirectoryAtPath:supportPath withIntermediateDirectories:YES attributes:nil error:nil backup2iCloud:NO];
    }
    return supportPath;
}

@end

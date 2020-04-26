//
//  JKCrashProtect.h
//  Test
//
//  Created by 黎芹 on 2020/4/26.
//  Copyright © 2020 lqq. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JKCrashProtect : NSObject
- (void)JKCrashProtectCollectCrashMessages:(NSString *)crashMessage;
@end

NS_ASSUME_NONNULL_END

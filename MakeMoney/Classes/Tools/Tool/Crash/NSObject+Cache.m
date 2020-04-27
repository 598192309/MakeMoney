//
//  NSObject+Cache.m
//  Test
//
//  Created by 黎芹 on 2020/4/26.
//  Copyright © 2020 lqq. All rights reserved.
//

#import "NSObject+Cache.h"

#import "JKCrashProtect.h"


@implementation NSObject (Cache)
//-(id)forwardingTargetForSelector:(SEL)aSelector{
////将重向定后的消息接者收置为nil
//    return nil;
//}
//
//- (void)forwardInvocation:(NSInvocation *)anInvocation{
//   //将此方法进行重写，在里这不进行任何操作，屏蔽会产生crash的方法调用
//}
//
//- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
//    NSString *methodName =NSStringFromSelector(aSelector);
//    if ([methodName hasPrefix:@"_"]) {//对私有方法不进行crash日志采集操作
//        return nil;
//    }
//    NSString *crashMessages = [NSString stringWithFormat:@"JKCrashProtect: [%@ %@]: unrecognized selector sent to instance",self,NSStringFromSelector(aSelector)];
//    NSMethodSignature *signature = [JKCrashProtect instanceMethodSignatureForSelector:@selector(JKCrashProtectCollectCrashMessages:)];
//    [[JKCrashProtect new] JKCrashProtectCollectCrashMessages:crashMessages];
//    return signature;//对methodSignatureForSelector 进行重写，不然不会调用forwardInvocation方法
//}
@end

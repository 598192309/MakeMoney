//
//  NSError+LqExtension.m
//  LqTool
//
//  Created by lqq on 2019/12/20.
//  Copyright © 2019 lqq. All rights reserved.
//

#import "NSError+LqExtension.h"

@implementation NSError (LqExtension)
+(NSError*)lq_errorWithMsg:(NSString*)msg
                 domain:(NSString *)domain
                   code:(NSInteger)code{
    if(msg==nil){
        msg=@"";
    }
    if(domain==nil){
        domain=@"";
    }
    return [NSError errorWithDomain:domain code:code userInfo:@{@"errorMsg":msg}];
}

-(NSString*)lq_errorMsg{
    if ([self.userInfo isKindOfClass:[NSDictionary class]]) {
        id value = [self.userInfo objectForKey:@"errorMsg"];
        if (![value isKindOfClass:[NSNull class]]) {
            return value;
        }
    }
    
    return nil;
}

@end

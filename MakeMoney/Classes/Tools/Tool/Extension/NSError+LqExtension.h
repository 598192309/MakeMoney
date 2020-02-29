//
//  NSError+LqExtension.h
//  LqTool
//
//  Created by lqq on 2019/12/20.
//  Copyright © 2019 lqq. All rights reserved.
//


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSError (LqExtension)
+(NSError*)lq_errorWithMsg:(NSString*)msg
                 domain:(NSString *)domain
                   code:(NSInteger)code;

-(NSString*)lq_errorMsg;
@end

NS_ASSUME_NONNULL_END

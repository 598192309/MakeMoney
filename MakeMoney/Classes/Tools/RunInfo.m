//
//  RunInfo.m
//  stock
//
//  Created by Jaykon on 14-2-9.
//  Copyright (c) 2014年 Maxicn. All rights reserved.
//



#import "RunInfo.h"

@interface RunInfo()

@end

@implementation RunInfo{
    BOOL _isSMSSDKRegisted;
    BOOL _isWeChatRegisted;
}




+ (RunInfo *)sharedInstance
{
    static dispatch_once_t t;
    static RunInfo *sharedInstance = nil;
    dispatch_once(&t, ^{
        sharedInstance = [[RunInfo alloc] init];
    });
    return sharedInstance;
}


- (id)init
{
    self = [super init];
    if (self){
        
       
        
        _is_logined = [[NSUserDefaults standardUserDefaults ] objectForKey:kUserSignIn] ? [[[NSUserDefaults standardUserDefaults ] objectForKey:kUserSignIn] boolValue] : false;
        

    }
    return self;
}




-(void)setIs_logined:(BOOL)is_logined{
    _is_logined = is_logined;
    [[NSUserDefaults standardUserDefaults] setBool:is_logined forKey:kUserSignIn];
}




@end

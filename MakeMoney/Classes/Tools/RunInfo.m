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
        
        _tradeNo = [[NSUserDefaults standardUserDefaults ] objectForKey:kTradeNo] ? [[NSUserDefaults standardUserDefaults ] objectForKey:kTradeNo] : @"";

        _basicItemJasonStr = [[NSUserDefaults standardUserDefaults ] objectForKey:kBasicItemJasonStr] ? [[NSUserDefaults standardUserDefaults ] objectForKey:kBasicItemJasonStr] : @"";
        _infoInitItemJasonStr = [[NSUserDefaults standardUserDefaults ] objectForKey:kInfoInitItemJasonStr] ? [[NSUserDefaults standardUserDefaults ] objectForKey:kInfoInitItemJasonStr] : @"";
        
        _yaoqingren_code = [[NSUserDefaults standardUserDefaults ] objectForKey:kYaoqingrenCode] ? [[NSUserDefaults standardUserDefaults ] objectForKey:kYaoqingrenCode] : @"";

        _shallinstallCode = [[NSUserDefaults standardUserDefaults ] objectForKey:kShallInstallCode] ? [[NSUserDefaults standardUserDefaults ] objectForKey:kShallInstallCode] : @"";


    }
    return self;
}




-(void)setIs_logined:(BOOL)is_logined{
    _is_logined = is_logined;
    [[NSUserDefaults standardUserDefaults] setBool:is_logined forKey:kUserSignIn];
    [[NSUserDefaults standardUserDefaults] synchronize];

}

- (void)setTradeNo:(NSString *)tradeNo{
    _tradeNo = tradeNo;
    [[NSUserDefaults standardUserDefaults] setObject:tradeNo forKey:kTradeNo];
    [[NSUserDefaults standardUserDefaults] synchronize];

}

- (void)setBasicItemJasonStr:(NSString *)basicItemJasonStr{
    _basicItemJasonStr = basicItemJasonStr;
    [[NSUserDefaults standardUserDefaults] setObject:basicItemJasonStr forKey:kBasicItemJasonStr];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setInfoInitItemJasonStr:(NSString *)infoInitItemJasonStr{
    _infoInitItemJasonStr = infoInitItemJasonStr;
    [[NSUserDefaults standardUserDefaults] setObject:infoInitItemJasonStr forKey:kInfoInitItemJasonStr];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setYaoqingren_code:(NSString *)yaoqingren_code{
    _yaoqingren_code = yaoqingren_code;
    [[NSUserDefaults standardUserDefaults] setObject:yaoqingren_code forKey:kYaoqingrenCode];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setShallinstallCode:(NSString *)shallinstallCode{
    _shallinstallCode = shallinstallCode;
    [[NSUserDefaults standardUserDefaults] setObject:shallinstallCode forKey:kShallInstallCode];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
@end

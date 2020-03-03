//
//  LSVProgressHUD.m
//  xskj
//
//  Created by 黎芹 on 16/5/9.
//  Copyright © 2016年 lq. All rights reserved.
//

#import "LSVProgressHUD.h"
#import "SVProgressHUD.h"
@implementation LSVProgressHUD

+ (void)load{
//    [self setMinimumDismissTimeInterval:1.0];
    [self setMinimumDismissTimeInterval:MAXFLOAT];
    
    [self setDefaultStyle:SVProgressHUDStyleCustom];
    
//    [self setBackgroundLayerColor:[UIColor colorWithHexString:viewBackgroundColor alpha:1.0]];
    [self setForegroundColor:[UIColor whiteColor]];
    //设置不可交换 
//    [self setDefaultMaskType:SVProgressHUDMaskTypeClear];
    //设置可交互  #121719 (60%)
    [self setDefaultMaskType:SVProgressHUDMaskTypeNone];
    self.imageViewSize = CGSizeMake(AdaptedWidth(45), AdaptedWidth(45));
//    self.backgroundColor = [UIColor colorWithHexString:@"#14181a"];
    self.backgroundColor = [UIColor lq_colorWithHexString:@"#14181A" alpha:0.85];

    [self setInfoImage:nil];
    
//    [self setDefaultStyle:SVProgressHUDStyleDark];


}

+ (void)show {
//    NSMutableArray *images = [NSMutableArray array];
//
//    for (int i = 0 ; i < 26; i ++) {
//        [images addObject:[UIImage imageNamed:[NSString stringWithFormat:@"合成 1_000%02d",i]]];
//    }
//
//    UIImage * animatedImage = [UIImage animatedImageWithImages:images duration:2.0];
//
//    [self showImage:animatedImage status:nil];
    [SVProgressHUD show];
}


+ (void)showError:(NSError *)error{
    NSString *errStr = [error.userInfo safeObjectForKey:@"errorMsg"];
    if (errStr.length > 0 && ![errStr isEqualToString:NSLocalizedString(@"任务被取消", nil)]  && ![errStr isEqualToString:NSLocalizedString(@"已取消", nil)] && ![errStr containsString:NSLocalizedString(@"如非本人操作", nil)]) {
        [self showInfoWithStatus:[error.userInfo safeObjectForKey:@"errorMsg"]];
        [self dismissTime];
    }else{
        [self dismiss];
    }
}

+(void)showInfoWithStatus:(NSString *)status{
    if (status.length > 0) {
        [super showInfoWithStatus:status];
        [self dismissTime];
    }else{
        [self dismiss];
    }
}
+(void)showWithStatus:(NSString *)status{
    [super showWithStatus:status];
    [self dismissTime];
}
+(void)showErrorWithStatus:(NSString *)status{
    [super showErrorWithStatus:status];
    [self dismissTime];
}
+(void)dismissTime{
    [self dismissWithDelay:2.f];
}
@end

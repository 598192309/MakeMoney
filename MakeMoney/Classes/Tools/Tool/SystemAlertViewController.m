//
//  FSAlertViewController.m
//  fullsharetop
//
//  Created by lqq on 16/11/1.
//  Copyright © 2016年 lqq. All rights reserved.
//

#import "SystemAlertViewController.h"
#import "LqToolKit.h"

@interface SystemAlertViewController () <UIAlertViewDelegate>
@property (nonatomic, copy) void(^cancleBlock)(void);
@property (nonatomic, copy) void(^commitBlock)(void);

@end
@implementation SystemAlertViewController
+ (instancetype)alertViewControllerWithTitle:(NSString *)title
                                     message:(NSString *)message
                           cancleButtonTitle:(NSString *)cancleButtonTitle
                           commitButtonTitle:(NSString *)commitButtonTitle
                                 cancleBlock:(void(^)(void))cancleBlock
                                 commitBlock:(void(^)(void))commitBlock
{
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    if (cancleButtonTitle.length > 0) {
        [alertVC addAction:[UIAlertAction actionWithTitle:cancleButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            if (cancleBlock) {
                cancleBlock();
            }
        }]];
    }
    
    if (commitButtonTitle.length > 0) {
        [alertVC addAction:[UIAlertAction actionWithTitle:commitButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (commitBlock) {
                commitBlock();
            }
        }]];
    }
    
    UIViewController *topVC = [LqToolKit topViewController];
    [topVC presentViewController:alertVC animated:YES completion:nil];
    
    
#else
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:cancleButtonTitle otherButtonTitles:@[commitButtonTitle], nil];
    [alertView show];
    
#endif
    
    return nil;
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0 ) {
        if (_cancleBlock) {
            _cancleBlock();
        }
    } else if (buttonIndex == 1) {
        if (_commitBlock) {
            _commitBlock();
        }
    }
}
@end

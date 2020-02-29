//
//  FSAlertViewController.h
//  fullsharetop
//
//  Created by lqq on 16/11/1.
//  Copyright © 2016年 lqq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SystemAlertViewController : NSObject
+ (instancetype)alertViewControllerWithTitle:(NSString *)title
                                     message:(NSString *)message
                           cancleButtonTitle:(NSString *)cancleButtonTitle
                           commitButtonTitle:(NSString *)commitButtonTitle
                                 cancleBlock:(void(^)(void))cancleBlock
                                 commitBlock:(void(^)(void))commitBlock;
@end

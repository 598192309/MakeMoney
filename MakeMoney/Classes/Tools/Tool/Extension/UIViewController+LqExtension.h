//
//  UIViewController+LqExtension.h
//  LqTool
//
//  Created by lqq on 2019/12/20.
//  Copyright © 2019 lqq. All rights reserved.
//



#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^PopBlock)(UIBarButtonItem *backItem);

@interface UIViewController (LqExtension)
- (void)lq_setBackButtonWithImageName:(NSString *)imageName;

-(void)lq_dismissAutomatically;

-(void)lq_setLeftBarButtonWithImageName:(NSString *)imageName target:(id)aTarget action:(SEL)aAction;
-(void)lq_setRightBarButtonWithImageName:(NSString *)imageName target:(id)aTarget action:(SEL)aAction;
-(void)lq_setRightBarButtonWithTitle:(NSString *)title target:(id)aTarget action:(SEL)aAction;

- (void)lq_popSelfDelayTime:(CGFloat)delayTime;

- (void)lq_popControllers:(NSArray *)controllers delayTime:(CGFloat)delayTime;

- (BOOL)needHideNav;
@property(nonatomic,copy)PopBlock popBlock;


+ (UIViewController*)topViewController;
+(UIViewController*)topViewControllerWithRootViewController:(UIViewController*)rootViewController;


- (void)popSelfDelayTime:(CGFloat)delayTime;
- (void)popControllers:(NSArray *)controllers delayTime:(CGFloat)delayTime;
@end

NS_ASSUME_NONNULL_END

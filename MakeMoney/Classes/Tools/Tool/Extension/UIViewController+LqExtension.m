//
//  UIViewController+LqExtension.m
//  LqTool
//
//  Created by lqq on 2019/12/20.
//  Copyright © 2019 lqq. All rights reserved.
//

#import "UIViewController+LqExtension.h"
#import "UIImage+LqExtension.h"
#import <objc/runtime.h>
static char popBlockKey;

@implementation UIViewController (LqExtension)
-(void)lq_setBackButtonWithImageName:(NSString *)imageName
{
    if (self.navigationController.viewControllers.count < 2) {
        return;
    }
    [self lq_setLeftBarButtonWithImageName:imageName target:self action:@selector(lq_dismissAutomatically)];
}


-(void)lq_dismissAutomatically
{
    if([self.navigationController.viewControllers count]>1){
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

-(void)lq_setLeftBarButtonWithImageName:(NSString *)imageName target:(id)aTarget action:(SEL)aAction
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[UIImage lq_originImageWithImageName:imageName] style:UIBarButtonItemStyleDone target:aTarget action:aAction];
    self.navigationItem.leftBarButtonItem = item;
}


-(void)lq_setRightBarButtonWithImageName:(NSString *)imageName target:(id)aTarget action:(SEL)aAction
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[UIImage lq_originImageWithImageName:imageName] style:UIBarButtonItemStyleDone target:aTarget action:aAction];
    self.navigationItem.rightBarButtonItem = item;
}

-(void)lq_setRightBarButtonWithTitle:(NSString *)title target:(id)aTarget action:(SEL)aAction
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStyleDone target:aTarget action:aAction];
    self.navigationItem.rightBarButtonItem = item;
}



- (void)lq_popSelfDelayTime:(CGFloat)delayTime
{
    __weak __typeof (self)weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSMutableArray *marr = [[NSMutableArray alloc]initWithArray:weakSelf.navigationController.viewControllers];
        [marr removeObject:weakSelf];
        weakSelf.navigationController.viewControllers = marr;
    });
}

- (void)lq_popControllers:(NSArray *)controllers delayTime:(CGFloat)delayTime
{
    __weak __typeof (self)weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSMutableArray *marr = [[NSMutableArray alloc]initWithArray:weakSelf.navigationController.viewControllers];
        for (UIViewController *vc in controllers) {
            [marr removeObject:vc];
        }
        weakSelf.navigationController.viewControllers = marr;
    });
}

- (BOOL)needHideNav {
    return NO;
}
/**
 获取最顶层的视图控制器
 不论中间采用了 push->push->present还是present->push->present,或是其它交互
 */
+ (UIViewController*)topViewController {
    return [self topViewControllerWithRootViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
}
+ (UIViewController*)topViewControllerWithRootViewController:(UIViewController*)rootViewController {
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController* tabBarController = (UITabBarController*)rootViewController;
        return [self topViewControllerWithRootViewController:tabBarController.selectedViewController];
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController* nav = (UINavigationController*)rootViewController;
        return [self topViewControllerWithRootViewController:nav.visibleViewController];
    } else if (rootViewController.presentedViewController) {
        UIViewController* presentedViewController = rootViewController.presentedViewController;
        return [self topViewControllerWithRootViewController:presentedViewController];
    } else {
        return rootViewController;
    }
}
-(void)setPopBlock:(PopBlock)popBlock{
    objc_setAssociatedObject(self, &popBlockKey, popBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(PopBlock)popBlock{
    
    PopBlock popBlock = objc_getAssociatedObject(self, &popBlockKey);
    
    return popBlock;
}
@end

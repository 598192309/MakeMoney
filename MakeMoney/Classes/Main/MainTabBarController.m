//
//  MainTabBarController.m
//  IUang
//
//  Created by jayden on 2018/4/17.
//  Copyright © 2018年 jayden. All rights reserved.
//

#import "MainTabBarController.h"
#import "SDImageCache.h"
#import "BaseNavigationController.h"

#import "HomeViewController.h"
#import "MineViewController.h"
#import "LorginViewController.h"
#import "CustomAlertView.h"
#import "CityViewController.h"
#import "ZhuanTiViewController.h"
#import "AVViewController.h"


@interface MainTabBarController ()<UITabBarControllerDelegate>

@end

@implementation MainTabBarController




// 是否支持自动转屏
- (BOOL)shouldAutorotate {
    return NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    HomeViewController *vc1 = [[HomeViewController alloc] init];
    [self addChildViewController:vc1 withImageName:@"home" selectedImageName:@"home" withTittle:lqLocalized(@"首页",nil)];
    
    ZhuanTiViewController *vc2 = [[ZhuanTiViewController alloc] init];
    [self addChildViewController:vc2 withImageName:@"setup" selectedImageName:@"setup" withTittle:lqStrings(@"专题")];

    AVViewController *vc3 = [[AVViewController alloc] init];
    [self addChildViewController:vc3 withImageName:@"user" selectedImageName:@"user" withTittle:lqLocalized(@"AV",nil)];
    
    CityViewController *vc4 = [[CityViewController alloc] init];
    [self addChildViewController:vc4 withImageName:@"user" selectedImageName:@"user" withTittle:lqLocalized(@"同城",nil)];
    
    MineViewController *vc5 = [[MineViewController alloc] init];
    [self addChildViewController:vc5 withImageName:@"user" selectedImageName:@"user" withTittle:lqLocalized(@"我的",nil)];
    
    [self setupBasic];
    self.delegate = self;

}



-(void)setupBasic {
    
    self.tabBar.barTintColor = ThemeBlackColor;
    [UIApplication sharedApplication].applicationSupportsShakeToEdit = YES;
    [self becomeFirstResponder];

}

-(void)dealloc {
    
}

#pragma mark - act

- (void)addChildViewController:(UIViewController *)controller withImageName:(NSString *)imageName selectedImageName:(NSString *)selectImageName withTittle:(NSString *)tittle{
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:controller];
    
    UIImage * image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage * selectImage = [[UIImage imageNamed:selectImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    [nav.tabBarItem setImage:image];
    [nav.tabBarItem setSelectedImage:selectImage];

    [nav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:AdaptedFontSize(15)} forState:UIControlStateSelected];
    
    [nav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:TitleGrayColor,NSFontAttributeName:AdaptedFontSize(15)} forState:UIControlStateNormal];
    
    nav.tabBarItem.title = tittle;
    //        controller.navigationItem.title = tittle;
    //    controller.title = tittle;//这句代码相当于上面两句代码
    //    [nav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} forState:UIControlStateSelected];
    nav.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -3);
    
    [self addChildViewController:nav];
}
#pragma mark <UITabBarControllerDelegate>
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    NSInteger index = [self.viewControllers indexOfObject:viewController];
//    if (index == 1 && !RI.is_logined) {
//        [AppDelegate presentLoginViewContrller];
//        return NO;
//    }
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [[SDImageCache sharedImageCache] clearMemory];
}

@end

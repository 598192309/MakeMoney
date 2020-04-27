//
//  MainTabBarController.m
//  IUang
//
//  Created by jayden on 2018/4/17.
//  Copyright © 2018年 jayden. All rights reserved.
//

//#import "MainTabBarController.h"
//#import "SDImageCache.h"
//#import "BaseNavigationController.h"
//
//#import "HomeViewController.h"
//#import "MineViewController.h"
//#import "LorginViewController.h"
//#import "CustomAlertView.h"
//#import "CityViewController.h"
//#import "ZhuanTiViewController.h"
//#import "AVViewController.h"
//#import "HomeApi.h"
//#import "HomeItem.h"
//#import "NoticeAlertView.h"
//#import "AblumViewController.h"
//
//@interface MainTabBarController ()<AxcAE_TabBarDelegate>
//@property(nonatomic,strong)NoticeAlertView *infoAlert;//弹窗
//@property (nonatomic,strong)GongGaoItem *gongGaoItem;
//@property (nonatomic,strong)NSMutableArray *tabBarConfs;// 保存构造器的数组
//@property (nonatomic,strong)NSMutableArray *vcs;// 保存构造器的数组
//
//@end
//
//@implementation MainTabBarController
//
//
//
//
//// 是否支持自动转屏
//- (BOOL)shouldAutorotate {
//    return NO;
//}
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//
//    self.tabBarConfs = [NSMutableArray array];
//    self.vcs = [NSMutableArray array];
//
//    HomeViewController *vc1 = [HomeViewController controller];
//    [self addChildViewController:vc1 withImageName:@"home" selectedImageName:@"home" withTittle:lqLocalized(@"首页",nil)];
//
//    ZhuanTiViewController *vc2 = [[ZhuanTiViewController alloc] init];
//    [self addChildViewController:vc2 withImageName:@"" selectedImageName:@"" withTittle:lqStrings(@"专题")];
//
//    AVViewController *vc3 = [[AVViewController alloc] init];
//    [self addChildViewController:vc3 withImageName:@"" selectedImageName:@"" withTittle:lqLocalized(@"AV",nil)];
//
//    AblumViewController *vc5 = [[AblumViewController alloc] init];
//    [self addChildViewController:vc5 withImageName:@"" selectedImageName:@"" withTittle:lqLocalized(@"写真",nil)];
//
//    CityViewController *vc4 = [[CityViewController alloc] init];
//    [self addChildViewController:vc4 withImageName:@"" selectedImageName:@"" withTittle:lqLocalized(@"同城",nil)];
//
//    MineViewController *vc6 = [[MineViewController alloc] init];
//    [self addChildViewController:vc6 withImageName:@"" selectedImageName:@"" withTittle:lqLocalized(@"我的",nil)];
//
//
//    self.viewControllers = self.vcs;
//
//    // 6.2 使用Set方式：
//    self.axcTabBar = [AxcAE_TabBar new] ;
//    self.axcTabBar.backgroundColor = ThemeBlackColor;
//    self.axcTabBar.tabBarConfig = self.tabBarConfs;
//    // 7.设置委托
//    self.axcTabBar.delegate = self;
//    // 8.添加覆盖到上边
//    [self.tabBar addSubview:self.axcTabBar];
//    [self addLayoutTabBar]; // 10.添加适配
//
////    [self setupBasic];
////    self.delegate = self;
//
//    [self requestData];//获取公告
//
//
//}
//
////
////
////-(void)setupBasic {
////
////    self.tabBar.barTintColor = ThemeBlackColor;
////    [UIApplication sharedApplication].applicationSupportsShakeToEdit = YES;
////    [self becomeFirstResponder];
////
////}
////
////-(void)dealloc {
////
////}
//
////- (void)viewDidLoad {
////    [super viewDidLoad];
////    // 添加子VC
////    [self addChildViewControllers];
////}
////- (void)addChildViewControllers{
////    // 创建选项卡的数据 想怎么写看自己，这块我就写笨点了
////    NSArray <NSDictionary *>*VCArray =
////    @[@{@"vc":[UIViewController new],@"normalImg":@"homePage",@"selectImg":@"homePage_select",@"itemTitle":@"AxcUIKit"},
////      @{@"vc":[UIViewController new],@"normalImg":@"task",@"selectImg":@"task_select",@"itemTitle":@"AxcFormList"},
////      @{@"vc":[UIViewController new],@"normalImg":@"complaint",@"selectImg":@"complaint_select",@"itemTitle":@"AE_LineUI"},
////      @{@"vc":[UIViewController new],@"normalImg":@"home_activity",@"selectImg":@"home_activity_select",@"itemTitle":@"AE_PopUI"},
////      @{@"vc":[UIViewController new],@"normalImg":@"me",@"selectImg":@"me_select",@"itemTitle":@"AE_MultiUI"}
////      ,@{@"vc":[UIViewController new],@"normalImg":@"me",@"selectImg":@"me_select",@"itemTitle":@"haha"}
////    ];
////    // 1.遍历这个集合
////    // 1.1 设置一个保存构造器的数组
////    NSMutableArray *tabBarConfs = @[].mutableCopy;
////    // 1.2 设置一个保存VC的数组
////    NSMutableArray *tabBarVCs = @[].mutableCopy;
////    [VCArray enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
////        // 2.根据集合来创建TabBar构造器
////        AxcAE_TabBarConfigModel *model = [AxcAE_TabBarConfigModel new];
////        // 3.item基础数据三连
////        model.itemTitle = [obj objectForKey:@"itemTitle"];
////        model.selectImageName = [obj objectForKey:@"selectImg"];
////        model.normalImageName = [obj objectForKey:@"normalImg"];
////        // 4.设置单个选中item标题状态下的颜色
////        model.selectColor = [UIColor orangeColor];
////
////        // 备注 如果一步设置的VC的背景颜色，VC就会提前绘制驻留，优化这方面的话最好不要这么写
////        // 示例中为了方便就在这写了
////        UIViewController *vc = [obj objectForKey:@"vc"];
////        vc.view.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.f
////                                                  green:arc4random()%255/255.f
////                                                   blue:arc4random()%255/255.f alpha:1];
////        // 5.将VC添加到系统控制组
////        [tabBarVCs addObject:vc];
////        // 5.1添加构造Model到集合
////        [tabBarConfs addObject:model];
////    }];
////    // 5.2 设置VCs -----
////    // 一定要先设置这一步，然后再进行后边的顺序，因为系统只有在setViewControllers函数后才不会再次创建UIBarButtonItem，以免造成遮挡
////    // 大意就是一定要让自定义TabBar遮挡住系统的TabBar
////    self.viewControllers = tabBarVCs;
////    //////////////////////////////////////////////////////////////////////////
////    // 注：这里方便阅读就将AE_TabBar放在这里实例化了 使用懒加载也行
////    // 6.将自定义的覆盖到原来的tabBar上面
////    // 这里有两种实例化方案：
////    // 6.1 使用重载构造函数方式：
//////    self.axcTabBar = [[AxcAE_TabBar alloc] initWithTabBarConfig:tabBarConfs];
////    // 6.2 使用Set方式：
////    self.axcTabBar = [AxcAE_TabBar new] ;
////    self.axcTabBar.tabBarConfig = tabBarConfs;
////    // 7.设置委托
////    self.axcTabBar.delegate = self;
////    // 8.添加覆盖到上边
////    [self.tabBar addSubview:self.axcTabBar];
////    [self addLayoutTabBar]; // 10.添加适配
////}
//// 9.实现代理，如下：
//- (void)axcAE_TabBar:(AxcAE_TabBar *)tabbar selectIndex:(NSInteger)index{
//    // 通知 切换视图控制器
//    [self setSelectedIndex:index];
//    // 自定义的AE_TabBar回调点击事件给TabBarVC，TabBarVC用父类的TabBarController函数完成切换
//}
//- (void)setSelectedIndex:(NSUInteger)selectedIndex{
//    [super setSelectedIndex:selectedIndex];
//    if(self.axcTabBar){
//        self.axcTabBar.selectIndex = selectedIndex;
//    }
//}
//
//// 10.添加适配
//- (void)addLayoutTabBar{
//    // 使用重载viewDidLayoutSubviews实时计算坐标 （下边的 -viewDidLayoutSubviews 函数）
//    // 能兼容转屏时的自动布局
//}
//- (void)viewDidLayoutSubviews{
//    [super viewDidLayoutSubviews];
//    self.axcTabBar.frame = self.tabBar.bounds;
//    [self.axcTabBar viewDidLayoutItems];
//}
//
//#pragma mark - net
////获取公告
//- (void)requestData{
//    __weak __typeof(self) weakSelf = self;
//    [HomeApi requestGongGaoSuccess:^(GongGaoItem * _Nonnull gongGaoItem, NSString * _Nonnull msg) {
//        //type  0  公告，1 图片广告
//        weakSelf.gongGaoItem = gongGaoItem;
//        [weakSelf.infoAlert refreshUIWithItme:gongGaoItem];
//        [[UIApplication sharedApplication].keyWindow addSubview:weakSelf.infoAlert];
//        [weakSelf.infoAlert mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.edges.mas_equalTo([UIApplication sharedApplication].keyWindow);
//        }];
//    } error:^(NSError *error, id resultObject) {
////        [LSVProgressHUD showError:error];
//    }];
//}
//
//#pragma mark - act
//
//- (void)addChildViewController:(UIViewController *)controller withImageName:(NSString *)imageName selectedImageName:(NSString *)selectImageName withTittle:(NSString *)tittle{
//    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:controller];
//
//    UIImage * image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    UIImage * selectImage = [[UIImage imageNamed:selectImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//
////    [nav.tabBarItem setImage:image];
////    [nav.tabBarItem setSelectedImage:selectImage];
////
////    [nav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:AdaptedFontSize(15)} forState:UIControlStateSelected];
////
////    [nav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:TitleGrayColor,NSFontAttributeName:AdaptedFontSize(15)} forState:UIControlStateNormal];
////
////    nav.tabBarItem.title = tittle;
////    //        controller.navigationItem.title = tittle;
////    //    controller.title = tittle;//这句代码相当于上面两句代码
////    //    [nav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} forState:UIControlStateSelected];
////    nav.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -12);
//    //    [self addChildViewController:nav];
//
//    // 2.根据集合来创建TabBar构造器
//     AxcAE_TabBarConfigModel *model = [AxcAE_TabBarConfigModel new];
//     // 3.item基础数据三连
//     model.itemTitle = tittle;
//     model.selectImageName = selectImageName;
//     model.normalImageName = imageName;
//     // 4.设置单个选中item标题状态下的颜色
//     model.selectColor = TitleWhiteColor;
//    model.titleLabel.font = AdaptedFontSize(17);
//    model.icomImgViewSize = CGSizeMake(LQScreemW/6.0, 0);
//
//    [self.vcs addObject:nav];
//    // 5.1添加构造Model到集合
//    [self.tabBarConfs addObject:model];
//
//}
////#pragma mark <UITabBarControllerDelegate>
////- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
////{
////    NSInteger index = [self.viewControllers indexOfObject:viewController];
//////    if (index == 1 && !RI.is_logined) {
//////        [AppDelegate presentLoginViewContrller];
//////        return NO;
//////    }
////    return YES;
////}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    [[SDImageCache sharedImageCache] clearMemory];
//}
//#pragma mark - lazy
//- (NoticeAlertView *)infoAlert{
//    if (_infoAlert == nil) {
//        _infoAlert = [[NoticeAlertView alloc] init];
//
//        __weak __typeof(self) weakSelf = self;
//        _infoAlert.noticeAlertViewRemoveBlock = ^(UIButton * _Nonnull sender) {
//            [weakSelf.infoAlert removeFromSuperview];
//            weakSelf.infoAlert = nil;
//        };
//
//        _infoAlert.noticeAlertViewJumpBlock = ^{
//            NSURL *url = [NSURL URLWithString:weakSelf.gongGaoItem.url];
//            [[UIApplication sharedApplication] openURL:url];
//
//        };
//    }
//
//    return _infoAlert;
//
//}
//@end

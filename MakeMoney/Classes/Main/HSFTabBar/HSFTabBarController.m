//
//  HSFTabBarController.m
//  HCJ
//
//  Created by JuZhenBaoiMac on 2017/7/13.
//  Copyright © 2017年 JuZhenBaoiMac. All rights reserved.
//

#import "HSFTabBarController.h"

#import "HSFTabBar.h"
#import "SDImageCache.h"
#import "BaseNavigationController.h"

#import "HomeViewController.h"
#import "MineViewController.h"
#import "LorginViewController.h"
#import "CustomAlertView.h"
#import "CityViewController.h"
#import "ZhuanTiViewController.h"
#import "AVViewController.h"
#import "HomeApi.h"
#import "HomeItem.h"
#import "NoticeAlertView.h"
#import "AblumViewController.h"

@interface HSFTabBarController ()<UIScrollViewDelegate, HSFTabBarDelegate>

//require
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) NSMutableArray *childVCArr_copy;
@property (nonatomic,strong) UIButton *oldBtn;
@property (nonatomic,strong) NSDictionary *oldDic;

@property(nonatomic,strong)NoticeAlertView *infoAlert;//弹窗
@property (nonatomic,strong)GongGaoItem *gongGaoItem;
@end

@implementation HSFTabBarController
//状态栏颜色
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

//初始化方法
-(instancetype)init{
    if (self = [super init]) {
        //默认设置
        self.loadAll = NO;
        self.barPosition = HSFTabBarPosition_bottom;
        self.canScroll = NO;
        
        self.norColor = [UIColor lightGrayColor];
        self.selColor = [UIColor whiteColor];
        self.tabBarHeight = TabbarH;
        self.isHaveTopline = NO;
        self.isHaveBottomline = NO;
        self.style = HSFTabBarStyle_baseline;
        self.indicatorPosition = HSFIndicatorPosition_bottom;
        
        
        
        self.childVCArr = [NSMutableArray array];
        self.source = [NSMutableArray array];

        HomeViewController *vc1 = [HomeViewController controller];
        [self addChildViewController:vc1 withImageName:@"home" selectedImageName:@"home" withTittle:lqLocalized(@"首页",nil)];
        
        ZhuanTiViewController *vc2 = [[ZhuanTiViewController alloc] init];
        [self addChildViewController:vc2 withImageName:@"" selectedImageName:@"" withTittle:lqStrings(@"专题")];

        AVViewController *vc3 = [[AVViewController alloc] init];
        [self addChildViewController:vc3 withImageName:@"" selectedImageName:@"" withTittle:lqLocalized(@"AV",nil)];
        
        AblumViewController *vc5 = [[AblumViewController alloc] init];
        [self addChildViewController:vc5 withImageName:@"" selectedImageName:@"" withTittle:lqLocalized(@"写真",nil)];
        
        CityViewController *vc4 = [[CityViewController alloc] init];
        [self addChildViewController:vc4 withImageName:@"" selectedImageName:@"" withTittle:lqLocalized(@"同城",nil)];
        
        MineViewController *vc6 = [[MineViewController alloc] init];
        [self addChildViewController:vc6 withImageName:@"" selectedImageName:@"" withTittle:lqLocalized(@"我的",nil)];
        
        
        [self requestData];//获取公告
        
        
        [self setUp];
        

    }
    return self;
}



-(void)dealloc {
    
}

#pragma mark - net
//获取公告
- (void)requestData{
    __weak __typeof(self) weakSelf = self;
    [HomeApi requestGongGaoSuccess:^(GongGaoItem * _Nonnull gongGaoItem, NSString * _Nonnull msg) {
        //type  0  公告，1 图片广告
        weakSelf.gongGaoItem = gongGaoItem;
        [weakSelf.infoAlert refreshUIWithItme:gongGaoItem];
        [[UIApplication sharedApplication].keyWindow addSubview:weakSelf.infoAlert];
        [weakSelf.infoAlert mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo([UIApplication sharedApplication].keyWindow);
        }];
    } error:^(NSError *error, id resultObject) {
//        [LSVProgressHUD showError:error];
    }];
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
    nav.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -12);
    
    NSDictionary *dict = @{@"title":tittle, @"selImg":selectImageName, @"norImg":imageName};
    
    [self.source addObject:dict];
    [self.childVCArr addObject:nav];
}

#pragma mark -viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    
}
//配置
-(void)setUp{
    
//bar>>>>>>>>>>>>>>>>>
    
    [self.tabBar setUp];
    [self.view addSubview:self.tabBar];
    __weak typeof(self) weakSelf = self;
    if (self.barPosition == HSFTabBarPosition_bottom) {
        [self.tabBar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.right.equalTo(weakSelf.view);
            make.height.mas_equalTo(self.tabBarHeight);
        }];
    }else if (self.barPosition == HSFTabBarPosition_top) {
        [self.tabBar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(weakSelf.view);
            make.height.mas_equalTo(self.tabBarHeight);
        }];
    }
    
//content>>>>>>>>>>>>>>>>>>>>>>
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * self.childVCArr.count, self.scrollView.frame.size.height);
    [self.view addSubview:self.scrollView];
    if (self.barPosition == HSFTabBarPosition_bottom) {
        [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(weakSelf.view);
            make.bottom.equalTo(weakSelf.tabBar.mas_top);
        }];
    }else if (self.barPosition == HSFTabBarPosition_top) {
        [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.right.equalTo(weakSelf.view);
            make.top.equalTo(weakSelf.tabBar.mas_bottom);
        }];
    }
    
    //是否一次全部加载
    if (self.loadAll) {
        __block CGFloat x = 0.0;
        [self.childVCArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIViewController *vc = (UIViewController *)obj;
            [vc viewDidLoad];
            [self addChildViewController:vc];
            [self.childVCArr_copy addObject:vc];
            x = self.scrollView.frame.size.width * idx;
            vc.view.frame = CGRectMake(x, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
            [self.scrollView addSubview:vc.view];
            //子控制器标题
            [self setNaviTitleWithController:vc atIndex:idx];
        }];

    }else{
        //添加第一个vc
        UIViewController *vc = self.childVCArr.firstObject;
        [vc viewDidLoad];
        [self addChildViewController:vc];
        [self.childVCArr_copy addObject:vc];
        vc.view.frame = CGRectMake(0, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
        [self.scrollView addSubview:vc.view];
        //子控制器标题
        [self setNaviTitleWithController:vc atIndex:0];
    }
    //是否可以左右滑动
    if (self.canScroll) {
        self.scrollView.scrollEnabled = YES;
    }else{
        self.scrollView.scrollEnabled = NO;
    }
}

#pragma mark -设置子控制器的标题
-(void)setNaviTitleWithController:(id)vc atIndex:(NSInteger)index{
    if ([vc isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navi = (UINavigationController *)vc;
        UIViewController *baseVC = navi.childViewControllers[0];
        baseVC.navigationItem.title = self.source[index][@"title"];
    }else if ([vc isKindOfClass:[UIViewController class]]) {
        UIViewController *NewVC = (UIViewController *)vc;
        NewVC.navigationItem.title = self.source[index][@"title"];
    }
}


#pragma mark -HSFTabBarDelegate
-(void)didSeletedHSFTabBar:(HSFTabBar *)tabBar atIndex:(NSInteger)index{
    //是否一次全部加载
    if (self.loadAll) {
        //do nothing
    }else{
        UIViewController *vc = self.childVCArr[index];
        if (![self.childVCArr_copy containsObject:vc]) {
            [vc viewDidLoad];
            [self addChildViewController:vc];
            [self.childVCArr_copy addObject:vc];
            CGFloat x = self.scrollView.frame.size.width * index;
            vc.view.frame = CGRectMake(x, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
            [self.scrollView addSubview:vc.view];
            //子控制器标题
            [self setNaviTitleWithController:vc atIndex:index];
        }
    }
    //滑动
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.frame.size.width * index, 0) animated:self.canScroll];
}

#pragma mark -UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView == self.scrollView) {
        //计算出index 模拟点击item
        int index = (int)(scrollView.contentOffset.x + scrollView.frame.size.width/2)/scrollView.frame.size.width;
        NSLog(@"========%d",index);
        [self.tabBar clickItemAtIndex:index];
    }
}



#pragma mark -懒加载
-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - self.tabBarHeight)];
        _scrollView.delegate = self;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.bounces = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.directionalLockEnabled = YES;
    }
    return _scrollView;
}
-(HSFTabBar *)tabBar{
    if (!_tabBar) {
        _tabBar = [[HSFTabBar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.tabBarHeight)];
        _tabBar.backgroundColor = [UIColor whiteColor];
        _tabBar.source = self.source;
        _tabBar.norColor = self.norColor;
        _tabBar.selColor = self.selColor;
        _tabBar.delegate = self;
        _tabBar.tabBarHeight = self.tabBarHeight;
        //可选的属性
        _tabBar.isHaveTopline = self.isHaveTopline;
        _tabBar.isHaveBottomline = self.isHaveBottomline;
        _tabBar.style = self.style;
        _tabBar.indicatorPosition = self.indicatorPosition;
        if (self.style == HSFTabBarStyle_baseline) {
            _tabBar.baseline_color = self.baseline_color;
            _tabBar.baseline_height = self.baseline_height;
            _tabBar.baseline_insert = self.baseline_insert;
        }
        else if (self.style == HSFTabBarStyle_dot) {
            _tabBar.dot_color = self.dot_color;
            _tabBar.dot_size = self.dot_size;
            _tabBar.dot_insert = self.dot_insert;
        }
        else if (self.style == HSFTabBarStyle_block) {
            _tabBar.block_color = self.block_color;
        }
        else if (self.style == HSFTabBarStyle_arrow) {
            _tabBar.arrow_color = self.arrow_color;
            _tabBar.arrow_size = self.arrow_size;
            _tabBar.arrow_insert = self.arrow_insert;
        }
    }
    return _tabBar;
}


-(NSMutableArray *)childVCArr_copy{
    if (!_childVCArr_copy) {
        _childVCArr_copy = [NSMutableArray array];
    }
    return _childVCArr_copy;
}





- (NoticeAlertView *)infoAlert{
    if (_infoAlert == nil) {
        _infoAlert = [[NoticeAlertView alloc] init];

        __weak __typeof(self) weakSelf = self;
        _infoAlert.noticeAlertViewRemoveBlock = ^(UIButton * _Nonnull sender) {
            [weakSelf.infoAlert removeFromSuperview];
            weakSelf.infoAlert = nil;
        };
        
        _infoAlert.noticeAlertViewJumpBlock = ^{
            NSURL *url = [NSURL URLWithString:weakSelf.gongGaoItem.url];
            [[UIApplication sharedApplication] openURL:url];
            
        };
    }
    
    return _infoAlert;
    
}

@end

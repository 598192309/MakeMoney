//
//  MangHuaCategoryViewController.m
//  MakeMoney
//
//  Created by rabi on 2020/9/3.
//  Copyright © 2020 lqq. All rights reserved.
//

#import "MangHuaCategoryViewController.h"
#import "LqSegmentControl.h"
#import "LqScrollView.h"
#import "ManghuaNewViewController.h"
#import "ManghuaLianzaiViewController.h"
#import "ManghuaCompleteViewController.h"
#import "ManghuaPersonViewController.h"

@interface MangHuaCategoryViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) LqScrollView *scrollView;
@property (nonatomic, strong) LqSegmentControl *segmentControl;
@property (nonatomic,strong)ManghuaNewViewController *NewVc;
@property (nonatomic,strong)ManghuaLianzaiViewController *lianzaiVC;
@property (nonatomic,strong)ManghuaCompleteViewController *completeVC;
@property (nonatomic,strong)ManghuaPersonViewController *personVC;

@end

@implementation MangHuaCategoryViewController

#pragma mark - 生命周期
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

}
- (void)viewDidLoad {
    [super viewDidLoad];

    
    
    if (@available(iOS 11.0, *)) {
        _scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self configUI];
    
}

- (void)configUI
{
    [self addNavigationView];
    self.navigationView.backgroundColor = TitleBarColor;
    self.navigationTextLabel.text = lqStrings(@"分类");
    LqSegmentControl *segmentControl = [[LqSegmentControl alloc] initWithFrame:CGRectMake(0, 0, self.view.lq_width, 50)];
    segmentControl.indicatorViewWidth = 30;
    segmentControl.normalColor = TitleGrayColor;
    segmentControl.selectNormalColor = [UIColor whiteColor];
    segmentControl.font = AdaptedBoldFontSize(18);
    [segmentControl hiddenSeprateView:YES];
    [segmentControl hiddenIndicatorView:YES];
    segmentControl.backgroundColor = TitleBarColor;
    segmentControl.showStyle = LqSegmentShowCenterStyle;
    [self.view addSubview:segmentControl];
    [segmentControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.equalTo(@(50));
        make.top.equalTo(@(NavMaxY));
    }];
    self.segmentControl = segmentControl;
    
    
    
    LqScrollView *scrollView = [[LqScrollView alloc] initWithFrame:CGRectMake(0, segmentControl.lq_height, self.view.lq_width, self.view.lq_height - segmentControl.lq_height)];
    [self.view addSubview:scrollView];
    __weak __typeof(self) weakself = self;
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakself.view);
        make.top.equalTo(segmentControl.mas_bottom);
        make.bottom.equalTo(weakself.view);
    }];
    self.scrollView = scrollView;
    
    [segmentControl reloadDataWithTitles:@[@"最新",@"连载中",@"完结",@"真人"] selectedIndex:0];
    scrollView.viewControllers = [NSMutableArray arrayWithArray:@[self.NewVc,self.lianzaiVC,self.completeVC,self.personVC]];
    
    
    segmentControl.selectedIndexBlock = ^(NSInteger originIndex, NSInteger newIndex) {
        [weakself.scrollView scrollToControllerAtIndex:newIndex animated:NO];
    };
    
    scrollView.scrollOffsetXRadioBlock = ^(CGFloat offsetXRadio) {
        weakself.segmentControl.selectedIndex = offsetXRadio + 0.5;
    };
}
- (void)dealloc{
    LQLog(@"dealloc -- %@",NSStringFromClass([self class]));
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - lazy
- (ManghuaNewViewController *)NewVc{
    if (!_NewVc) {
        _NewVc = [[ManghuaNewViewController alloc] init];
    }
    return _NewVc;
}

- (ManghuaLianzaiViewController *)lianzaiVC{
    if (!_lianzaiVC) {
        _lianzaiVC = [[ManghuaLianzaiViewController alloc] init];
    }
    return _lianzaiVC;
}
- (ManghuaCompleteViewController *)completeVC{
    if (!_completeVC) {
        _completeVC = [[ManghuaCompleteViewController alloc] init];
    }
    return _completeVC;
}

- (ManghuaPersonViewController *)personVC{
    if (!_personVC) {
        _personVC = [[ManghuaPersonViewController alloc] init];
    }
    return _personVC;
}
@end

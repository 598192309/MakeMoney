//
//  MyLoveViewController.m
//  MakeMoney
//
//  Created by rabi on 2020/3/6.
//  Copyright © 2020 lqq. All rights reserved.
//  我的收藏

#import "MyLoveViewController.h"
#import "MyAVLoveViewController.h"
#import "MyVedioLoveViewController.h"
#import "MyAblumLoveViewController.h"
#import "LqScrollView.h"
#import "LqSegmentControl.h"
@interface MyLoveViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) LqScrollView *scrollView;
@property (nonatomic, strong) LqSegmentControl *segmentControl;

@property (nonatomic,strong)MyAVLoveViewController *avVC;
@property (nonatomic,strong)MyVedioLoveViewController *videoVC;
@property (nonatomic,strong)MyAblumLoveViewController *ablumVC;

@end

@implementation MyLoveViewController

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
    self.navigationTextLabel.text = lqStrings(@"我的收藏");
    LqSegmentControl *segmentControl = [[LqSegmentControl alloc] initWithFrame:CGRectMake(0, 0, self.view.lq_width, 50)];
    segmentControl.indicatorViewWidth = 30;
    segmentControl.normalColor = TitleGrayColor;
    segmentControl.selectNormalColor = [UIColor whiteColor];
    segmentControl.font = [UIFont systemFontOfSize:16];
    
    [segmentControl hiddenSeprateView:YES];
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
        make.bottom.equalTo(weakself.view).offset(-0);
    }];
    self.scrollView = scrollView;
    
    [segmentControl reloadDataWithTitles:@[@"AV",@"短视频",@"写真"] selectedIndex:0];
    scrollView.viewControllers = [NSMutableArray arrayWithArray:@[self.avVC,self.videoVC,self.ablumVC]];
    
    
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




- (MyAVLoveViewController *)avVC{
    if (!_avVC) {
        _avVC = [[MyAVLoveViewController alloc] init];
    }
    return _avVC;
}

- (MyVedioLoveViewController *)videoVC{
    if (!_videoVC) {
        _videoVC = [[MyVedioLoveViewController alloc] init];
    }
    return _videoVC;
}

- (MyAblumLoveViewController *)ablumVC{
    if (!_ablumVC) {
        _ablumVC = [[MyAblumLoveViewController  alloc] init];
    }
    return _ablumVC;
}

@end

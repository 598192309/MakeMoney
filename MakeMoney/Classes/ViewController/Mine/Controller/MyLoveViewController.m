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
#import "GroupCoinSegmentrol.h"
@interface MyLoveViewController ()<UIScrollViewDelegate>

@property (nonatomic,strong)GroupCoinSegmentrol *groupCoinSegmentrol;

@property(nonatomic,strong)UIScrollView *scrollView;
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
    [self setUpSegmentrol];

    [self setupScrollView];
    [self setupAllChildVc];
    
    
}

- (void)dealloc{
    LQLog(@"dealloc -- %@",NSStringFromClass([self class]));
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark - ui
- (void)setUpSegmentrol{
    [self addNavigationView];
    self.navigationTextLabel.text = lqStrings(@"我的收藏");
    
    [self.view addSubview:self.groupCoinSegmentrol];
    __weak __typeof(self) weakSelf = self;
    [self.groupCoinSegmentrol mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(NavMaxY);
        make.left.right.mas_equalTo(weakSelf.view);
        make.height.mas_equalTo(Adaptor_Value(50));
    }];

    _groupCoinSegmentrol.selectedIndexBlock = ^(NSInteger originIndex, NSInteger newIndex) {
        [UIView animateWithDuration:0.25 animations:^{
            // 滚动scrollView
            CGFloat offsetX = newIndex * weakSelf.scrollView.lq_width;
            weakSelf.scrollView.contentOffset = CGPointMake(offsetX, weakSelf.scrollView.contentOffset.y);
        } completion:^(BOOL finished) {
            //        // 添加子控制器的view到scrollView中
            [weakSelf addChildVcViewIntoScrollView:newIndex];
        }];

    };
}

//scrollview
- (void)setupScrollView{
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = CGRectMake(0, 0, LQScreemW, LQScreemH);
    scrollView.delegate = self;
    scrollView.backgroundColor = ThemeBlackColor;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    __weak __typeof(self) weakSelf = self;
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(weakSelf.view);
        make.top.mas_equalTo(weakSelf.groupCoinSegmentrol.mas_bottom);
        
    }];
//
//    //不让它滚
//    self.scrollView.scrollEnabled = NO;
}
- (void)setupAllChildVc{
    
    [self addChildViewController:self.avVC];
    [self addChildViewController:self.videoVC];
    [self addChildViewController:self.ablumVC];

    NSUInteger count = self.childViewControllers.count;
    
    // 设置scrollView
    self.scrollView.contentSize = CGSizeMake(count * self.scrollView.lq_width, 0);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    
    // 不要自动调整内边距
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 默认加载最前面子控制器的view
    [self addChildVcViewIntoScrollView:0];
    
}

/**
 *  添加index位置对应的子控制器view到scrollView
 */
- (void)addChildVcViewIntoScrollView:(NSInteger)index
{
    UIViewController *childVc = [self.childViewControllers safeObjectAtIndex:index];
    //点击切换的时候 刷新数据
    if ([childVc respondsToSelector:@selector(requestData)]) {
        [childVc performSelector:@selector(requestData)];
    }
    if (childVc.isViewLoaded) return;
    [self.scrollView addSubview:childVc.view];
    childVc.view.lq_x = index * self.scrollView.lq_width;
    childVc.view.lq_y = 0;
}
#pragma mark - <UIScrollViewDelegate>

/**
 *  当scrollView减速完毕的时候调用这个方法（当scrollView停止滚动的时候调用这个方法）
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // 按钮索引
    NSInteger index = scrollView.contentOffset.x / scrollView.lq_width;
    // 找到按钮
    [self scrollToVC:index];

    
}

- (void)scrollToVC:(NSInteger)index{
    self.groupCoinSegmentrol.selectedIndex = index;
    __weak __typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.25 animations:^{
        // 滚动scrollView
        CGFloat offsetX = index * weakSelf.scrollView.lq_width;
        weakSelf.scrollView.contentOffset = CGPointMake(offsetX, weakSelf.scrollView.contentOffset.y);
    } completion:^(BOOL finished) {
        //        // 添加子控制器的view到scrollView中
        [weakSelf addChildVcViewIntoScrollView:index];
    }];
    
}
#pragma mark - lazy
- (GroupCoinSegmentrol *)groupCoinSegmentrol{
    if (!_groupCoinSegmentrol) {
        _groupCoinSegmentrol = [[GroupCoinSegmentrol alloc] initWithTitleItems:@[lqStrings(@"AV"),lqStrings(@"短视频"),lqStrings(@"写真")]];
        _groupCoinSegmentrol.indicateViewWidth = Adaptor_Value(20);
        _groupCoinSegmentrol.titleNormalColor = TitleGrayColor;
    }
    return _groupCoinSegmentrol;
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

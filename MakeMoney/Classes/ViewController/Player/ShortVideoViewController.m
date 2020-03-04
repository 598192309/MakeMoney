//
//  ShortVideoViewController.m
//  MakeMoney
//
//  Created by rabi on 2020/3/4.
//  Copyright © 2020 lqq. All rights reserved.
//  短视频播放器

#import "ShortVideoViewController.h"
#import "ZFPlayer.h"
#import "ZFPlayerControlView.h"
#import "ZFUtilities.h"
#import "UIImageView+ZFCache.h"
#import "ZFAVPlayerManager.h"
#import "DouYinControlView.h"
#import "ZFDouYinCell.h"

#import "HomeItem.h"
@interface ShortVideoViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *customTableView;
@property (nonatomic, strong) ZFPlayerController *player;
@property (nonatomic, strong) DouYinControlView *controlView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSMutableArray *urls;
@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) HotItem *item;

@end

@implementation ShortVideoViewController
#pragma ClassMethod
+ (instancetype)controllerWith:(HotItem *)item {
    ShortVideoViewController *vc = [[ShortVideoViewController alloc] init];
    vc.item = item;
    vc.urls = [NSMutableArray arrayWithObject:[NSURL URLWithString:item.video_url]];
    vc.dataSource = [NSMutableArray arrayWithObject:item];
    return vc;
}

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.customTableView];
    [self.view addSubview:self.backBtn];
//    self.fd_prefersNavigationBarHidden = YES;
    
    
//    [self requestData];
    
//    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
//    self.tableView.mj_header = header;

    /// playerManager
    ZFAVPlayerManager *playerManager = [[ZFAVPlayerManager alloc] init];


    /// player,tag值必须在cell里设置
    self.player = [ZFPlayerController playerWithScrollView:self.customTableView playerManager:playerManager containerViewTag:100];
    self.player.assetURLs = self.urls;
    self.player.disableGestureTypes = ZFPlayerDisableGestureTypesDoubleTap | ZFPlayerDisableGestureTypesPan | ZFPlayerDisableGestureTypesPinch;
    self.player.controlView = self.controlView;
    self.player.allowOrentitaionRotation = NO;
    self.player.WWANAutoPlay = YES;
    /// 1.0是完全消失时候
    self.player.playerDisapperaPercent = 1.0;
    
    @weakify(self)
    self.player.playerDidToEnd = ^(id  _Nonnull asset) {
        @strongify(self)
        [self.player.currentPlayerManager replay];
    };
    
    self.player.presentationSizeChanged = ^(id<ZFPlayerMediaPlayback>  _Nonnull asset, CGSize size) {
        @strongify(self)
        if (size.width >= size.height) {
            self.player.currentPlayerManager.scalingMode = ZFPlayerScalingModeAspectFit;
        } else {
            self.player.currentPlayerManager.scalingMode = ZFPlayerScalingModeAspectFill;
        }
    };
    //播放
    [self playTheIndex:0];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.backBtn.frame = CGRectMake(15, CGRectGetMaxY([UIApplication sharedApplication].statusBarFrame), 36, 36);
}


- (void)playTheIndex:(NSInteger)index {
    @weakify(self)
    /// 指定到某一行播放
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    [self.customTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionNone animated:NO];
    [self.customTableView zf_filterShouldPlayCellWhileScrolled:^(NSIndexPath *indexPath) {
        @strongify(self)
        [self playTheVideoAtIndexPath:indexPath scrollToTop:NO];
    }];

}


- (BOOL)shouldAutorotate {
    return NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (BOOL)prefersStatusBarHidden {
    return self.player.isStatusBarHidden;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationSlide;
}

#pragma mark - UIScrollViewDelegate  列表播放必须实现

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [scrollView zf_scrollViewDidEndDecelerating];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [scrollView zf_scrollViewDidEndDraggingWillDecelerate:decelerate];
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {
    [scrollView zf_scrollViewDidScrollToTop];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [scrollView zf_scrollViewDidScroll];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [scrollView zf_scrollViewWillBeginDragging];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ZFDouYinCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZFDouYinCell class])];
    cell.dataItem = [self.dataSource safeObjectAtIndex:indexPath.row];
    //点击观看完整版
    cell.douYinCellSeeBtnClickBlock = ^(UIButton *sender) {
        [LSVProgressHUD showInfoWithStatus:[sender titleForState:UIControlStateNormal]];
    };
    //点击喜欢
    cell.douYinCellLikeBtnClickBlock = ^(UIButton *sender) {
        [LSVProgressHUD showInfoWithStatus:[sender titleForState:UIControlStateNormal]];

    };
    //点击分享
    cell.douYinCellShareBtnClickBlock = ^(UIButton *sender) {
        [LSVProgressHUD showInfoWithStatus:[sender titleForState:UIControlStateNormal]];

    };
    return cell;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [self playTheVideoAtIndexPath:indexPath scrollToTop:NO];
//}

#pragma mark - ZFTableViewCellDelegate

- (void)zf_playTheVideoAtIndexPath:(NSIndexPath *)indexPath {
    [self playTheVideoAtIndexPath:indexPath scrollToTop:NO];
}

#pragma mark - private method

- (void)backClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

/// play the video
- (void)playTheVideoAtIndexPath:(NSIndexPath *)indexPath scrollToTop:(BOOL)scrollToTop {
    [self.player playTheIndexPath:indexPath scrollToTop:scrollToTop];
    [self.controlView resetControlView];
//    ZFTableData *data = self.dataSource[indexPath.row];
//    UIViewContentMode imageMode;
//    if (data.thumbnail_width >= data.thumbnail_height) {
//        imageMode = UIViewContentModeScaleAspectFit;
//    } else {
//        imageMode = UIViewContentModeScaleAspectFill;
//    }
//    [self.controlView showCoverViewWithUrl:data.thumbnail_url withImageMode:imageMode];
    [self.controlView showCoverViewWithUrl:self.item.img_url withImageMode:UIViewContentModeScaleAspectFill];

}

#pragma mark - getter

- (UITableView *)customTableView {
    if (!_customTableView) {
        _customTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _customTableView.pagingEnabled = YES;
        [_customTableView registerClass:[ZFDouYinCell class] forCellReuseIdentifier:NSStringFromClass([ZFDouYinCell class])];
        _customTableView.backgroundColor = [UIColor lightGrayColor];
        _customTableView.delegate = self;
        _customTableView.dataSource = self;
        _customTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _customTableView.showsVerticalScrollIndicator = NO;
        _customTableView.scrollsToTop = NO;
        if (@available(iOS 11.0, *)) {
            _customTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        _customTableView.estimatedRowHeight = 0;
        _customTableView.estimatedSectionFooterHeight = 0;
        _customTableView.estimatedSectionHeaderHeight = 0;
        _customTableView.frame = self.view.bounds;
        _customTableView.rowHeight = _customTableView.frame.size.height;
        _customTableView.scrollsToTop = NO;
        
//        /// 停止的时候找出最合适的播放
//        @weakify(self)
//        _tableView.zf_scrollViewDidStopScrollCallback = ^(NSIndexPath * _Nonnull indexPath) {
//            @strongify(self)
//            if (self.player.playingIndexPath) return;
//            if (indexPath.row == self.dataSource.count-1) {
//                /// 加载下一页数据
//                [self requestData];
//                self.player.assetURLs = self.urls;
//                [self.tableView reloadData];
//            }
//            [self playTheVideoAtIndexPath:indexPath scrollToTop:NO];
//        };
    }
    return _customTableView;
}

- (DouYinControlView *)controlView {
    if (!_controlView) {
        _controlView = [DouYinControlView new];
    }
    return _controlView;
}

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = @[].mutableCopy;
    }
    return _dataSource;
}

- (NSMutableArray *)urls {
    if (!_urls) {
        _urls = @[].mutableCopy;
    }
    return _urls;
}

- (UIButton *)backBtn {
    if (!_backBtn) {
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(backClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}


@end

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
#import "MineApi.h"
#import "MineItem.h"

#import "AVPlayerController.h"
#import "ShareView.h"
#import<AssetsLibrary/AssetsLibrary.h>

@interface ShortVideoViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *customTableView;
@property (nonatomic, strong) ZFPlayerController *player;
@property (nonatomic, strong) DouYinControlView *controlView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSMutableArray *urls;
@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) HotItem *item;

@property (nonatomic,strong)CommonAlertView *commonAlertView;

@property (nonatomic,strong)ShareView *shareView;
@end

@implementation ShortVideoViewController
#pragma ClassMethod
+ (instancetype)controllerWith:(HotItem *)item {
    ShortVideoViewController *vc = [[ShortVideoViewController alloc] init];
    vc.item = item;
    if ([item.video_url hasPrefix:@"http"]) {
        vc.urls = [NSMutableArray arrayWithObject:[NSURL URLWithString:item.video_url]];

    }else{//拼接
        NSString *str = [NSString stringWithFormat:@"%@%@",RI.basicItem.video_url,item.video_url];
        vc.urls = [NSMutableArray arrayWithObject:[NSURL URLWithString:str]];
        
    }
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
    
    self.player.pauseWhenAppResignActive = NO;
    
    __weak __typeof(self) weakSelf = self;
    self.player.playerDidToEnd = ^(id  _Nonnull asset) {
        [LSVProgressHUD showInfoWithStatus:lqStrings(@"VIP才可以观看完整版哟～")];
        [weakSelf.player.currentPlayerManager replay];
    };
    
    self.player.playerPlayTimeChanged = ^(id<ZFPlayerMediaPlayback>  _Nonnull asset, NSTimeInterval currentTime, NSTimeInterval duration) {
        NSLog(@"播放时长currentTime:%f,总时长duration:%f",currentTime,duration);

    };
    
    self.player.presentationSizeChanged = ^(id<ZFPlayerMediaPlayback>  _Nonnull asset, CGSize size) {
        if (size.width >= size.height) {
            weakSelf.player.currentPlayerManager.scalingMode = ZFPlayerScalingModeAspectFit;
        } else {
            weakSelf.player.currentPlayerManager.scalingMode = ZFPlayerScalingModeAspectFill;
        }
    };
    
    self.player.playerReadyToPlay = ^(id<ZFPlayerMediaPlayback>  _Nonnull asset, NSURL * _Nonnull assetURL) {

      //每次播放了 刷新一下用户信息 获取播放次数
//        [weakSelf requestUserInfo];
        [weakSelf updateTimesWithVideoID:weakSelf.item.ID];
    };
    //播放
    [self playTheIndex:0];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.backBtn.frame = CGRectMake(15, CGRectGetMaxY([UIApplication sharedApplication].statusBarFrame), 36, 36);
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    LQLog(@"dealloc ---------%@",NSStringFromClass([self class]));
}

- (void)playTheIndex:(NSInteger)index {
    __weak __typeof(self) weakSelf = self;

    /// 指定到某一行播放
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    [self.customTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionNone animated:NO];
    [self.customTableView zf_filterShouldPlayCellWhileScrolled:^(NSIndexPath *indexPath) {
        
        [weakSelf playTheVideoAtIndexPath:indexPath scrollToTop:NO];
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

#pragma mark - act
- (void)showMsg:(NSString *)msg firstBtnTitle:(NSString *)firstBtnTitle secBtnTitle:(NSString *)secBtnTitle singleBtnTitle:(NSString *)singleBtnTitle{
    [self.commonAlertView refreshUIWithTitle:msg firstBtnTitle:firstBtnTitle secBtnTitle:secBtnTitle singleBtnTitle:singleBtnTitle];
    [[UIApplication sharedApplication].keyWindow addSubview:self.commonAlertView];
    [self.commonAlertView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo([UIApplication sharedApplication].keyWindow);
    }];
}

#pragma mark - net
//每次播放 刷新用户信息 获取播放次数
- (void)requestUserInfo{
    [MineApi requestUserInfoSuccess:^(NSInteger status, NSString * _Nonnull msg, InitItem *initItem) {
        RI.infoInitItem = initItem;
    } error:^(NSError *error, id resultObject) {
        
    }];
}

//请求更新播放次数
- (void)updateTimesWithVideoID:(NSString *)video_id{
    __weak __typeof(self) weakSelf = self;
    [MineApi requestShortVedioInfoWithVedioId:video_id is_vip:RI.infoInitItem.is_vip type:0 Success:^(InitItem * _Nonnull initItem, NSString * _Nonnull msg) {
        [weakSelf requestUserInfo];
    } error:^(NSError *error, id resultObject) {
        
    }];
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
    HotItem *item = [self.dataSource safeObjectAtIndex:indexPath.row];

    cell.dataItem = item;
    //点击观看完整版
    __weak __typeof(self) weakSelf = self;

    cell.douYinCellSeeBtnClickBlock = ^(UIButton *sender) {
        //判断是否是会员
        if (!RI.infoInitItem.is_vip) {
            [weakSelf.player setPauseByEvent:YES];
            [weakSelf.controlView setPlayBtnHidden:NO];
            AVPlayerController *vc = [AVPlayerController controllerWith:item];
            vc.isShortVideo = YES;
            [weakSelf.navigationController pushViewController:vc animated:YES];
            
        }else{
//            [LSVProgressHUD showInfoWithStatus:@"购买会员"];
            [weakSelf showMsg:lqStrings(@"VIP会员才能观看完整版喔～") firstBtnTitle:lqStrings(@"再想想") secBtnTitle:lqStrings(@"购买VIP") singleBtnTitle:@""];
        }
    };
    //点击喜欢
    cell.douYinCellLikeBtnClickBlock = ^(UIButton *sender) {
//        [LSVProgressHUD showInfoWithStatus:[sender titleForState:UIControlStateNormal]];

    };
    //点击分享
    cell.douYinCellShareBtnClickBlock = ^(UIButton *sender) {
//        [LSVProgressHUD showInfoWithStatus:[sender titleForState:UIControlStateNormal]];
        [[UIApplication sharedApplication].keyWindow addSubview:weakSelf.shareView];
        [weakSelf.shareView refreshUIWithItme:item];
        [weakSelf.shareView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo([UIApplication sharedApplication].keyWindow);
        }];
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
#pragma mark - 保存图片
- (void)saveImageToDiskWithImage:(UIImage *)image
{
    __weak __typeof(self) weakSelf = self;
    UIImageWriteToSavedPhotosAlbum(image, weakSelf, @selector(image:didFinishSavingWithError:contextInfo:), NULL);

    
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    
    
    ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
    
    if(author == ALAuthorizationStatusDenied ){
        //无权限
        [LSVProgressHUD showInfoWithStatus:NSLocalizedString(@"图片保存失败,请前往设置开启相册权限", nil)];
        return;
    }
    
    if (error) {
        [LSVProgressHUD showInfoWithStatus:NSLocalizedString(@"保存失败，请查看你的相册权限是否开启", nil)];
    }else{
        [LSVProgressHUD showInfoWithStatus:NSLocalizedString(@"图片已经保存至相册", nil)];
 
    }
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

- (CommonAlertView *)commonAlertView{
    if (!_commonAlertView) {
        _commonAlertView = [CommonAlertView new];
        __weak __typeof(self) weakSelf = self;
        _commonAlertView.commonAlertViewBlock = ^(NSInteger index, NSString * _Nonnull str) {
            [weakSelf.commonAlertView removeFromSuperview];
            weakSelf.commonAlertView = nil;
            if (index == 2) {//购买VIP
                [LSVProgressHUD showInfoWithStatus:@"购买VIP"];
            }
        };
    }
    return _commonAlertView;
}

- (ShareView *)shareView{
    if (!_shareView) {
        _shareView = [ShareView new];
        __weak __typeof(self) weakSelf = self;
        _shareView.tapClickBlock = ^{
            [weakSelf.shareView removeFromSuperview];
            weakSelf.shareView = nil;
        };
        
        _shareView.saveBtnClickBlock = ^(UIButton * _Nonnull sender, UIImageView * _Nonnull erweimaImageV) {
            [weakSelf saveImageToDiskWithImage:erweimaImageV.image];

        };
        
        _shareView.copyBtnClickBlock = ^(UIButton * _Nonnull sender, UIImageView * _Nonnull erweimaImageV) {
            NSString *erweimaStr = [NSString stringWithFormat:@"%@/share.html?appkey=%@&code=%@",RI.basicItem.share_url,ErweimaShareKey,RI.infoInitItem.invite_code];
            UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
            pasteboard.string = erweimaStr;
            [LSVProgressHUD showInfoWithStatus:NSLocalizedString(@"复制成功", nil)];
        };
    }
    return _shareView;
}
@end

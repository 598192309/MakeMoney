//
//  AVPlayerController.m
//  MakeMoney
//
//  Created by JS on 2020/3/2.
//  Copyright © 2020 lqq. All rights reserved.
//

#import "AVPlayerController.h"
#import "ZFPlayer.h"
#import "ZFPlayerControlView.h"
#import "ZFUtilities.h"
#import "UIImageView+ZFCache.h"
#import "ZFAVPlayerManager.h"

#import "AVApi.h"
#import "AVItem.h"

#import "AVTuijianView.h"
#import "AVCenterView.h"

#import "MineApi.h"
#import "MineItem.h"

#import "RechargeCenterViewController.h"

static NSString *kVideoCover = @"https://upload-images.jianshu.io/upload_images/635942-14593722fe3f0695.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240";


@interface AVPlayerController ()
@property (nonatomic, strong) ZFPlayerController *player;
@property (nonatomic, strong) UIImageView *containerView;
@property (nonatomic, strong) ZFPlayerControlView *controlView;
@property (nonatomic, strong) UIButton *playBtn;

@property (nonatomic, strong) NSArray <NSURL *>*assetURLs;



@property (nonatomic, strong) HotItem *item;
@property (nonatomic,strong)NSMutableArray *tuijianArr;

@property (nonatomic,strong)NSArray *adsArr;


//推荐部分
@property (nonatomic,strong)AVTuijianView *avTuijianView;
////中间 广告 title部分
//@property (nonatomic,strong)AVCenterView *avCenterView;
@property (nonatomic,strong)CommonAlertView *commonAlertView;


@end

@implementation AVPlayerController
#pragma ClassMethod
+ (instancetype)controllerWith:(HotItem *)item {
    AVPlayerController *vc = [[AVPlayerController alloc] init];
    vc.item = item;
    return vc;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    __weak __typeof(self) weakSelf = self;
    [self.view addSubview:self.containerView];
    if (self.isShortVideo) {
        [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_equalTo(weakSelf.view);
        }];
    }else{
        [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.mas_equalTo(weakSelf.view);
            make.height.mas_equalTo(LQScreemW*9/16.0);
        }];
        
        [self.containerView addSubview:self.playBtn];
        [self.playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(Adaptor_Value(44));
            make.center.mas_equalTo(self.containerView);
        }];
        
//        //中间部分
//        [self.view addSubview:self.avCenterView];
//        [self.avCenterView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.right.mas_equalTo(weakSelf.view);
//            make.top.mas_equalTo(weakSelf.containerView.mas_bottom);
//        }];
//        [self.avCenterView configUIWithItem:self.item finishi:^{
//
//        }];

        //推荐部分
        [self.view addSubview:self.avTuijianView];
//        [self.avTuijianView configCenterViewUIWithItem:self.item finishi:^{
//
//        }];
        [self.avTuijianView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(weakSelf.view);
            make.top.mas_equalTo(weakSelf.containerView.mas_bottom);
        }];
        [self tuijianViewAct];
    }


    [self setUpNav];

    
    ZFAVPlayerManager *playerManager = [[ZFAVPlayerManager alloc] init];
    /// 播放器相关
    self.player = [ZFPlayerController playerWithPlayerManager:playerManager containerView:self.containerView];
    self.player.controlView = self.controlView;
    /// 设置退到后台继续播放
    self.player.pauseWhenAppResignActive = NO;
    
    @weakify(self)
    self.player.orientationWillChange = ^(ZFPlayerController * _Nonnull player, BOOL isFullScreen) {
        @strongify(self)
        [self setNeedsStatusBarAppearanceUpdate];
    };
    
    self.player.playerPlayTimeChanged = ^(id<ZFPlayerMediaPlayback>  _Nonnull asset, NSTimeInterval currentTime, NSTimeInterval duration) {
        @strongify(self)
        NSLog(@"播放时长currentTime:%f,总时长duration:%f",currentTime,duration);
        //判断是否是会员     //AV 这里有3中状态，通过tag判断   0  VIP   1 限免    2 收费

        if (!RI.infoInitItem.is_vip && !weakSelf.isShortVideo && !(weakSelf.item.tag == 1) && !RI.infoInitItem.is_new_user) {//不是会员 只能看5分钟 不是限免 不是新用户限时免费
            if (currentTime > 5 * 60) {
                [self.player enterFullScreen:NO animated:NO];
                [self.player.currentPlayerManager pause];
                [self.controlView resetControlView];
                [self.player seekToTime:0 completionHandler:^(BOOL finished) {

                    [self.player.currentPlayerManager pause];
                }];
                [self showMsg:lqStrings(@"非会员只允许观看5分钟") firstBtnTitle:lqStrings(@"取消") secBtnTitle:lqStrings(@"去充值VIP") singleBtnTitle:@""];
                
            }
//            else{
//                self.player.pauseByEvent = NO;
//            }
        }
    };
    
    /// 播放完成
    self.player.playerDidToEnd = ^(id  _Nonnull asset) {
        @strongify(self)
        [self.player.currentPlayerManager replay];
        [self.player playTheNext];
        if (!self.player.isLastAssetURL) {
            [self.controlView showTitle:self.item.title coverURLString:kVideoCover fullScreenMode:ZFFullScreenModeLandscape];
        } else {
            [self.player stop];
        }
    };
    
    self.player.playerReadyToPlay = ^(id<ZFPlayerMediaPlayback>  _Nonnull asset, NSURL * _Nonnull assetURL) {
        if (!weakSelf.isShortVideo) {//短视频不用更新 因为ShortVideoViewController更新了的
            //每次播放了 刷新一下用户信息 获取播放次数
            [weakSelf updatePlayTimes];
        }

    };
    
    [self startPlay];
}

- (void)startPlay {
    //拼接播放视频的Url
    NSString *videoUrl;
    if ([self.item.vip_video_url hasPrefix:@"http"]) {
        videoUrl = self.item.vip_video_url;
    }else{
        videoUrl = [NSString stringWithFormat:@"%@%@",RI.basicItem.vip_video_url,self.item.vip_video_url.length > 0 ? self.item.vip_video_url : self.item.video_url];
    }
    NSLog(@"视频播放地址：%@",videoUrl);
    self.player.assetURL = [NSURL URLWithString:videoUrl];
//    [self.controlView showTitle:self.item.title coverURLString:kVideoCover fullScreenMode:ZFFullScreenModeAutomatic];
    [self.controlView showTitle:self.isShortVideo ? self.item.title : @"" coverURLString:kVideoCover fullScreenMode:ZFFullScreenModeAutomatic];

    [self.avTuijianView configCenterViewUIWithItem:self.item finishi:^{
        
    }];
    
    [self requestTuijianList];
    [self requestAds];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.player.viewControllerDisappear = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.player.viewControllerDisappear = YES;
}

- (void)setUpNav{
    [self addNavigationView];
    self.navigationView.backgroundColor = [UIColor clearColor];
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    LQLog(@"dealloc ---------%@",NSStringFromClass([self class]));
}

- (void)playClick:(UIButton *)sender {
    [self.player playTheIndex:0];
    [self.controlView showTitle:self.item.title coverURLString:kVideoCover fullScreenMode:ZFFullScreenModeAutomatic];
}
#pragma mark ----act
- (void)tuijianViewAct{
    __weak __typeof(self) weakSelf = self;
    //点击cell
    weakSelf.avTuijianView.cellClickBlock = ^(NSIndexPath * _Nonnull indexPath) {
        //切换数据
        HotItem *hotitem = [weakSelf.tuijianArr safeObjectAtIndex:indexPath.row];
        weakSelf.item = hotitem;
        [weakSelf startPlay];
    };
    //收藏取消
    weakSelf.avTuijianView.loveBlock = ^(EnlargeTouchSizeButton * _Nonnull sender) {
        [weakSelf loveWithId:weakSelf.item.ID sender:sender];
    };
}

- (void)showMsg:(NSString *)msg firstBtnTitle:(NSString *)firstBtnTitle secBtnTitle:(NSString *)secBtnTitle singleBtnTitle:(NSString *)singleBtnTitle{
    [self.commonAlertView refreshUIWithTitle:msg titlefont:AdaptedFontSize(15) titleColor:TitleBlackColor firstBtnTitle:firstBtnTitle secBtnTitle:secBtnTitle singleBtnTitle:singleBtnTitle];
    [[UIApplication sharedApplication].keyWindow addSubview:self.commonAlertView];
    [self.commonAlertView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo([UIApplication sharedApplication].keyWindow);
    }];

}
#pragma mark - net
//获取推荐视频
- (void)requestTuijianList{
    __weak __typeof(self) weakSelf = self;
    [AVApi requestAVExtendwithID:self.item.ID Success:^(NSArray * _Nonnull hotItemArr, NSString * _Nonnull msg) {
        weakSelf.tuijianArr = [NSMutableArray arrayWithArray:hotItemArr];
        [weakSelf.avTuijianView configUIWithItemArr:hotItemArr finishi:^{
            
        }];
    } error:^(NSError *error, id resultObject) {
        [LSVProgressHUD showError:error];
    }];
}

//获取广告
- (void)requestAds{
    __weak __typeof(self) weakSelf = self;
    if (self.adsArr.count > 0) {
        int count = self.adsArr.count;
        int index = arc4random()% (count -1);
        [weakSelf.avTuijianView configAds:[weakSelf.adsArr safeObjectAtIndex:index] finishi:^{
        }];
        return;
    }
    [HomeApi requestAdWithType:@"4" Success:^(NSArray * _Nonnull adsItemArr, NSString * _Nonnull msg) {
//        [weakSelf.avCenterView configAds:adsItemArr.firstObject finishi:^{
//
//        }];
        weakSelf.adsArr = adsItemArr;
        int count = adsItemArr.count;
        int index = arc4random()% (count -1);
        [weakSelf.avTuijianView configAds:[adsItemArr safeObjectAtIndex:index] finishi:^{
        }];
    } error:^(NSError *error, id resultObject) {
        
    }];
}

//更新播放次数
- (void)updatePlayTimes{
    __weak __typeof(self) weakSelf = self;
    [MineApi requestAVInfoWithVedioId:self.item.ID Success:^(InitItem * _Nonnull initItem, NSString * _Nonnull msg) {
//        //is_new_user = 1 && mobile ！= nil    新账号
//        if (initItem.is_new_user == 1 && initItem.mobile.length != 0) {
//            initItem.is_new_user = 1;
//        }else{
//            //is_new_user = 1 && mobile == nil    可能是设备变了
//              //is_new_user = 0 && mobile ！= nil    老用户
//            initItem.is_new_user = NO;
//        }
//        RI.infoInitItem.is_new_user = initItem.is_new_user;
    } error:^(NSError *error, id resultObject) {
        
    }];
}

//收藏与取消
- (void)loveWithId:(NSString *)ID sender:(UIButton *)sender{
    __weak __typeof(self) weakSelf = self;
    sender.userInteractionEnabled = NO;
    [AVApi loveAVWithVedioId:ID Success:^(NSInteger status, NSString * _Nonnull msg) {
        sender.userInteractionEnabled = YES;
        [LSVProgressHUD showInfoWithStatus:msg];
    } error:^(NSError *error, id resultObject) {
        sender.userInteractionEnabled = YES;

    }];
}
#pragma mark - lazy
- (ZFPlayerControlView *)controlView {
    if (!_controlView) {
        _controlView = [ZFPlayerControlView new];
        _controlView.fastViewAnimated = YES;
        _controlView.autoHiddenTimeInterval = 5;
        _controlView.autoFadeTimeInterval = 0.5;
        _controlView.prepareShowLoading = YES;
        _controlView.prepareShowControlView = YES;
    }
    return _controlView;
}

- (UIImageView *)containerView {
    if (!_containerView) {
        _containerView = [UIImageView new];
        [_containerView setImageWithURLString:kVideoCover placeholder:[ZFUtilities imageWithColor:[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1] size:CGSizeMake(1, 1)]];
    }
    return _containerView;
}

- (UIButton *)playBtn {
    if (!_playBtn) {
        _playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_playBtn setImage:[UIImage imageNamed:@"new_allPlay_44x44_"] forState:UIControlStateNormal];
        [_playBtn addTarget:self action:@selector(playClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playBtn;
}



- (AVTuijianView *)avTuijianView{
    if (!_avTuijianView) {
        _avTuijianView = [AVTuijianView new];
    }
    return _avTuijianView;
}

//- (AVCenterView *)avCenterView{
//    if (!_avCenterView) {
//        _avCenterView = [AVCenterView new];
//    }
//    return _avCenterView;
//}

- (CommonAlertView *)commonAlertView{
    if (!_commonAlertView) {
        _commonAlertView = [CommonAlertView new];
        __weak __typeof(self) weakSelf = self;
        _commonAlertView.commonAlertViewBlock = ^(NSInteger index, NSString * _Nonnull str) {

            if (index == 1) {//取消
                [weakSelf.commonAlertView removeFromSuperview];
                weakSelf.commonAlertView = nil;
                
            }else if (index == 2) {//购买VIP
                [weakSelf.commonAlertView removeFromSuperview];
                weakSelf.commonAlertView = nil;
                RechargeCenterViewController *vc = [[RechargeCenterViewController alloc] init];
                [weakSelf.navigationController pushViewController:vc animated:YES];
                [weakSelf popSelfDelayTime:1.0];
            }
        };
    }
    return _commonAlertView;
}


- (UIStatusBarStyle)preferredStatusBarStyle {
    if (self.player.isFullScreen) {
        return UIStatusBarStyleLightContent;
    }
    return UIStatusBarStyleDefault;
}

- (BOOL)prefersStatusBarHidden {
    return self.player.isStatusBarHidden;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationSlide;
}

- (BOOL)shouldAutorotate {
    return self.player.shouldAutorotate;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}
@end

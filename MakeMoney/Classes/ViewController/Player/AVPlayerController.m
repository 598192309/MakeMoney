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
static NSString *kVideoCover = @"https://upload-images.jianshu.io/upload_images/635942-14593722fe3f0695.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240";


@interface AVPlayerController ()
@property (nonatomic, strong) ZFPlayerController *player;
@property (nonatomic, strong) UIImageView *containerView;
@property (nonatomic, strong) ZFPlayerControlView *controlView;
@property (nonatomic, strong) UIButton *playBtn;

@property (nonatomic, strong) NSArray <NSURL *>*assetURLs;



@property (nonatomic, strong) HotItem *item;

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
//    [self addNavigationView];

    [self.view addSubview:self.containerView];
    
    [self.containerView addSubview:self.playBtn];


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
    //拼接播放视频的Url
    NSString *videoUrl = [NSString stringWithFormat:@"%@%@",RI.basicItem.vip_video_url,self.item.vip_video_url];
    NSLog(@"视频播放地址：%@",videoUrl);
    self.player.assetURL = [NSURL URLWithString:videoUrl];
    [self.controlView showTitle:self.item.title coverURLString:kVideoCover fullScreenMode:ZFFullScreenModeAutomatic];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.player.viewControllerDisappear = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.player.viewControllerDisappear = YES;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    CGFloat x = 0;
    CGFloat y = CGRectGetMaxY([UIApplication sharedApplication].statusBarFrame);
    CGFloat w = CGRectGetWidth(self.view.frame);
    CGFloat h = w*9/16;
    self.containerView.frame = CGRectMake(x, y, w, h);
    
    w = 44;
    h = w;
    x = (CGRectGetWidth(self.containerView.frame)-w)/2;
    y = (CGRectGetHeight(self.containerView.frame)-h)/2;
    self.playBtn.frame = CGRectMake(x, y, w, h);

}


- (void)playClick:(UIButton *)sender {
    [self.player playTheIndex:0];
    [self.controlView showTitle:self.item.title coverURLString:kVideoCover fullScreenMode:ZFFullScreenModeAutomatic];
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




@end

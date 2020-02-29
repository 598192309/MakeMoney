//
//  LaunchingViewController.m
//  IUang
//
//  Created by jayden on 2018/4/24.
//  Copyright © 2018年 jayden. All rights reserved.
//

#import "LaunchingViewController.h"

#import "InitApi.h"
#import "InitItem.h"
#import "HomeApi.h"
#import "HomeItem.h"

@interface LaunchingViewController ()
@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)UIButton *countingBtn;
@property(nonatomic,strong)AdsItem *adsItem;

@end

@implementation LaunchingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIImageView *backView = [[UIImageView alloc] initWithFrame:self.view.frame];
    backView.image = [UIImage imageNamed:@"splash_bg_chunjie"];
    [self.view addSubview:backView];
    backView.center = self.view.center;
    _imageView = backView;
    backView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [backView addGestureRecognizer:tap];
    if (IS_IPHONEX) {
        backView.contentMode = UIViewContentModeScaleToFill;
    }else{
        backView.contentMode = UIViewContentModeScaleAspectFill;
    }
    [self initAPP];
    
    

}

- (void)dealloc{
    LQLog([NSString stringWithFormat:@"dealloc ---- %@",NSStringFromClass([self class])]);
    
}
#pragma mark - act
#pragma  mark - 自定义

- (void)addCountBtn{
    //广告请求回来 倒计时开始
    __weak __typeof(self) weakSelf = self;
    [weakSelf.view addSubview:weakSelf.countingBtn];
    [weakSelf.countingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_equalTo(Adaptor_Value(50));
        make.right.mas_equalTo(weakSelf.view).offset(-Adaptor_Value(5));
        make.top.mas_equalTo(TopAdaptor_Value(40));
    }];
    ViewRadius(weakSelf.countingBtn, Adaptor_Value(25));
    [weakSelf.countingBtn startWithTime:5 title:lqStrings(@"进入APP") titleColor:TitleWhiteColor countDownTitle:NSLocalizedString(@"s", nil) countDownTitleColor:TitleWhiteColor mainColor:[UIColor lq_colorWithHexString:@"#666666" alpha:0.5] countColor:[UIColor lq_colorWithHexString:@"#303030" alpha:0.3]];
}
- (void)tap:(UITapGestureRecognizer *)gest{
    if ([self.adsItem.url hasPrefix:@"http"]) {
        UIApplication *application = [UIApplication sharedApplication];
        if ([application respondsToSelector:@selector(openURL:options:completionHandler:)]) {
            if (@available(iOS 10.0, *)) {
                [application openURL:[NSURL URLWithString:self.adsItem.url] options:@{} completionHandler:nil];
            } else {
                [application openURL:[NSURL URLWithString:self.adsItem.url]];
            }
        }else{
            [application openURL:[NSURL URLWithString:self.adsItem.url]];

        }

    }
}
- (void)codeBtnClick:(UIButton *)sender{
    if ([[sender titleForState:UIControlStateNormal] isEqualToString:lqStrings(@"进入APP")]) {
            //进入APP
        MainTabBarController *main = [[MainTabBarController alloc] init];
        [AppDelegate shareAppDelegate].rootTabbar = main;
        APPDelegate.window.rootViewController = main ;
    }

}
#pragma mark - net
-(void)initAPP{
    __weak __typeof(self) weakSelf = self;
   // 创建 dispatch 组 两个网络请求成功 刷新界面
    dispatch_group_t group = dispatch_group_create();
    // 第一个请求：
    dispatch_group_enter(group);
    [InitApi requestBasicInfoSuccess:^(BasicItem * _Nonnull basicItem, NSString * _Nonnull msg) {
        dispatch_group_leave(group);

    } error:^(NSError *error, id resultObject) {
//        [LSVProgressHUD showError:error];
//        dispatch_group_leave(group);
        [LSVProgressHUD showInfoWithStatus:lqStrings(@"数据获取失败，请重新启动app")];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^(void){
            exit(0);
        });
    }];
    // 第2个请求：
    dispatch_group_enter(group);
    [InitApi initWithSyste:@"ios" Success:^(InitItem * _Nonnull initItem, NSString * _Nonnull msg) {
        dispatch_group_leave(group);
    } error:^(NSError *error, id resultObject) {
//        [LSVProgressHUD showError:error];
//        dispatch_group_leave(group);
        [LSVProgressHUD showInfoWithStatus:lqStrings(@"数据获取失败，请重新启动app")];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^(void){
            exit(0);
        });
    }];
    

    
    // 当上面两个请求都结束后，回调此 Block
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"OVER:%@", [NSThread currentThread]);
        [LSVProgressHUD dismiss];
       //请求广告
        [weakSelf requestAds];
        });
}
- (void)requestAds{
    __weak __typeof(self) weakSelf = self;
    [HomeApi requestAdWithType:@"100" Success:^(NSArray * _Nonnull adsItemArr, NSString * _Nonnull msg) {
        //广告请求回来 倒计时开始 没有广告5秒后自动进入APP 有广告 点击进入
        [weakSelf addCountBtn];
        AdsItem *adsItem = adsItemArr.firstObject;
        weakSelf.adsItem = adsItem;
        [weakSelf.imageView sd_setImageWithURL:[NSURL URLWithString:adsItem.img] placeholderImage:[UIImage imageNamed:@"splash_bg_chunjie"]];

    } error:^(NSError *error, id resultObject) {
        //广告请求回来 倒计时开始
        [self addCountBtn];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //进入APP
            MainTabBarController *main = [[MainTabBarController alloc] init];
            [AppDelegate shareAppDelegate].rootTabbar = main;
            APPDelegate.window.rootViewController = main ;
        });

    }];
}

#pragma  mark - lazy

- (UIButton *)countingBtn{
    if (!_countingBtn) {
        _countingBtn = [[UIButton alloc] init];
        _countingBtn.backgroundColor = [UIColor lq_colorWithHexString:@"#666666" alpha:0.5];
        _countingBtn.titleLabel.font = AdaptedFontSize(12);
        [_countingBtn addTarget:self action:@selector(codeBtnClick:) forControlEvents:UIControlEventTouchDown];
}
    return _countingBtn;
}

@end

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
@property (nonatomic,strong)EnlargeTouchSizeButton *jumpBtn;

@property (nonatomic,strong)UIView *warningView;//第一次安装且第一次启动。显示出来警告页
@property (nonatomic,strong)UIImageView *warningImageV;
@property (nonatomic,strong)UILabel *warningTitleLable;
@property (nonatomic,strong)UILabel *warningContenLable;
@property (nonatomic,strong)EnlargeTouchSizeButton *chooseBtn;
@property (nonatomic,strong)EnlargeTouchSizeButton *agreeBtn;

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
    


    // 之前的最新的版本号 lastVersion
    if (![self isNewVersion]) {
    }else{ // 有最新的版本号 显示警告页
         __weak __typeof(self) weakSelf = self;
        [self.view addSubview:self.warningView];
        [self.warningView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(weakSelf.view);
        }];
    }

}

- (void)dealloc{
    LQLog([NSString stringWithFormat:@"dealloc ---- %@",NSStringFromClass([self class])]);
    
}
#pragma mark - act
- (BOOL)isNewVersion{
    // 判断下用户有没有最新的版本
     NSDictionary *dict =  [NSBundle mainBundle].infoDictionary;

     // 获取最新的版本号
     NSString *curVersion = dict[@"CFBundleShortVersionString"];

     // 获取上一次的版本号
     NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:VersionKey];

     // 之前的最新的版本号 lastVersion
     if ([curVersion isEqualToString:lastVersion]) {
         [[NSUserDefaults standardUserDefaults] setObject:curVersion forKey:VersionKey];
         return NO;
     }else{ // 有最新的版本号 显示警告页

         // 保存最新的版本号
         // 保存到偏好设置
         [[NSUserDefaults standardUserDefaults] setObject:curVersion forKey:VersionKey];
         return YES;
     }
}
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
    [weakSelf.countingBtn startWithTime:5 title:lqStrings(@"") titleColor:TitleWhiteColor countDownTitle:NSLocalizedString(@"s", nil) countDownTitleColor:TitleWhiteColor mainColor:[UIColor lq_colorWithHexString:@"#666666" alpha:0.5] countColor:[UIColor lq_colorWithHexString:@"#303030" alpha:0.3]];
    
    
    [weakSelf.view addSubview:weakSelf.jumpBtn];
    [weakSelf.jumpBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(Adaptor_Value(80));
        make.centerY.mas_equalTo(weakSelf.countingBtn);
        make.height.mas_equalTo(Adaptor_Value(40));
        make.right.mas_equalTo(weakSelf.view).offset(-Adaptor_Value(5));

    }];
    ViewRadius(weakSelf.jumpBtn, Adaptor_Value(20));
//#warning ceshi
    weakSelf.jumpBtn.hidden = YES;
    
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

- (void)chooseBtnClick:(UIButton *)sender{
    sender.selected = !sender.selected;
}
- (void)agreeBtnClick:(UIButton *)sender{
    if (self.chooseBtn.selected) {
            //进入APP
        MainTabBarController *main = [[MainTabBarController alloc] init];
        [AppDelegate shareAppDelegate].rootTabbar = main;
        APPDelegate.window.rootViewController = main ;
    }else{
        [LSVProgressHUD showInfoWithStatus:lqStrings(@"请确认已阅读")];
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
        
        RI.basicItem = basicItem;
        RI.basicItemJasonStr = [basicItem mj_JSONString];

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
        RI.infoInitItem = initItem;
        RI.infoInitItemJasonStr = [initItem mj_JSONString];

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
        // 之前的最新的版本号 lastVersion
        if (!_warningView) {
            //请求广告
             [weakSelf requestAds];
        }else{ // 有最新的版本号 显示警告页
            
        }

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
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            weakSelf.countingBtn.hidden = YES;
            weakSelf.jumpBtn.hidden = NO;
        });

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
//        [_countingBtn addTarget:self action:@selector(codeBtnClick:) forControlEvents:UIControlEventTouchDown];
}
    return _countingBtn;
}

- (EnlargeTouchSizeButton *)jumpBtn{
    if (!_jumpBtn) {
        _jumpBtn = [[EnlargeTouchSizeButton alloc] init];
        _jumpBtn.backgroundColor = [UIColor lq_colorWithHexString:@"#666666" alpha:0.5];
        _jumpBtn.titleLabel.font = AdaptedFontSize(12);
        [_jumpBtn addTarget:self action:@selector(codeBtnClick:) forControlEvents:UIControlEventTouchDown];
        [_jumpBtn setTitle:lqStrings(@"进入APP") forState:UIControlStateNormal];
    }
    return _jumpBtn;
}

- (UIView *)warningView{
    if (!_warningView) {
        _warningView = [UIView new];
        _warningView.backgroundColor = ThemeBlackColor;
        __weak __typeof(self) weakSelf = self;
        UIView *contentV = [UIView new];
        [_warningView addSubview:contentV];
        [contentV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(weakSelf.warningView);
        }];
        
        _warningImageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"warning"]];
        [contentV addSubview:_warningImageV];
        [_warningImageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(contentV);
            make.width.height.mas_equalTo(Adaptor_Value(80));
            make.top.mas_equalTo(TopAdaptor_Value(140));
        }];
        
        _warningTitleLable = [UILabel lableWithText:lqLocalized(@"警告",nil) textColor:[UIColor whiteColor] fontSize:AdaptedBoldFontSize(30) lableSize:CGRectZero textAliment:NSTextAlignmentCenter numberofLines:0];
        [contentV addSubview:_warningTitleLable];
        [_warningTitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(contentV);
            make.top.mas_equalTo(weakSelf.warningImageV.mas_bottom).offset(Adaptor_Value(10));
        }];
        
        _warningContenLable = [UILabel lableWithText:lqLocalized(@"",nil) textColor:[UIColor whiteColor] fontSize:AdaptedFontSize(15) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contentV addSubview:_warningContenLable];
        [_warningContenLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(Adaptor_Value(10));
            make.top.mas_equalTo(weakSelf.warningTitleLable.mas_bottom).offset(Adaptor_Value(30));
            make.right.mas_equalTo(contentV).offset(-Adaptor_Value(10));

        }];
        NSString *str = lqStrings(@"你在访问本应用时,请严格遵守当地法律法规,严禁未满18周岁和中国大陆地区用户使用,严禁讲应用内容派发.传阅.出售.出租.交给或出借给Ta人,严禁向未满18岁人员出示.推荐或播放应用内容。");
        _warningContenLable.attributedText = [str lq_getAttributedStringWithLineSpace:Adaptor_Value(10) kern:0];
        
        _chooseBtn = [[EnlargeTouchSizeButton alloc] init];
        _chooseBtn.titleLabel.font = AdaptedFontSize(12);
        [_chooseBtn addTarget:self action:@selector(chooseBtnClick:) forControlEvents:UIControlEventTouchDown];
        [_chooseBtn setTitle:lqStrings(@"我已阅读") forState:UIControlStateNormal];
        [_chooseBtn setImage:[UIImage imageNamed:@"icon_xieyi_uncheck"] forState:UIControlStateNormal];
        [_chooseBtn setImage:[UIImage imageNamed:@"icon_xieyi_checked"] forState:UIControlStateSelected];
        [contentV addSubview:_chooseBtn];
        [_chooseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(contentV);
            make.top.mas_equalTo(weakSelf.warningContenLable.mas_bottom).offset(Adaptor_Value(50));
            make.height.mas_equalTo(Adaptor_Value(40));
            make.width.mas_equalTo(Adaptor_Value(120));
        }];
        
        _agreeBtn = [[EnlargeTouchSizeButton alloc] init];
        _agreeBtn.titleLabel.font = AdaptedFontSize(16);
        [_agreeBtn setTitleColor:TitleBlackColor forState:UIControlStateNormal];
        [_agreeBtn addTarget:self action:@selector(agreeBtnClick:) forControlEvents:UIControlEventTouchDown];
        [_agreeBtn setTitle:lqStrings(@"同意") forState:UIControlStateNormal];
        [contentV addSubview:_agreeBtn];
        [_agreeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(contentV);
            make.top.mas_equalTo(weakSelf.chooseBtn.mas_bottom).offset(Adaptor_Value(20));
            make.height.mas_equalTo(Adaptor_Value(40));
            make.width.mas_equalTo(Adaptor_Value(150));
        }];
        [_agreeBtn setBackgroundColor:TitleWhiteColor];
        ViewRadius(_agreeBtn, Adaptor_Value(20));

    }
    
    return _warningView;
}
@end

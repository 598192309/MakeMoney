//
//  BaseViewController.m
//  IUang
//
//  Created by jayden on 2018/4/17.
//  Copyright © 2018年 jayden. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()
@property (nonatomic,weak) Reachability *hostReach;

@end

@implementation BaseViewController


//右滑返回功能，默认开启（YES）
- (BOOL)gestureRecognizerShouldBegin{
    return YES;
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = ThemeBlackColor;
    if([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)])
    {
        self.automaticallyAdjustsScrollViewInsets=NO;
    }
    
    //监听网络变化
    Reachability *reach = [Reachability reachabilityWithHostName:kURL_Reachability__Address];
    
    self.hostReach = reach;
    [[NSNotificationCenter defaultCenter]addObserver:self  selector:@selector(netStatusChange:) name:kReachabilityChangedNotification object:nil];
    //实现监听
    [reach startNotifier];
    
    self.isShowing = YES;
    
    
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.isShowing = YES;

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    _notFirstAppear = YES;
    self.isShowing = NO;

    
}

-(NSString *)backItemImageName{
    return @"back";
}

//- (BOOL)shouldAutorotate{
//    //是否允许转屏
//    BOOL result = [super shouldAutorotate];
//    return result;
//}
//
//- (UIInterfaceOrientationMask)supportedInterfaceOrientations
//{
//    UIInterfaceOrientationMask result = [super supportedInterfaceOrientations];
//    //viewController所支持的全部旋转方向
//    return result;
//}
//
//- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
//{
//    UIInterfaceOrientation result = [super preferredInterfaceOrientationForPresentation];
//    //viewController初始显示的方向
//    return result;
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//    [super touchesBegan:touches withEvent:event];
//    [self.view endEditing:YES];
//}

//添加导航栏
-(void)addNavigationView{
    __weak __typeof(self) weakSelf = self;
    [self.view addSubview:self.navigationView];
    [self.navigationView addSubview:self.navigationBackTitleButton];
    
    [self.navigationView addSubview:self.navigationBackButton];
    
    [self.navigationView addSubview:self.navigationBackSecButton];
    
    [self.navigationView addSubview:self.navigationbackgroundLine];
    [self.navigationView addSubview:self.navigationTextLabel];
    [self.navigationView addSubview:self.navigationTextTopLabel];
    [self.navigationView addSubview:self.navigationTextBottomLabel];

    
    [self.navigationView addSubview:self.navigationRightBtn];
    [self.navigationView addSubview:self.navigationRightSecBtn];
    [self.navigationView addSubview:self.navigationRightThirdBtn];

    [self.navigationView addSubview:self.navigationLastBtn];
    [self.navigationView addSubview:self.navigationNextBtn];


    
    [self.navigationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(weakSelf.view);
        make.top.mas_equalTo( 0);
        make.height.mas_equalTo(NavMaxY);
    }];
    [self.navigationBackTitleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.navigationView).with.offset(Adaptor_Value(10));
        make.top.mas_equalTo(weakSelf.navigationView).with.offset(IS_PhoneXAll ? 40 : 25);
    }];
    
    [self.navigationBackButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.navigationView).with.offset(Adaptor_Value(10));
        make.top.mas_equalTo(weakSelf.navigationView).with.offset(IS_PhoneXAll ? 40 : 25);
        make.size.mas_equalTo(CGSizeMake(Adaptor_Value(40), Adaptor_Value(40)));
    }];
    
    [self.navigationBackSecButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.navigationBackButton.mas_right).with.offset(Adaptor_Value(5));
        make.centerY.mas_equalTo(weakSelf.navigationBackButton);
        
    }];
    
    [self.navigationbackgroundLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.navigationView);
        make.height.mas_equalTo(1);
    }];
    //阴影
    self.navigationbackgroundLine.layer.shadowColor = TitleBlackColor.CGColor;
    self.navigationbackgroundLine.layer.shadowOffset = CGSizeMake(0.0f, 3.0f);
    self.navigationbackgroundLine.layer.shadowOpacity = 0.5f;
    self.navigationbackgroundLine.layer.shadowRadius = 5;
    self.navigationbackgroundLine.layer.masksToBounds = NO;
    
    [self.navigationTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.navigationView);
        make.centerY.mas_equalTo(weakSelf.navigationBackButton);
    }];
    [self.navigationTextTopLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.navigationView);
        make.bottom.mas_equalTo(weakSelf.navigationBackButton.mas_centerY);
    }];
    [self.navigationTextBottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.navigationView);
        make.top.mas_equalTo(weakSelf.navigationBackButton.mas_centerY);
    }];
    
    [self.navigationRightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakSelf.navigationView).with.offset(-Adaptor_Value(10));
//        make.right.mas_equalTo(weakSelf.navigationView);

        make.centerY.mas_equalTo(weakSelf.navigationTextLabel);
        make.height.mas_equalTo(Adaptor_Value(40));
//        make.width.mas_equalTo(Adaptor_Value(25));

    }];
    [self.navigationRightSecBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.navigationRightBtn);
        make.right.mas_equalTo(weakSelf.navigationRightBtn.mas_left).offset(-Adaptor_Value(10));
        make.width.height.mas_equalTo(Adaptor_Value(20));
    }];
    
    [self.navigationRightThirdBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.navigationRightBtn);
        make.right.mas_equalTo(weakSelf.navigationRightSecBtn.mas_left).offset(-Adaptor_Value(10));
        make.height.mas_equalTo(Adaptor_Value(20));
        make.width.mas_equalTo(Adaptor_Value(40));

    }];
    
    [self.navigationLastBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.navigationRightBtn);
        make.right.mas_equalTo(weakSelf.navigationTextTopLabel.mas_left).offset(-Adaptor_Value(0));
        make.height.width.mas_equalTo(Adaptor_Value(40));
        
    }];
    
    [self.navigationNextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.navigationRightBtn);
        make.left.mas_equalTo(weakSelf.navigationTextTopLabel.mas_right).offset(Adaptor_Value(0));
        make.height.width.mas_equalTo(weakSelf.navigationLastBtn);
    }];



    
}
-(void)backClick:(UIButton*)button{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)navigationBackTitleButtonClick:(UIButton *)btn{
    
}
- (void)navigationBackSecClick:(UIButton *)btn{
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)navigationRightSecBtnClick:(UIButton*)button{
}
-(void)navigationRightThirdBtnClick:(UIButton*)button{
}

- (void)navigationLastBtnClick:(UIButton *)button{
    
}
- (void)navigationNextBtnClick:(UIButton *)button{
    
}
-(UIView *)navigationView{
    if (!_navigationView) {
        _navigationView = [UIView new];
        _navigationView.backgroundColor = ThemeBlackColor;
    }
    return _navigationView;
}
-(UIButton *)navigationBackButton{
    if (!_navigationBackButton) {
        _navigationBackButton = [UIButton new];
        [_navigationBackButton setImage:[UIImage imageNamed:self.backItemImageName] forState:UIControlStateNormal];
        [_navigationBackButton addTarget:self action:@selector(backClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _navigationBackButton;
}
-(UIButton *)navigationBackTitleButton{
    if (!_navigationBackTitleButton) {
        _navigationBackTitleButton = [UIButton new];
        [_navigationBackTitleButton setTitleColor:[UIColor whiteColor]  forState:UIControlStateNormal];
        [_navigationBackTitleButton addTarget:self action:@selector(navigationBackTitleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _navigationBackTitleButton;
}
-(UIButton *)navigationBackSecButton{
    if (!_navigationBackSecButton) {
        _navigationBackSecButton = [UIButton new];
        [_navigationBackSecButton addTarget:self action:@selector(navigationBackSecClick:) forControlEvents:UIControlEventTouchUpInside];
        [_navigationBackSecButton setTitleColor:[UIColor whiteColor]  forState:UIControlStateNormal];
        _navigationBackSecButton.titleLabel.font = RegularFONT(14);
        
    }
    return _navigationBackSecButton;
}
-(UIView *)navigationbackgroundLine{
    if (!_navigationbackgroundLine) {
        _navigationbackgroundLine = [UIView new];
        //        _navigationbackgroundLine.backgroundColor = HexRGB(0xECECEC);
        _navigationbackgroundLine.backgroundColor = [UIColor clearColor];
    }
    return _navigationbackgroundLine;
}
-(UILabel *)navigationTextLabel{
    if (!_navigationTextLabel) {
        _navigationTextLabel = [UILabel new];
        _navigationTextLabel.font = AdaptedBoldFontSize(17);
        _navigationTextLabel.textColor = [UIColor whiteColor];

    }
    return _navigationTextLabel;
}

-(UILabel *)navigationTextTopLabel{
    if (!_navigationTextTopLabel) {
        _navigationTextTopLabel = [UILabel new];
        _navigationTextTopLabel.font = AdaptedBoldFontSize(15);
        _navigationTextTopLabel.textColor = [UIColor whiteColor];
        
    }
    return _navigationTextTopLabel;
}

-(UILabel *)navigationTextBottomLabel{
    if (!_navigationTextBottomLabel) {
        _navigationTextBottomLabel = [UILabel new];
        _navigationTextBottomLabel.font = AdaptedFontSize(10);
        _navigationTextBottomLabel.textColor = TitleGrayColor;
        
    }
    return _navigationTextBottomLabel;
}



-(UIButton *)navigationRightBtn{
    if (!_navigationRightBtn) {
        _navigationRightBtn = [EnlargeTouchSizeButton new];
        [_navigationRightBtn addTarget:self action:@selector(navigationRightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_navigationRightBtn setTitleColor:[UIColor whiteColor]  forState:UIControlStateNormal];
        _navigationRightBtn.titleLabel.font = RegularFONT(14);
        
        
    }
    return _navigationRightBtn;
}
-(EnlargeTouchSizeButton *)navigationRightSecBtn{
    if (!_navigationRightSecBtn) {
        _navigationRightSecBtn = [EnlargeTouchSizeButton new];
        [_navigationRightSecBtn addTarget:self action:@selector(navigationRightSecBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_navigationRightSecBtn setTitleColor:[UIColor whiteColor]  forState:UIControlStateNormal];
        _navigationRightSecBtn.titleLabel.font = RegularFONT(14);
    }
    return _navigationRightSecBtn;
}

-(UIButton *)navigationRightThirdBtn{
    if (!_navigationRightThirdBtn) {
        _navigationRightThirdBtn = [UIButton new];
        [_navigationRightThirdBtn addTarget:self action:@selector(navigationRightThirdBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_navigationRightThirdBtn setTitleColor:[UIColor whiteColor]  forState:UIControlStateNormal];
        _navigationRightThirdBtn.titleLabel.font = RegularFONT(14);
    }
    return _navigationRightThirdBtn;
}
-(UIButton *)navigationLastBtn{
    if (!_navigationLastBtn) {
        _navigationLastBtn = [UIButton new];
        [_navigationLastBtn addTarget:self action:@selector(navigationLastBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_navigationLastBtn setImage:[UIImage imageNamed:@"lastOne"] forState:UIControlStateNormal];
        _navigationLastBtn.hidden = YES;
    }
    return _navigationLastBtn;
}

-(UIButton *)navigationNextBtn{
    if (!_navigationNextBtn) {
        _navigationNextBtn = [UIButton new];
        [_navigationNextBtn addTarget:self action:@selector(navigationNextBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_navigationNextBtn setImage:[UIImage imageNamed:@"nextOne"] forState:UIControlStateNormal];
        _navigationNextBtn.hidden = YES;

    }
    return _navigationNextBtn;
}



//通知监听回调 网络状态发送改变 系统会发出一个kReachabilityChangedNotification通知，然后会触发此回调方法
- (void)netStatusChange:(NSNotification *)noti{
    NSLog(@"-----%@",noti.userInfo);
    //判断网络状态
    switch (self.hostReach.currentReachabilityStatus) {
        case NotReachable:
            //            [MBProgressHUD showInfo:NSLocalizedString(@"当前网络连接失败，请查看设置", nil) ToView:self.view];
            [LSVProgressHUD showInfoWithStatus:NSLocalizedString(@"当前网络连接失败，请查看设置", nil)];
            break;
        case ReachableViaWiFi:
            NSLog(NSLocalizedString(@"wifi上网2", nil));
            break;
        case ReachableViaWWAN:
            NSLog(NSLocalizedString(@"手机上网2", nil));
            break;
        default:
            break;
    }
}

@end


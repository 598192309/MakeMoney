//
//  BindMobileSetPwdViewController.m
//  MakeMoney
//
//  Created by 黎芹 on 2020/4/20.
//  Copyright © 2020 lqq. All rights reserved.
//

#import "BindMobileSetPwdViewController.h"
#import "MineApi.h"
#import "SAMKeychain.h"
#import "BindMobileFirstStepViewController.h"

@interface BindMobileSetPwdViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *customTableView;
@property (nonatomic,strong)UIImageView *backImageV;
@property (nonatomic,strong)UIView *header;
@property (nonatomic,strong)UIImageView *iconImageV;

@property (nonatomic,strong)UIView *tfBackView;
@property (nonatomic,strong)UILabel *tipLable;
@property (nonatomic,strong)UILabel *wrongTipLable;
@property (nonatomic,strong)UITextField *pwdTf;
@property (nonatomic,strong)UIButton *seeBtn;
@property (nonatomic,strong)UIButton *forgetBtn;
@property (nonatomic,strong)UIButton *confirmBtn;


@end

@implementation BindMobileSetPwdViewController

#pragma mark - life
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configUI];
    [self setUpNav];
    
    if (@available(iOS 11.0, *)) {
           _customTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
       // Fallback on earlier versions
       self.automaticallyAdjustsScrollViewInsets = NO;
    }

    
}
- (void)dealloc{
    LQLog(@"dealloc -------%@",NSStringFromClass([self class]));
}
#pragma mark - ui
- (void)configUI{
    __weak __typeof(self) weakSelf = self;
    [self.view addSubview:self.backImageV];
    [self.backImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weakSelf.view);
    }];
    
    
    [self.view addSubview:self.customTableView];

    [self.customTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(weakSelf.view);
        make.top.mas_equalTo(NavMaxY);
    }];
    
    //header
    UIView *tableHeaderView = [[UIView alloc] init];
    [tableHeaderView addSubview:self.header];
    [self.header mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(tableHeaderView);
    }];
//    CGFloat H = [tableHeaderView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    tableHeaderView.lq_height = LQScreemH;
    self.customTableView.tableHeaderView = tableHeaderView;
    self.customTableView.tableHeaderView.lq_height = LQScreemH;
    
 
    
}
- (void)setUpNav{
    [self addNavigationView];
    self.navigationView.backgroundColor = [UIColor clearColor];
}
#pragma mark - act
#pragma mark - act
- (void)confirmBtnClick:(UIButton *)sender{
    if (self.isFisrtlogin) {
        [self setPwdWithMobile:self.mobile pwd:self.pwdTf.text sender:sender];
    }else {
        if (self.islogin) {
            [self loginWithMobile:self.mobile pwd:self.pwdTf.text sender:sender];

        }else{
            [self updatePwdWithMobile:self.mobile pwd:self.pwdTf.text sender:sender];

        }
    }
}

- (void)forgetBtnClick:(UIButton *)sender{
    BindMobileFirstStepViewController *vc = [[BindMobileFirstStepViewController alloc] init];
    vc.isFindBackPwd = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)seeBtnClick:(UIButton *)sender{
    sender.selected = !sender.selected;
    self.pwdTf.secureTextEntry = sender.selected;
}

#pragma  mark - UITextField delegate
- (void)textFDidChange:(UITextField *)textf{
    
}
#pragma mark -  net
// 登录
- (void)loginWithMobile:(NSString *)mobile pwd:(NSString *)pwd sender:(UIButton *)sender{
    [LSVProgressHUD show];
    sender.userInteractionEnabled = NO;
    __weak __typeof(self) weakSelf = self;
    [MineApi loginWithMobile:mobile password:pwd success:^(NSInteger status, NSString * _Nonnull msg,NSString *token) {
        //    "msg": "58e17cf5d2952bdb91251c3c8bc4c504",   //返回token保存到请求头
        //讲数据保存一下
        [SAMKeychain setPassword:token  forService:@"com.51778Vedio"account:@"uuid"];

        [NET setToken:token];
        [LSVProgressHUD showInfoWithStatus:msg];

        sender.userInteractionEnabled = YES;
        
        [weakSelf.navigationController popToRootViewControllerAnimated:YES];

    } error:^(NSError *error, id resultObject) {
//        [LSVProgressHUD showError:error];
        [LSVProgressHUD dismiss];
        sender.userInteractionEnabled = YES;

        weakSelf.wrongTipLable.text = error.errorMsg;
        [weakSelf.forgetBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(Adaptor_Value(30));
        }];
        weakSelf.forgetBtn.hidden = NO;

    }];
}

//更新密码
- (void)updatePwdWithMobile:(NSString *)mobile pwd:(NSString *)pwd sender:(UIButton *)sender{
    [LSVProgressHUD show];
    sender.userInteractionEnabled = NO;
    __weak __typeof(self) weakSelf = self;
    [MineApi updatePwdWithMobile:mobile password:pwd success:^(NSInteger status, NSString * _Nonnull msg) {
        //更新成功 再登录
        [weakSelf loginWithMobile:mobile pwd:pwd sender:sender];
    } error:^(NSError *error, id resultObject) {
        [LSVProgressHUD showError:error];
    }];
}

//设置密码
- (void)setPwdWithMobile:(NSString *)mobile pwd:(NSString *)pwd sender:(UIButton *)sender{
    [LSVProgressHUD show];
    sender.userInteractionEnabled = NO;
    __weak __typeof(self) weakSelf = self;
    [MineApi setPwdWithMobile:mobile password:pwd success:^(NSInteger status, NSString * _Nonnull msg) {
        //s设置成功 再登录
        [weakSelf loginWithMobile:mobile pwd:pwd sender:sender];
    } error:^(NSError *error, id resultObject) {
        [LSVProgressHUD showError:error];
    }];
}


#pragma mark -  UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 0;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
    return 0;

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return nil;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *secHeader = [[UIView alloc] init];
    secHeader.backgroundColor = [UIColor clearColor];
    return secHeader;

}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}



#pragma mark - lazy
- (UITableView *)customTableView{
    if (!_customTableView) {
        _customTableView = [[UITableView alloc] init];
        _customTableView.backgroundColor = [UIColor clearColor];
        _customTableView.dataSource = self;
        _customTableView.delegate = self;
        _customTableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _customTableView.showsVerticalScrollIndicator = NO;
        _customTableView.showsHorizontalScrollIndicator = NO;
        
        

    }
    return _customTableView;
}

- (UIImageView *)backImageV{
    if(!_backImageV ){
        _backImageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_bg"]];
    }
    return _backImageV;
}
-(UIView *)header{
    if (!_header) {
        _header = [UIView new];
        UIView *contentV = [UIView new];
        contentV.backgroundColor = [UIColor clearColor];
        [_header addSubview:contentV];
        __weak __typeof(self) weakSelf = self;
        
        [contentV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(weakSelf.header);
        }];
        
        _iconImageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_sex"]];
        [contentV addSubview:_iconImageV];
        [_iconImageV mas_makeConstraints:^(MASConstraintMaker *make) {
           make.centerX.mas_equalTo(contentV);
           make.height.width.mas_equalTo(Adaptor_Value(100));
           make.top.mas_equalTo(Adaptor_Value(50));
        }];
        
        _tfBackView = [UIView new];
        _tfBackView.backgroundColor = TitleWhiteColor;
        [contentV addSubview:_tfBackView];
        [_tfBackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(contentV);
            make.left.mas_equalTo(Adaptor_Value(20));
            make.top.mas_equalTo(weakSelf.iconImageV.mas_bottom).offset(Adaptor_Value(40));
        }];
        ViewRadius(_tfBackView, 15);
        
        _tipLable = [UILabel lableWithText:lqStrings(@"绑定手机号") textColor:ThemeBlackColor fontSize:AdaptedFontSize(18) lableSize:CGRectZero textAliment:NSTextAlignmentCenter numberofLines:0];
        [_tfBackView addSubview:_tipLable];
        [_tipLable mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerX.mas_equalTo(weakSelf.tfBackView);
            make.top.mas_equalTo(Adaptor_Value(30));
            
        }];
        
        _wrongTipLable = [UILabel lableWithText:lqStrings(@"") textColor:[UIColor redColor] fontSize:AdaptedFontSize(14) lableSize:CGRectZero textAliment:NSTextAlignmentCenter numberofLines:0];
        [_tfBackView addSubview:_wrongTipLable];
        [_wrongTipLable mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(Adaptor_Value(10));
            make.right.mas_equalTo(weakSelf.tfBackView).offset(-Adaptor_Value(10));

            make.top.mas_equalTo(weakSelf.tipLable.mas_bottom).offset(Adaptor_Value(10));
            
        }];
        
        _seeBtn = [[UIButton alloc] init];
        [_seeBtn addTarget:self action:@selector(seeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_seeBtn setTitleColor:ThemeBlackColor forState:UIControlStateNormal];
        [_seeBtn setImage:[UIImage imageNamed:@"see"] forState:UIControlStateNormal];
        [_seeBtn setImage:[UIImage imageNamed:@"seeOff"] forState:UIControlStateSelected];

        [_tfBackView addSubview:_seeBtn];
        [_seeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(weakSelf.tfBackView).offset(-Adaptor_Value(20));
            make.height.mas_equalTo(Adaptor_Value(50));
            make.top.mas_equalTo(weakSelf.wrongTipLable.mas_bottom).offset(Adaptor_Value(20));
        }];
        
        _pwdTf = [[UITextField alloc] init];
        [_tfBackView addSubview:_pwdTf];
        [_pwdTf mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(weakSelf.seeBtn.mas_left).offset(-Adaptor_Value(10));
            make.height.mas_equalTo(Adaptor_Value(50));
            make.left.mas_equalTo(Adaptor_Value(20));
            make.centerY.mas_equalTo(weakSelf.seeBtn);

        }];
        _pwdTf.textColor = [UIColor blackColor];
        [_pwdTf addTarget:self action:@selector(textFDidChange:) forControlEvents:UIControlEventEditingChanged];
        _pwdTf.placeholder = weakSelf.isFisrtlogin ?lqStrings(@"请输入密码"): lqStrings(@"请设置密码");
        [_pwdTf setPlaceholderColor:TitleGrayColor font:nil];
        _pwdTf.font = AdaptedFontSize(18);

        _forgetBtn = [[UIButton alloc] init];
        [_forgetBtn addTarget:self action:@selector(forgetBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_forgetBtn setTitleColor:ThemeBlackColor forState:UIControlStateNormal];
        _forgetBtn.titleLabel.font = AdaptedFontSize(15);
        [_forgetBtn setTitle:lqStrings(@"忘记密码") forState:UIControlStateNormal];
        [_tfBackView addSubview:_forgetBtn];
        [_forgetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.pwdTf.mas_bottom).offset(Adaptor_Value(10));
            make.height.mas_equalTo(Adaptor_Value(0));
            make.right.mas_equalTo(weakSelf.seeBtn);
        }];
        _forgetBtn.hidden = YES;
        
        _confirmBtn = [[UIButton alloc] init];
        [_confirmBtn addTarget:self action:@selector(confirmBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_confirmBtn setTitleColor:TitleWhiteColor forState:UIControlStateNormal];
        [_confirmBtn setBackgroundColor:ThemeBlackColor];
        _confirmBtn.titleLabel.font = AdaptedFontSize(17);
        [_confirmBtn setTitle:lqStrings(@"下一步") forState:UIControlStateNormal];
        [_tfBackView addSubview:_confirmBtn];
        [_confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_greaterThanOrEqualTo(weakSelf.pwdTf.mas_bottom).offset(Adaptor_Value(20));
            make.top.mas_equalTo(weakSelf.pwdTf.mas_bottom).offset(Adaptor_Value(10));
            make.centerX.mas_equalTo(weakSelf.tfBackView);
            make.height.mas_equalTo(Adaptor_Value(60));
            make.left.mas_equalTo(Adaptor_Value(20));
            make.bottom.mas_equalTo(weakSelf.tfBackView).offset(-Adaptor_Value(30));
        }];
        ViewRadius(_confirmBtn, 10);

    

    }
    return _header;
}

@end

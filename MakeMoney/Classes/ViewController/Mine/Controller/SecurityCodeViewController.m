//
//  SecurityCodeViewController.m
//  MakeMoney
//
//  Created by rabi on 2020/3/6.
//  Copyright © 2020 lqq. All rights reserved.
//  安全码设置

#import "SecurityCodeViewController.h"
#import "MineApi.h"
#import "MineItem.h"
@interface SecurityCodeViewController ()<UITextViewDelegate>
@property (nonatomic,strong)UIView *header;
@property (nonatomic,strong)UITextView *codeTV;
@property (nonatomic,strong)UILabel *tipLabel;
@property (nonatomic,strong)UILabel *textViewPlaceholdLabel;
@property (nonatomic,strong)UIButton *submitBtn;
@end

@implementation SecurityCodeViewController
#pragma mark - 重写
-(void)navigationRightBtnClick:(UIButton*)button{
    //重置
    self.codeTV.text = nil;
}
#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
    self.view.backgroundColor = [UIColor lq_colorWithHexString:@"f4f4f4"];
}

#pragma mark - ui
- (void)configUI{
    __weak __typeof(self) weakSelf = self;
    [self.view addSubview:self.header];
    [self.header mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(NavMaxY);
        make.left.right.mas_equalTo(weakSelf.view);
    }];
    
    //导航栏
    [self addNavigationView];
    self.navigationTextLabel.text = lqStrings(@"安全码设置");
    self.navigationBackButton.hidden = NO;
    [self.navigationRightBtn setTitle:lqStrings(@"重置") forState:UIControlStateNormal];
    [self.navigationRightBtn setTitleColor:TitleWhiteColor forState:UIControlStateNormal];
    [self.navigationRightBtn setTitleColor:TitleGrayColor forState:UIControlStateDisabled];
    self.navigationRightBtn.enabled = NO;
    
}
#pragma mark - act
- (void)confirmBtnClick:(UIButton *)sender{
    
}
#pragma mark uitextView delegate
- (void)textViewDidChange:(UITextView *)textView
{
    NSInteger i = 16;    //限制输入字数
    if (self.codeTV.text.length >= i) {
        self.codeTV.text = [self.codeTV.text substringToIndex:i];
    }
    
    if (self.codeTV.text.length > 0 ) {
        self.navigationRightBtn.enabled = YES;
        self.textViewPlaceholdLabel.hidden = YES;
    }else{
        self.navigationRightBtn.enabled = NO;
        self.textViewPlaceholdLabel.hidden = NO;

    }
}



#pragma mark - net
//检查安全码
- (void)checkCode:(NSString *)code sender:(UIButton *)sender{
    [LSVProgressHUD show];
    __weak __typeof(self) weakSelf = self;
    sender.userInteractionEnabled = NO;
    [MineApi checkSecurityWithsafeCode:code Success:^(NSInteger status, NSString * _Nonnull msg) {
        [weakSelf addCode:code sender:sender];
    } error:^(NSError *error, id resultObject) {
        sender.userInteractionEnabled = YES;
        [LSVProgressHUD showError:error];

    }];
}

//添加安全码
- (void)addCode:(NSString *)code sender:(UIButton *)sender{
    __weak __typeof(self) weakSelf = self;
    [MineApi addSecurityWithsafeCode:code Success:^(NSInteger status, NSString * _Nonnull msg) {
        sender.userInteractionEnabled = YES;
        [LSVProgressHUD showInfoWithStatus:msg];
    } error:^(NSError *error, id resultObject) {
        sender.userInteractionEnabled = YES;
        [LSVProgressHUD showError:error];
    }];
    
}

//重置安全码
- (void)resetCodeWith:(UIButton *)sender{
    __weak __typeof(self) weakSelf = self;
    sender.userInteractionEnabled = NO;
    [LSVProgressHUD show];
    [MineApi resetSecuritySuccess:^(NSInteger status, NSString * _Nonnull msg) {
        sender.userInteractionEnabled = YES;
        [LSVProgressHUD showInfoWithStatus:msg];

    } error:^(NSError *error, id resultObject) {
        sender.userInteractionEnabled = YES;
        [LSVProgressHUD showError:error];

    }];
    
}

#pragma mark - lazy
- (UIView *)header{
    if (!_header) {
        _header = [UIView new];
        UIView *contentV = [UIView new];
        __weak __typeof(self) weakSelf = self;
        [_header addSubview:contentV];
        [contentV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(weakSelf.header);
        }];
        
        UIView *tfBackView = [UIView new];
        tfBackView.backgroundColor= TitleWhiteColor;
        [contentV addSubview:tfBackView];
        [tfBackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(Adaptor_Value(10));
            make.left.right.mas_equalTo(contentV);
            make.height.mas_equalTo(Adaptor_Value(55));
            
        }];
        
        _codeTV = [[UITextView alloc] init];
        [tfBackView addSubview:_codeTV];
        [_codeTV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(tfBackView);
            make.height.mas_equalTo(Adaptor_Value(30));

            make.left.mas_equalTo(Adaptor_Value(15));
            make.right.mas_equalTo(tfBackView);
        }];
        _codeTV.textColor = [UIColor whiteColor];
        _codeTV.delegate = self;
        _codeTV.font = AdaptedFontSize(15);
        _codeTV.backgroundColor = [UIColor clearColor];
        _codeTV.keyboardType = UIKeyboardTypeNumberPad;
        
        UILabel *textViewPlaceholdLabel = [[UILabel alloc] init];
        textViewPlaceholdLabel.text = lqStrings(@"请输入安全码，由6-16为数字组成");
        textViewPlaceholdLabel.textColor = TitleGrayColor;
        textViewPlaceholdLabel.font = AdaptedFontSize(15);
        textViewPlaceholdLabel.numberOfLines = 0;
        

        [_codeTV addSubview:textViewPlaceholdLabel];
        [textViewPlaceholdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(2);
            make.right.mas_equalTo(weakSelf.codeTV);
            make.top.mas_equalTo(Adaptor_Value(7));
        }];
        self.textViewPlaceholdLabel = textViewPlaceholdLabel;
        
        
        _submitBtn = [[UIButton alloc] init];
        [_submitBtn addTarget:self action:@selector(confirmBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_submitBtn setTitleColor:TitleWhiteColor forState:UIControlStateNormal];
        [_submitBtn setBackgroundColor:ThemeBlackColor];
        _submitBtn.titleLabel.font = AdaptedFontSize(17);
        [_submitBtn setTitle:lqStrings(@"提交") forState:UIControlStateNormal];
        [contentV addSubview:_submitBtn];
        [_submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.codeTV.mas_bottom).offset(Adaptor_Value(40));
            make.centerX.mas_equalTo(contentV);
            make.height.mas_equalTo(Adaptor_Value(50));
            make.left.mas_equalTo(Adaptor_Value(40));
        }];
        ViewRadius(_submitBtn, 10);
        
        _tipLabel = [UILabel lableWithText:lqStrings(@"#安全码用途：提现时需要输入安全码，情妥善保管") textColor:CustomRedColor fontSize:AdaptedFontSize(12) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contentV addSubview:_tipLabel];
        [_tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.submitBtn.mas_bottom).offset(Adaptor_Value(15));
            make.centerX.mas_equalTo(Adaptor_Value(15));
            make.bottom.mas_equalTo(contentV);
        }];


    }
    return _header;
}

@end

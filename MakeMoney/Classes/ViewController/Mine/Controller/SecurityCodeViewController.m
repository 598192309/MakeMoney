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
#import "VIPExchangeAlertView.h"
#import "CustomAlertView.h"
@interface SecurityCodeViewController ()<UITextViewDelegate>
@property (nonatomic,strong)UIView *header;
@property (nonatomic,strong)UITextView *codeTV;
@property (nonatomic,strong)UILabel *tipLabel;
@property (nonatomic,strong)UILabel *textViewPlaceholdLabel;
@property (nonatomic,strong)UIButton *submitBtn;

@property (nonatomic,strong)UIButton *modifyBtn;
@property(nonatomic,strong)VIPExchangeAlertView * vipExchangeAlertView;

@property (nonatomic,strong)CustomAlertView *infoAlert;
@end

@implementation SecurityCodeViewController
//#pragma mark - 重写
//-(void)navigationRightBtnClick:(UIButton*)button{
//    //重置
//    [LSVProgressHUD showInfoWithStatus:[button titleForState:UIControlStateNormal]];
//}
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
//    [self.navigationRightBtn setTitle:lqStrings(@"重置") forState:UIControlStateNormal];
//    [self.navigationRightBtn setTitleColor:TitleWhiteColor forState:UIControlStateNormal];
//    [self.navigationRightBtn setTitleColor:TitleGrayColor forState:UIControlStateDisabled];
//    self.navigationRightBtn.hidden = YES;
    [self updateUIWithIsSafeCodeSet:RI.infoInitItem.is_safe_code];
    
}

- (void)updateUIWithIsSafeCodeSet:(BOOL)isSet{
    __weak __typeof(self) weakSelf = self;

    if (isSet) {
        weakSelf.codeTV.text = lqStrings(@"已设置");
        weakSelf.codeTV.editable = NO;
        weakSelf.modifyBtn.hidden = NO;
        [weakSelf.submitBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.codeTV.mas_bottom).offset(Adaptor_Value(5));
            make.height.mas_equalTo(Adaptor_Value(0));
        }];
        weakSelf.textViewPlaceholdLabel.hidden = YES;
//        self.navigationRightBtn.hidden = NO;
        
    }else{
        weakSelf.codeTV.text = @"";
        weakSelf.codeTV.editable = YES;
        weakSelf.modifyBtn.hidden = YES;
        [weakSelf.submitBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.codeTV.mas_bottom).offset(Adaptor_Value(40));
            make.height.mas_equalTo(Adaptor_Value(50));
        }];
        weakSelf.textViewPlaceholdLabel.hidden = NO;
//        self.navigationRightBtn.hidden = YES;

    }
}
#pragma mark - act
- (void)confirmBtnClick:(UIButton *)sender{
    if (self.codeTV.text.length == 0) {
        [LSVProgressHUD showInfoWithStatus:lqStrings(@"请输入安全码")];
        return;
    }
    [self addCode:self.codeTV.text sender:sender];
}

- (void)modifyBtnClick:(UIButton *)sender{
    [[UIApplication sharedApplication].keyWindow addSubview:self.vipExchangeAlertView];
    [self.vipExchangeAlertView refreshContent:lqStrings(@"请输入原安全码")];
    [self.vipExchangeAlertView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo([UIApplication sharedApplication].keyWindow);
    }];
}
#pragma mark uitextView delegate
- (void)textViewDidChange:(UITextView *)textView
{
    NSInteger i = 16;    //限制输入字数
    if (self.codeTV.text.length >= i) {
        self.codeTV.text = [self.codeTV.text substringToIndex:i];
    }
    
    if (self.codeTV.text.length > 0 ) {
        self.textViewPlaceholdLabel.hidden = YES;
    }else{
        self.textViewPlaceholdLabel.hidden = NO;

    }
}


- (void)remindShow:(NSString *)msg msgColor:(UIColor *)msgColor msgFont:(UIFont *)msgFont subMsg:(NSString *)subMsg submsgColor:(UIColor *)submsgColor submsgFont:(UIFont *)submsgFont firstBtnTitle:(NSString *)firstBtnTitle secBtnTitle:(NSString *)secBtnTitle singeBtnTitle:(NSString *)singeBtnTitle{
    //局部变色
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:subMsg];
    if (subMsg.length > 0) {
        NSRange start  = [subMsg rangeOfString:lqStrings(@" 1 ")];
        if (start.length > 0 ) {
            [attr addAttribute:NSForegroundColorAttributeName value:TitleWhiteColor range:NSMakeRange(start.location, start.length)];
        }
    }
    
    [self.infoAlert refreshUIWithAttributeTitle:[[NSAttributedString alloc]initWithString:msg ] titleColor:msgColor titleFont:msgFont titleAliment:NSTextAlignmentCenter attributeSubTitle:attr subTitleColor:submsgColor subTitleFont:submsgFont subTitleAliment:NSTextAlignmentCenter firstBtnTitle:firstBtnTitle firstBtnTitleColor:TitleGrayColor secBtnTitle:secBtnTitle secBtnTitleColor:TitleWhiteColor singleBtnHidden:singeBtnTitle.length == 0 singleBtnTitle:singeBtnTitle singleBtnTitleColor:ThemeBlackColor removeBtnHidden:YES];
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.infoAlert];
    
    [self.infoAlert mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo([UIApplication sharedApplication].keyWindow);
    }];
}

#pragma mark - net
//检查安全码
- (void)checkCode:(NSString *)code sender:(UIButton *)sender{
    [LSVProgressHUD show];
    __weak __typeof(self) weakSelf = self;
    sender.userInteractionEnabled = NO;
    [MineApi checkSecurityWithsafeCode:code Success:^(NSInteger status, NSString * _Nonnull msg) {
        [LSVProgressHUD showInfoWithStatus:msg];
        [[UIApplication sharedApplication].keyWindow addSubview:self.vipExchangeAlertView];
        [weakSelf.vipExchangeAlertView refreshContent:lqStrings(@"请输入新安全码")];
        [weakSelf.vipExchangeAlertView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo([UIApplication sharedApplication].keyWindow);
        }];
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
        RI.infoInitItem.is_safe_code = YES;
        [weakSelf updateUIWithIsSafeCodeSet:YES];
        
        [LSVProgressHUD dismiss];
        [self remindShow: @"" msgColor:[UIColor whiteColor] msgFont:AdaptedFontSize(15) subMsg:[NSString stringWithFormat:lqLocalized(@"安全码设置成功，你的安全码是:\n%@", nil),code] submsgColor:TitleBlackColor submsgFont:AdaptedFontSize(16) firstBtnTitle:nil secBtnTitle:nil singeBtnTitle:lqStrings(@"知道了")];
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
        _codeTV.textColor = ThemeBlackColor;
        _codeTV.delegate = self;
        _codeTV.font = AdaptedFontSize(15);
        _codeTV.backgroundColor = [UIColor clearColor];
        _codeTV.keyboardType = UIKeyboardTypeNumberPad;
        _codeTV.secureTextEntry = YES;
        
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
        
        _modifyBtn = [[UIButton alloc] init];
        [_modifyBtn addTarget:self action:@selector(modifyBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_modifyBtn setTitleColor:TitleGrayColor forState:UIControlStateNormal];
        [_modifyBtn setBackgroundColor:[UIColor clearColor]];
        _modifyBtn.titleLabel.font = AdaptedFontSize(14);
        [_modifyBtn setTitle:lqStrings(@"修改安全码") forState:UIControlStateNormal];
        [tfBackView addSubview:_modifyBtn];
        [_modifyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(tfBackView);
            make.height.mas_equalTo(tfBackView);
            make.right.mas_equalTo(tfBackView).offset(-Adaptor_Value(10));
        }];
        _modifyBtn.hidden = YES;
        
        
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


- (VIPExchangeAlertView *)vipExchangeAlertView{
    if (!_vipExchangeAlertView) {
        _vipExchangeAlertView = [VIPExchangeAlertView new];
        __weak __typeof(self) weakSelf = self;
        
        _vipExchangeAlertView.vipExchangeAlertViewkConfirmBtnClickBlock = ^(UIButton * _Nonnull sender, UITextField * _Nonnull tf) {
            [weakSelf.vipExchangeAlertView removeFromSuperview];
            weakSelf.vipExchangeAlertView = nil;
            if ([tf.placeholder isEqualToString:lqStrings(@"请输入原安全码")]) {
                [weakSelf checkCode:tf.text sender:sender];

            }else{
                [weakSelf addCode:tf.text sender:sender];
            }
        };
        
        _vipExchangeAlertView.vipExchangeAlertViewkCoverViewClickBlock = ^{
            [weakSelf.vipExchangeAlertView removeFromSuperview];
            weakSelf.vipExchangeAlertView = nil;
        };
    }
    return _vipExchangeAlertView;
}
- (CustomAlertView *)infoAlert{
    if (_infoAlert == nil) {
        _infoAlert = [[CustomAlertView alloc] init];
        
        __weak __typeof(self) weakSelf = self;
        _infoAlert.CustomAlertViewBlock = ^(NSInteger index,NSString *str){
            [weakSelf.infoAlert removeFromSuperview];
            weakSelf.infoAlert = nil;
        };
    }
    
    return _infoAlert;
    
}

@end

//
//  WalletCustomView.m
//  MakeMoney
//
//  Created by rabi on 2020/3/3.
//  Copyright © 2020 lqq. All rights reserved.
//

#import "WalletCustomView.h"

@interface WalletCustomView()<UITextFieldDelegate,UITextViewDelegate>
//头部view
@property (nonatomic,strong)UIView *header;

@property (nonatomic,strong)UIView *moneyView;
@property (nonatomic,strong)UILabel *moneyTipLabel;
@property (nonatomic,strong)UILabel *moneyLabel;

@property (nonatomic,strong)UILabel *tipLabel;

@property (nonatomic,strong)UIView *textFBackView;
@property (nonatomic,strong)UILabel *tixianTypeTipLable;
@property (nonatomic,strong)UITextField *tixianTypeTextF;

@property (nonatomic,strong)UILabel *feeTipLabel;
@property (nonatomic,strong)UITextField *feeTf;


@property (nonatomic,strong)UILabel *accontNameTipLabel;//宣传
@property (nonatomic,strong)UITextField *accontNameTf;

@property (nonatomic,strong)UILabel *bankcardTipLabel;
@property (nonatomic,strong)UITextField *bankcardTf;

@property (nonatomic,strong)UILabel *cashAmountTipLabel;
@property (nonatomic,strong)UITextField *cashAmountTf;

@property (nonatomic,strong)UILabel *securityTipLabel;
@property (nonatomic,strong)UITextField *securityTf;

@property (nonatomic,strong)UIButton *confirmBtn;


@property (nonatomic,strong)UIView *bottomView;
@property (nonatomic,strong)UILabel *bottomTitleLable;
@property (nonatomic,strong)UILabel *bottomTipLable1;
@property (nonatomic,strong)UILabel *bottomTipLable2;
@property (nonatomic,strong)UILabel *bottomTipLable3;
@end
@implementation WalletCustomView

#pragma mark - 生命周期
-(instancetype)init{
    if (self = [super init]) {
        [self configUI];
        
    }
    return self;
}
#pragma mark - ui
-(void)configUI{
    __weak __typeof(self) weakSelf = self;

    [self addSubview:self.header];
    [self.header mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(weakSelf);
    }];
    
    [self addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(weakSelf);
        make.top.mas_equalTo(weakSelf.header.mas_bottom);
    }];
}

#pragma mark - 刷新ui
#pragma mark - act
- (void)confirmBtnClick:(UIButton *)sender{
    
}



#pragma  mark - UITextField delegate
- (void)textFDidChange:(UITextField *)textf{

}


#pragma mark - lazy
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
        
        _moneyView = [UIView new];
        _moneyView.backgroundColor = TitleWhiteColor;
        [contentV addSubview:_moneyView];
        [_moneyView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(Adaptor_Value(15));
            make.right.mas_equalTo(contentV).offset(-Adaptor_Value(15));
            make.height.mas_equalTo(Adaptor_Value(100));
            make.top.mas_equalTo(Adaptor_Value(20));
        }];
        ViewRadius(_moneyView, 20);
        
        _moneyTipLabel = [UILabel lableWithText:lqStrings(@"账户余额(元)") textColor:TitleBlackColor fontSize:AdaptedBoldFontSize(18) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [_moneyView addSubview:_moneyTipLabel];
        [_moneyTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(Adaptor_Value(25));
            make.left.mas_equalTo(Adaptor_Value(25));
        }];
        
        _moneyLabel = [UILabel lableWithText:lqStrings(@"0") textColor:TitleBlackColor fontSize:AdaptedBoldFontSize(20) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [_moneyView addSubview:_moneyLabel];
        [_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.moneyTipLabel.mas_bottom).offset(Adaptor_Value(10));
            make.left.mas_equalTo(weakSelf.moneyTipLabel);
        }];
        
        
        _tipLabel = [UILabel lableWithText:lqStrings(@"(*余额可用于提现或观看付费视频*)") textColor:TitleGrayColor fontSize:AdaptedFontSize(16) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contentV addSubview:_tipLabel];
        [_tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.moneyView.mas_bottom).offset(Adaptor_Value(10));
            make.left.mas_equalTo(weakSelf.moneyView);
        }];
        
        _textFBackView = [UIView new];
        _textFBackView.backgroundColor = TitleWhiteColor;
        [contentV addSubview:_textFBackView];
        [_textFBackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.tipLabel.mas_bottom).offset(Adaptor_Value(25));
            make.left.mas_equalTo(weakSelf.tipLabel);
            make.right.mas_equalTo(contentV).offset(-Adaptor_Value(15));
        }];
        ViewRadius(_textFBackView, 20);
        
        _tixianTypeTipLable = [UILabel lableWithText:lqStrings(@"提现方式") textColor:TitleBlackColor fontSize:AdaptedFontSize(17) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [_textFBackView addSubview:_tixianTypeTipLable];
        [_tixianTypeTipLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(Adaptor_Value(20));
            make.left.mas_equalTo(Adaptor_Value(15));

        }];
        
        
        _tixianTypeTextF = [[UITextField alloc] init];
        [_textFBackView addSubview:_tixianTypeTextF];
        [_tixianTypeTextF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(weakSelf.textFBackView).offset(-Adaptor_Value(20));
            make.height.mas_equalTo(Adaptor_Value(35));
            make.centerY.mas_equalTo(weakSelf.tixianTypeTipLable);
            
        }];
        _tixianTypeTextF.textColor = [UIColor blackColor];
        [_tixianTypeTextF addTarget:self action:@selector(textFDidChange:) forControlEvents:UIControlEventEditingChanged];
        _tixianTypeTextF.text = lqStrings(@"银行卡");
        _tixianTypeTextF.enabled = NO;
        _tixianTypeTextF.font = AdaptedBoldFontSize(17);


        
        _feeTipLabel = [UILabel lableWithText:lqLocalized(@"提现手续费", nil) textColor:TitleBlackColor fontSize:AdaptedFontSize(17) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [_textFBackView addSubview:_feeTipLabel];
        [_feeTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.tixianTypeTipLable.mas_bottom).offset(Adaptor_Value(20));
            make.left.mas_equalTo(weakSelf.tixianTypeTipLable);
            
        }];
        
        _feeTf = [[UITextField alloc] init];
        [_textFBackView addSubview:_feeTf];
        [_feeTf mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(Adaptor_Value(35));
            make.right.mas_equalTo(weakSelf.tixianTypeTextF);
            make.centerY.mas_equalTo(weakSelf.feeTipLabel);

        }];
        _feeTf.textColor = [UIColor blackColor];
        _feeTf.text = lqStrings(@"5%");
        _feeTf.enabled = NO;
        _feeTf.font = AdaptedBoldFontSize(17);
        
        
        _accontNameTipLabel = [UILabel lableWithText:lqStrings(@"收款人姓名") textColor:TitleBlackColor fontSize:AdaptedFontSize(17) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [_textFBackView addSubview:_accontNameTipLabel];
        [_accontNameTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.feeTipLabel.mas_bottom).offset(Adaptor_Value(20));
            make.left.mas_equalTo(weakSelf.tixianTypeTipLable);
        }];
        
        _accontNameTf = [[UITextField alloc] init];
        [_textFBackView addSubview:_accontNameTf];
        [_accontNameTf mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(Adaptor_Value(35));
            make.right.mas_equalTo(weakSelf.tixianTypeTextF);
            make.centerY.mas_equalTo(weakSelf.accontNameTipLabel);
            make.width.mas_lessThanOrEqualTo(Adaptor_Value(200));


        }];
        _accontNameTf.textColor = [UIColor blackColor];
        [_accontNameTf addTarget:self action:@selector(textFDidChange:) forControlEvents:UIControlEventEditingChanged];
        _accontNameTf.placeholder = lqStrings(@"请输入收款人姓名");
        // "通过KVC修改placeholder的颜色"
//        [_accontNameTf setValue:TitleGrayColor forKeyPath:@"_placeholderLabel.textColor"];
        [_accontNameTf setPlaceholderColor:TitleGrayColor font:nil];
        _accontNameTf.font = AdaptedBoldFontSize(17);
        _accontNameTf.textAlignment = NSTextAlignmentRight;
        
        _bankcardTipLabel = [UILabel lableWithText:lqStrings(@"银行卡账号") textColor:TitleBlackColor fontSize:AdaptedFontSize(17) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [_textFBackView addSubview:_bankcardTipLabel];
        [_bankcardTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.accontNameTipLabel.mas_bottom).offset(Adaptor_Value(20));
            make.left.mas_equalTo(weakSelf.tixianTypeTipLable);
        }];
        
        _bankcardTf = [[UITextField alloc] init];
        [_textFBackView addSubview:_bankcardTf];
        [_bankcardTf mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(Adaptor_Value(35));
            make.right.mas_equalTo(weakSelf.tixianTypeTextF);
            make.centerY.mas_equalTo(weakSelf.bankcardTipLabel);
            make.width.mas_lessThanOrEqualTo(Adaptor_Value(200));

        }];
        _bankcardTf.textColor = [UIColor blackColor];
        [_bankcardTf addTarget:self action:@selector(textFDidChange:) forControlEvents:UIControlEventEditingChanged];
        _bankcardTf.textAlignment = NSTextAlignmentRight;

        
        _bankcardTf.placeholder = lqStrings(@"请输入银行账号");
        // "通过KVC修改placeholder的颜色"
//        [_accontNameTf setValue:TitleGrayColor forKeyPath:@"_placeholderLabel.textColor"];
        [_bankcardTf setPlaceholderColor:TitleGrayColor font:nil];
        _bankcardTf.font = AdaptedBoldFontSize(17);
        
        _cashAmountTipLabel = [UILabel lableWithText:lqStrings(@"提现金额") textColor:TitleBlackColor fontSize:AdaptedFontSize(17) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [_textFBackView addSubview:_cashAmountTipLabel];
        [_cashAmountTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.bankcardTipLabel.mas_bottom).offset(Adaptor_Value(20));
            make.left.mas_equalTo(weakSelf.tixianTypeTipLable);
        }];
        
        _cashAmountTf = [[UITextField alloc] init];
        [_textFBackView addSubview:_cashAmountTf];
        [_cashAmountTf mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(Adaptor_Value(35));
            make.right.mas_equalTo(weakSelf.tixianTypeTextF);
            make.centerY.mas_equalTo(weakSelf.cashAmountTipLabel);
            make.width.mas_lessThanOrEqualTo(Adaptor_Value(200));

        }];
        _cashAmountTf.textColor = [UIColor blackColor];
        [_cashAmountTf addTarget:self action:@selector(textFDidChange:) forControlEvents:UIControlEventEditingChanged];
        _cashAmountTf.textAlignment = NSTextAlignmentRight;

        _cashAmountTf.placeholder = lqStrings(@"请输入大于100的整数倍");
        // "通过KVC修改placeholder的颜色"
//        [_accontNameTf setValue:TitleGrayColor forKeyPath:@"_placeholderLabel.textColor"];
        [_cashAmountTf setPlaceholderColor:TitleGrayColor font:nil];
        _cashAmountTf.font = AdaptedBoldFontSize(17);
        _cashAmountTf.keyboardType = UIKeyboardTypeNumberPad;
      
        
        _securityTipLabel = [UILabel lableWithText:lqStrings(@"安全码") textColor:TitleBlackColor fontSize:AdaptedFontSize(17) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [_textFBackView addSubview:_securityTipLabel];
        [_securityTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.cashAmountTipLabel.mas_bottom).offset(Adaptor_Value(20));
            make.left.mas_equalTo(weakSelf.tixianTypeTipLable);
        }];
        
        _securityTf = [[UITextField alloc] init];
        [_textFBackView addSubview:_securityTf];
        [_securityTf mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(Adaptor_Value(35));
            make.right.mas_equalTo(weakSelf.tixianTypeTextF);
            make.centerY.mas_equalTo(weakSelf.securityTipLabel);
            make.bottom.mas_equalTo(weakSelf.textFBackView).offset(-Adaptor_Value(20));
            make.width.mas_lessThanOrEqualTo(Adaptor_Value(200));
        }];
        _securityTf.textColor = [UIColor blackColor];
        [_securityTf addTarget:self action:@selector(textFDidChange:) forControlEvents:UIControlEventEditingChanged];

        _securityTf.placeholder = lqStrings(@"请输入安全码");
        // "通过KVC修改placeholder的颜色"
//        [_accontNameTf setValue:TitleGrayColor forKeyPath:@"_placeholderLabel.textColor"];
        [_securityTf setPlaceholderColor:TitleGrayColor font:nil];
        _securityTf.font = AdaptedBoldFontSize(17);
        _securityTf.textAlignment = NSTextAlignmentRight;

        _confirmBtn = [[UIButton alloc] init];
        [_confirmBtn addTarget:self action:@selector(confirmBtnClick:) forControlEvents:UIControlEventTouchDown];
        [_confirmBtn setTitleColor:TitleWhiteColor forState:UIControlStateNormal];
        _confirmBtn.backgroundColor = ThemeBlackColor;
        [_confirmBtn setTitle:lqStrings(@"提交申请") forState:UIControlStateNormal];
        _confirmBtn.titleLabel.font = AdaptedFontSize(15);
        [contentV addSubview:_confirmBtn];
        [_confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(Adaptor_Value(15));
            make.right.mas_equalTo(contentV).offset(-Adaptor_Value(15));
            make.height.mas_equalTo(Adaptor_Value(50));
            make.top.mas_equalTo(weakSelf.textFBackView.mas_bottom).offset(Adaptor_Value(30));
            make.bottom.mas_equalTo(contentV).offset(-Adaptor_Value(30));
        }];
        ViewRadius(_confirmBtn, 10);
        
        
    }
    return _header;
}


- (UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [UIView new];
        _bottomView.backgroundColor = [UIColor clearColor];
        __weak __typeof(self) weakSelf = self;
        UIView *contentV = [UIView new];
        contentV.backgroundColor = [UIColor clearColor];
        [_bottomView addSubview:contentV];
            
        [contentV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(weakSelf.bottomView);
        }];
        
        _bottomTitleLable = [UILabel lableWithText:lqLocalized(@"提现规则",nil) textColor:[UIColor whiteColor] fontSize:AdaptedBoldFontSize(20) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contentV addSubview:_bottomTitleLable];
        [_bottomTitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(Adaptor_Value(15));
            make.top.mas_equalTo(Adaptor_Value(15));
        }];
        
        _bottomTipLable1 = [UILabel lableWithText:lqLocalized(@"1.每次提现现金最低100元起,只可提现100的整数倍",nil) textColor:TitleGrayColor fontSize:AdaptedFontSize(15) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contentV addSubview:_bottomTipLable1];
        [_bottomTipLable1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.bottomTitleLable);
            make.top.mas_equalTo(weakSelf.bottomTitleLable.mas_bottom).offset(Adaptor_Value(20));
            make.width.mas_equalTo(LQScreemW - Adaptor_Value(15) *2);
        }];
        

        _bottomTipLable2 = [UILabel lableWithText:lqLocalized(@"2.每次提现收取5%手续费",nil) textColor:TitleGrayColor fontSize:AdaptedFontSize(15) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contentV addSubview:_bottomTipLable2];
        [_bottomTipLable2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(weakSelf.bottomTipLable1);
            make.top.mas_equalTo(weakSelf.bottomTipLable1.mas_bottom).offset(Adaptor_Value(5));
        }];
        
        _bottomTipLable3 = [UILabel lableWithText:lqLocalized(@"3.仅支持银行卡提现,收款账户卡号和姓名必须一致,到账时间为1-2个工作日",nil) textColor:TitleGrayColor fontSize:AdaptedFontSize(15) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contentV addSubview:_bottomTipLable3];
        [_bottomTipLable3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(weakSelf.bottomTipLable2);
            make.top.mas_equalTo(weakSelf.bottomTipLable2.mas_bottom).offset(Adaptor_Value(5));
            make.bottom.mas_equalTo(contentV).offset(-Adaptor_Value(40));
        }];

    }
    return _bottomView;
}
@end

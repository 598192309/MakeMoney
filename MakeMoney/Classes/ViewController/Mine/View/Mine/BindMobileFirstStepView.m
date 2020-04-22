//
//  BindMobileFirstStepView.m
//  MakeMoney
//
//  Created by rabi on 2020/3/6.
//  Copyright © 2020 lqq. All rights reserved.
//

#import "BindMobileFirstStepView.h"

@interface BindMobileFirstStepView()
//头部view
@property (nonatomic,strong)UIView *header;
@property (nonatomic,strong)UIImageView *iconImageV;

@property (nonatomic,strong)UIView *tfBackView;
@property (nonatomic,strong)UILabel *tipLable;
@property (nonatomic,strong)UILabel *mobileTipLable;

@property (nonatomic,strong)UITextField *mobileTf;
@property (nonatomic,strong)UIButton *confirmBtn;

@end
@implementation BindMobileFirstStepView
#pragma mark - setter
- (void)setIsFindBackPwd:(BOOL)isFindBackPwd{
    _isFindBackPwd = isFindBackPwd;
    self.tipLable.text = lqStrings(@"找回密码");
    self.mobileTf.placeholder = lqStrings(@"请输入绑定的手机号码");
}
#pragma mark - 生命周期
-(instancetype)init{
    if (self = [super init]) {
        [self configUI];

    }
    return self;
}
#pragma mark - ui
-(void)configUI{
    [self addSubview:self.header];
    __weak __typeof(self) weakSelf = self;
    [self.header mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weakSelf);
    }];
}


#pragma mark - 刷新ui
- (void)configUIWithItem:(NSObject *)item finishi:(void(^)(void))finishBlock{

    
    finishBlock();
}

#pragma mark - act
- (void)confirmBtnClick:(UIButton *)sender{
    if (self.confirmBtnClickBlock) {
        self.confirmBtnClickBlock(sender,self.mobileTf);
    }
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
        
        _mobileTipLable = [UILabel lableWithText:lqStrings(@"+86") textColor:ThemeBlackColor fontSize:AdaptedFontSize(18) lableSize:CGRectZero textAliment:NSTextAlignmentCenter numberofLines:0];
        [_tfBackView addSubview:_mobileTipLable];
        [_mobileTipLable mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(Adaptor_Value(20));
            make.top.mas_equalTo(weakSelf.tipLable.mas_bottom).offset(Adaptor_Value(30));
        }];
        
        _mobileTf = [[UITextField alloc] init];
        [_tfBackView addSubview:_mobileTf];
        [_mobileTf mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(weakSelf.tfBackView).offset(-Adaptor_Value(20));
            make.height.mas_equalTo(Adaptor_Value(50));
            make.centerY.mas_equalTo(weakSelf.mobileTipLable);
            make.left.mas_equalTo(weakSelf.mobileTipLable.mas_right).offset(Adaptor_Value(10));
            
        }];
        _mobileTf.textColor = [UIColor blackColor];
        [_mobileTf addTarget:self action:@selector(textFDidChange:) forControlEvents:UIControlEventEditingChanged];
        _mobileTf.placeholder = lqStrings(@"请填写手机号");
        [_mobileTf setPlaceholderColor:TitleGrayColor font:nil];
        _mobileTf.font = AdaptedFontSize(18);

        
        
        _confirmBtn = [[UIButton alloc] init];
        [_confirmBtn addTarget:self action:@selector(confirmBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_confirmBtn setTitleColor:TitleWhiteColor forState:UIControlStateNormal];
        [_confirmBtn setBackgroundColor:ThemeBlackColor];
        _confirmBtn.titleLabel.font = AdaptedFontSize(17);
        [_confirmBtn setTitle:lqStrings(@"下一步") forState:UIControlStateNormal];
        [_tfBackView addSubview:_confirmBtn];
        [_confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.mobileTf.mas_bottom).offset(Adaptor_Value(20));
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

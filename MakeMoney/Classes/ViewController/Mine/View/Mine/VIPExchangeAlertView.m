//
//  VIPExchangeAlertView.m
//  MakeMoney
//
//  Created by rabi on 2020/3/4.
//  Copyright © 2020 lqq. All rights reserved.
//  VIP 兑换

#import "VIPExchangeAlertView.h"

@interface VIPExchangeAlertView()
@property (strong, nonatomic)  UIView *alertView;
@property (strong, nonatomic)  UITextField *numberTF;
@property (nonatomic,strong)UIView *lineView;
@property (strong, nonatomic)  UIButton *confirmBtn;
@property (nonatomic, strong)UIView *customCoverView;

@end


@implementation VIPExchangeAlertView

#pragma  mark - 拖拽
#pragma  mark - 类方法
-(instancetype)init{
    if (self = [super init]) {
        [self configUI];
        
    }
    return self;
}


#pragma  mark - smzq

- (void)configUI{

    [self addSubview:self.customCoverView];
    __weak __typeof(self) weakSelf = self;
    [self.customCoverView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weakSelf);
    }];
    
    [self addSubview:self.alertView];
    [self.alertView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(weakSelf);
    }];


    ViewRadius(self.alertView, Adaptor_Value(20));

}
#pragma mark - act
- (void)confirmBtnClick:(UIButton *)sender {
    if (self.vipExchangeAlertViewkConfirmBtnClickBlock) {
        self.vipExchangeAlertViewkConfirmBtnClickBlock(sender,self.numberTF);
    }
}

- (void)tap:(UITapGestureRecognizer *)gest{
    if (self.vipExchangeAlertViewkCoverViewClickBlock) {
        self.vipExchangeAlertViewkCoverViewClickBlock();
    }
}
#pragma mark - lazy
- (UIView *)alertView{
    if (!_alertView) {
        _alertView = [UIView new];
        UIView *contentV = [UIView new];
        contentV.backgroundColor = TitleWhiteColor;
        [_alertView addSubview:contentV];
        __weak __typeof(self) weakSelf = self;
        [contentV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(weakSelf.alertView);
            make.width.mas_equalTo(Adaptor_Value(280));
        }];
        
        _numberTF = [[UITextField alloc] init];
        [contentV addSubview:_numberTF];
        [_numberTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(Adaptor_Value(50));
            make.centerX.mas_equalTo(contentV);
            make.top.mas_equalTo(Adaptor_Value(20));
            make.width.mas_lessThanOrEqualTo(contentV);
        }];
        _numberTF.textColor = [UIColor blackColor];
        _numberTF.placeholder = lqStrings(@"请填写兑换码");
        // "通过KVC修改placeholder的颜色"
//        [_accontNameTf setValue:TitleGrayColor forKeyPath:@"_placeholderLabel.textColor"];
        [_numberTF setPlaceholderColor:TitleGrayColor font:nil];
        _numberTF.font = AdaptedBoldFontSize(17);
        _numberTF.textAlignment = NSTextAlignmentCenter;
      
        _lineView = [UIView new];
        _lineView.backgroundColor = ThemeBlackColor;
        [contentV addSubview:_lineView];
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(Adaptor_Value(20));
            make.right.mas_equalTo(contentV).offset(-Adaptor_Value(20));
            make.height.mas_equalTo(kOnePX);
            make.top.mas_equalTo(weakSelf.numberTF.mas_bottom).offset(Adaptor_Value(10));
        }];
        _confirmBtn = [[UIButton alloc] init];
        [_confirmBtn addTarget:self action:@selector(confirmBtnClick:) forControlEvents:UIControlEventTouchDown];
        [_confirmBtn setTitle:lqStrings(@"确定") forState:UIControlStateNormal];
        [_confirmBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [contentV addSubview:_confirmBtn];
        [_confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.left.mas_equalTo(contentV);
            make.height.mas_equalTo(Adaptor_Value(50));
            make.top.mas_equalTo(weakSelf.lineView.mas_bottom);
            make.bottom.mas_equalTo(contentV);
        }];

        
        


    }
    return _alertView;
}

- (UIView *)customCoverView{
    if (!_customCoverView) {
        _customCoverView = [UIView new];
        _customCoverView.backgroundColor = [UIColor lq_colorWithHexString:@"#14181A" alpha:0.5];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        
        [_customCoverView addGestureRecognizer:tap];

    }
    return _customCoverView;
}


@end

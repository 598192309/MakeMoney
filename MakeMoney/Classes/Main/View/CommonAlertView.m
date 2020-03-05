//
//  CommonAlertView.m
//  MakeMoney
//
//  Created by rabi on 2020/3/4.
//  Copyright © 2020 lqq. All rights reserved.
//

#import "CommonAlertView.h"

@interface CommonAlertView()
@property (strong, nonatomic)  UIView *alertView;
@property (strong, nonatomic)  UILabel *titlelabel;
@property (strong, nonatomic)  UILabel *subLable;

@property (strong, nonatomic)  UIButton *firstBtn;
@property (strong, nonatomic)  UIButton *secBtn;
@property (strong, nonatomic)  UIButton *singleBtn;
@property (nonatomic, strong)UIView *customCoverView;
@property (strong, nonatomic)  UIView *contentView;
@end


@implementation CommonAlertView
- (void)firstBtnClick:(UIButton *)sender {
    if (self.commonAlertViewBlock) {
        self.commonAlertViewBlock(1,[sender titleForState:UIControlStateNormal]);
    }
}
- (void)secBtnClick:(UIButton *)sender {
    if (self.commonAlertViewBlock) {
        self.commonAlertViewBlock(2,[sender titleForState:UIControlStateNormal]);
    }
}
- (void)singleBtnClick:(UIButton *)sender {
    if (self.commonAlertViewBlock) {
        self.commonAlertViewBlock(3,[sender titleForState:UIControlStateNormal]);
    }
}

- (void)tap:(UITapGestureRecognizer *)gest{
    if (self.commonAlertViewBlock) {
        self.commonAlertViewBlock(4,nil);
    }
}

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


    ViewRadius(self.alertView, 5);

}
#pragma mark - ui
- (void)refreshUIWithTitle:(NSString *)title firstBtnTitle:(NSString *)firstBtnTitle secBtnTitle:(NSString *)secBtnTitle singleBtnTitle:(NSString *)singleBtnTitle{
    self.titlelabel.text = title;
    [self.firstBtn setTitle:firstBtnTitle forState:UIControlStateNormal];
    [self.secBtn setTitle:secBtnTitle forState:UIControlStateNormal];
    [self.singleBtn setTitle:singleBtnTitle forState:UIControlStateNormal];
    self.singleBtn.hidden = singleBtnTitle.length == 0;
}
- (void)refreshUIWithTitle:(NSString *)title titlefont:(UIFont *)titlefont titleColor:(UIColor *)titleColor firstBtnTitle:(NSString *)firstBtnTitle secBtnTitle:(NSString *)secBtnTitle singleBtnTitle:(NSString *)singleBtnTitle{
    self.titlelabel.text = title;
    self.titlelabel.font = titlefont;
    self.titlelabel.textColor = titleColor;
    [self.firstBtn setTitle:firstBtnTitle forState:UIControlStateNormal];
    [self.secBtn setTitle:secBtnTitle forState:UIControlStateNormal];
    [self.singleBtn setTitle:singleBtnTitle forState:UIControlStateNormal];
    self.singleBtn.hidden = singleBtnTitle.length == 0;
}

- (void)refreshUIWithTitle:(NSString *)title titlefont:(UIFont *)titlefont titleColor:(UIColor *)titleColor subtitle:(NSString *)subTitle subTitleFont:(UIFont *)subTitleFont subtitleColor:(UIColor *)subtitleColor firstBtnTitle:(NSString *)firstBtnTitle secBtnTitle:(NSString *)secBtnTitle singleBtnTitle:(NSString *)singleBtnTitle{
    self.titlelabel.text = title;
    self.titlelabel.font = titlefont;
    self.titlelabel.textColor = titleColor;
    self.subLable.text = subTitle;
    self.subLable.font = subTitleFont;
    self.subLable.textColor = subtitleColor;
    [self.firstBtn setTitle:firstBtnTitle forState:UIControlStateNormal];
    [self.secBtn setTitle:secBtnTitle forState:UIControlStateNormal];
    [self.singleBtn setTitle:singleBtnTitle forState:UIControlStateNormal];
    self.singleBtn.hidden = singleBtnTitle.length == 0;
    
    if (firstBtnTitle.length == 0 && secBtnTitle.length == 0 && singleBtnTitle.length == 0) {
        [_firstBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);

        }];
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
            make.height.mas_greaterThanOrEqualTo(Adaptor_Value(125));

        }];
        _contentView = contentV;
        _titlelabel = [UILabel lableWithText:@"" textColor:[UIColor blackColor] fontSize:AdaptedBoldFontSize(17) lableSize:CGRectZero textAliment:NSTextAlignmentCenter numberofLines:0];
        [contentV addSubview:_titlelabel];
        [_titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(Adaptor_Value(15));
            make.top.mas_equalTo(Adaptor_Value(20));
            make.right.mas_equalTo(contentV).offset(-Adaptor_Value(15));
        }];
        
    
        
        _subLable = [UILabel lableWithText:@"" textColor:TitleGrayColor fontSize:AdaptedFontSize(12) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contentV addSubview:_subLable];
        [_subLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(weakSelf.titlelabel);
            make.top.mas_equalTo(weakSelf.titlelabel.mas_bottom).offset(Adaptor_Value(5));
            
        }];
    
        
        _firstBtn = [[UIButton alloc] init];
        [_firstBtn addTarget:self action:@selector(firstBtnClick:) forControlEvents:UIControlEventTouchDown];
        [contentV addSubview:_firstBtn];
        [_firstBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(contentV);
            make.right.mas_equalTo(contentV.mas_centerX).offset(- Adaptor_Value(20));
            make.height.mas_equalTo(Adaptor_Value(44));
            make.top.mas_equalTo(weakSelf.subLable.mas_bottom).offset(Adaptor_Value(10));
            make.bottom.mas_equalTo(contentV).offset(-Adaptor_Value(20));
        }];
        [_firstBtn setTitleColor:TitleGrayColor forState:UIControlStateNormal];
        _firstBtn.titleLabel.font = AdaptedFontSize(14);
        
        _secBtn = [[UIButton alloc] init];
        [_secBtn addTarget:self action:@selector(secBtnClick:) forControlEvents:UIControlEventTouchDown];
        [contentV addSubview:_secBtn];
        [_secBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(contentV).offset(-Adaptor_Value(20));
            make.left.mas_equalTo(weakSelf.firstBtn.mas_right);
            make.top.height.mas_equalTo(weakSelf.firstBtn);
        }];
        [_secBtn setTitleColor:TitleWhiteColor forState:UIControlStateNormal];
        _secBtn.titleLabel.font = AdaptedFontSize(14);
        [_secBtn setBackgroundColor:CustomRedColor];
        ViewRadius(_secBtn, Adaptor_Value(22));
        
        _singleBtn = [[UIButton alloc] init];
        [_singleBtn addTarget:self action:@selector(singleBtnClick:) forControlEvents:UIControlEventTouchDown];
        [contentV addSubview:_singleBtn];
        [_singleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(Adaptor_Value(20));
            make.right.mas_equalTo(contentV).offset(-Adaptor_Value(20));
            make.top.height.mas_equalTo(weakSelf.firstBtn);
        }];
        _singleBtn.hidden = YES;
        [_singleBtn setTitleColor:TitleWhiteColor forState:UIControlStateNormal];
        _singleBtn.titleLabel.font = AdaptedFontSize(14);
        [_singleBtn setBackgroundColor:CustomRedColor];
        ViewRadius(_singleBtn, Adaptor_Value(22));

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

- (NSString *)titleStr{
//    return self.titlelabel.text.length > 0 ? self.titlelabel.text : self.subLable.text;
    NSString * str ;
    if (self.titlelabel.text.length > 0) {
        str = self.titlelabel.text;
    }else if (self.subLable.text.length > 0){
        str = self.subLable.text;
    }else if (self.titlelabel.attributedText.string.length > 0 ){
        str = self.titlelabel.attributedText.string;
    }else if (self.subLable.attributedText.string.length > 0 ){
        str = self.subLable.attributedText.string;
    }
    return str;
}
@end

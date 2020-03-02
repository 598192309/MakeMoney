//
//  NoticeAlertView.m
//  MakeMoney
//
//  Created by rabi on 2020/3/2.
//  Copyright © 2020 lqq. All rights reserved.
//

#import "NoticeAlertView.h"

@interface NoticeAlertView()
@property (strong, nonatomic)  UIView *alertView;
@property (nonatomic,strong)UIImageView *iconImageV;
@property (strong, nonatomic)  UILabel *titlelabel;
@property (strong, nonatomic)  UILabel *subLable;

@property (strong, nonatomic)  UIButton *singleBtn;
@property (nonatomic, strong)   UIView *customCoverView;
@property (strong, nonatomic)  UIView *contentView;
@end


@implementation NoticeAlertView

- (void)singleBtnClick:(UIButton *)sender {
    if (self.noticeAlertViewBlock) {
        self.noticeAlertViewBlock(sender);
    }
}
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
    
}
-(void)refreshUIWithTitle:(NSString *)title  subTitle:(NSString *)subTitle{
    self.titlelabel.text = title;
    self.subLable.text = subTitle;
}

#pragma mark - lazy
- (UIView *)alertView{
    if (!_alertView) {
        _alertView = [UIView new];
        _alertView.backgroundColor = [UIColor clearColor];
        __weak __typeof(self) weakSelf = self;

        _iconImageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"systom_notice_chunjie_icon"]];
        [_alertView addSubview:_iconImageV];
        [_iconImageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.width.mas_equalTo(Adaptor_Value(100));
            make.centerX.top.mas_equalTo(weakSelf.alertView);
        }];
        
        UIView *contentV = [UIView new];
        contentV.backgroundColor = [UIColor redColor];
        [_alertView insertSubview:contentV belowSubview:weakSelf.iconImageV];
        [contentV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(weakSelf.alertView);
            make.width.mas_equalTo(Adaptor_Value(300));
            make.top.mas_equalTo(weakSelf.iconImageV.mas_centerY);
        }];
        _contentView = contentV;
        
        _titlelabel = [UILabel lableWithText:@"" textColor:LightYellowColor fontSize:AdaptedBoldFontSize(25) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contentV addSubview:_titlelabel];
        [_titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(contentV);
            make.top.mas_equalTo(Adaptor_Value(50));
        }];
        
       

        
        _subLable = [UILabel lableWithText:@"" textColor:TitleWhiteColor fontSize:AdaptedFontSize(14) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contentV addSubview:_subLable];
        [_subLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(Adaptor_Value(15));
            make.top.mas_equalTo(weakSelf.titlelabel.mas_bottom).offset(Adaptor_Value(20));
            make.right.mas_equalTo(contentV).offset(-Adaptor_Value(15));
            
        }];
        
        
        _singleBtn = [[UIButton alloc] init];
        [_singleBtn addTarget:self action:@selector(singleBtnClick:) forControlEvents:UIControlEventTouchDown];
        [_singleBtn setTitleColor:CustomRedColor forState:UIControlStateNormal];
        _singleBtn.backgroundColor = LightYellowColor;
        [_singleBtn setTitle:lqStrings(@"好的") forState:UIControlStateNormal];
        _singleBtn.titleLabel.font = AdaptedFontSize(15);
        [contentV addSubview:_singleBtn];
        [_singleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(contentV);
            make.width.mas_equalTo(Adaptor_Value(200));
            make.height.mas_equalTo(Adaptor_Value(40));
            make.top.mas_equalTo(weakSelf.subLable.mas_bottom).offset(Adaptor_Value(40));
            make.bottom.mas_equalTo(contentV).offset(-Adaptor_Value(30));
        }];
        ViewRadius(_singleBtn, Adaptor_Value(20));

        ViewBorderRadius(contentV,40, 3, LightYellowColor);

    }
    return _alertView;
}

- (UIView *)customCoverView{
    if (!_customCoverView) {
        _customCoverView = [UIView new];
        _customCoverView.backgroundColor = [UIColor lq_colorWithHexString:@"#14181A" alpha:0.5];
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
//
//        [_customCoverView addGestureRecognizer:tap];

    }
    return _customCoverView;
}

@end